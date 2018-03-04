//
//  ProductListViewController.swift
//  AppCamera
//
//  Created by If Only on 3/3/18.
//  Copyright © 2018 Gnuh Nav Inc. All rights reserved.
//

import UIKit

class ProductListViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Variable
    var isFirstLoad = true
    var products: [Product] = [
        Product(id: "01", name: "Mew", price: "12.122.000", image: #imageLiteral(resourceName: "mew")),
        Product(id: "02", name: "Meowth", price: "69.238.000", image: #imageLiteral(resourceName: "meowth")),
        Product(id: "03", name: "Caterpie", price: "33.111.000", image: #imageLiteral(resourceName: "caterpie")),
        Product(id: "04", name: "Squirtle", price: "44.222.000", image: #imageLiteral(resourceName: "squirtle")),
        Product(id: "05", name: "Charmander", price: "66.333.000", image: #imageLiteral(resourceName: "charmander")),
        Product(id: "06", name: "Pikachu", price: "88.555.000", image: #imageLiteral(resourceName: "pikachu")),
        Product(id: "07", name: "Venonat", price: "82.286.000", image: #imageLiteral(resourceName: "venonat")),
        Product(id: "08", name: "Zubat", price: "68.111.000", image: #imageLiteral(resourceName: "zubat")),
        Product(id: "09", name: "Rattata", price: "38.333.000", image: #imageLiteral(resourceName: "rattata")),
        Product(id: "10", name: "Psyduck", price: "36.666.000", image: #imageLiteral(resourceName: "psyduck")),
        Product(id: "11", name: "Mankey", price: "29.999.000", image: #imageLiteral(resourceName: "mankey")),
        Product(id: "12", name: "Bellsprout", price: "28.888.000", image: #imageLiteral(resourceName: "bellsprout")),
        Product(id: "13", name: "Bullbasaur", price: "19.999.000", image: #imageLiteral(resourceName: "bullbasaur")),
        Product(id: "14", name: "Jigglypuff", price: "18.888.000", image: #imageLiteral(resourceName: "jigglypuff")),
        Product(id: "15", name: "Dratini", price: "62.222.000", image: #imageLiteral(resourceName: "dratini")),
        Product(id: "16", name: "Mankey", price: "86.666.000", image: #imageLiteral(resourceName: "pidgey")),
        Product(id: "17", name: "Eevee", price: "92.222.000", image: #imageLiteral(resourceName: "eevee")),
        Product(id: "18", name: "Weedle", price: "35.555.000", image: #imageLiteral(resourceName: "weedle")),
        Product(id: "19", name: "Snorlax", price: "22.222.000", image: #imageLiteral(resourceName: "snorlax")),
        ]
    
    // MARK: - Circle Life
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !isFirstLoad { return }
        isFirstLoad = false
        
        let size = (self.collectionView.bounds.width - 30) / 2
        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: size, height: size)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addProductVC = segue.destination as? AddProductViewController {
            addProductVC.delegate = self
        }
    }

}

extension ProductListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemCellProduct", for: indexPath)
        
        let product = self.products[indexPath.item]
        let imageView = cell.viewWithTag(100) as! UIImageView
        imageView.image = product.image
        let label = cell.viewWithTag(200) as! UILabel
        label.text = product.name
        
        return cell
    }
}

extension ProductListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let addProductVC = self.storyboard?.instantiateViewController(withIdentifier: AddProductViewController.identifier) as? AddProductViewController {
            addProductVC.delegate = self
            addProductVC.product = self.products[indexPath.row]
            self.navigationController?.pushViewController(addProductVC, animated: true)
        }
    }
}

extension ProductListViewController: AddProductViewControllerDelegate {
    func addNewProduct(product: Product) {
        var pd = product
        pd.id = "\(self.products.count + 1)"
        self.products.append(pd)
        self.collectionView.reloadData()
    }
    
    func updateProduct(product: Product) {
        for i in 0..<self.products.count {
            if self.products[i].id == product.id {
                self.products[i] = product
                let indexPath = IndexPath(item: i, section: 0)
                self.collectionView.reloadItems(at: [indexPath])
                break
            }
        }
    }
}





