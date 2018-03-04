//
//  AddProductViewController.swift
//  AppCamera
//
//  Created by If Only on 3/3/18.
//  Copyright © 2018 Gnuh Nav Inc. All rights reserved.
//

import UIKit

protocol AddProductViewControllerDelegate: class {
//    func handledProduct(type: String, product: Product)
    func addNewProduct(product: Product)
    func updateProduct(product: Product)
}

class AddProductViewController: UIViewController {
    static let identifier = "addProductVC"
    
    // MARK: - IBOutlet
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var productPriceTextField: UITextField!
    @IBOutlet weak var productNameTextField: UITextField!
    @IBOutlet weak var button: UIButton!
    
    weak var delegate: AddProductViewControllerDelegate?
    var imagePicker: UIImagePickerController?
    var product: Product?
    var isFirstLoad = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handledImagePicker(_:)))
        self.imageView.addGestureRecognizer(tapGesture)
        if !isFirstLoad { return }
        isFirstLoad = false
        
        if let product = self.product {
            self.imageView.image = product.image
            self.productPriceTextField.text = product.price
            self.productNameTextField.text = product.name
            self.button.setTitle("Update", for: .normal)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func handledProduct(_ sender: Any) {
        guard let price = self.productPriceTextField.text,
            let name = self.productNameTextField.text,
            let photo = self.imageView.image else {
            return
        }
        
        if name == "" || price == "" {
            return
        }
        // Method 1: Handle in one function
//        if var product = self.product {
//            product.name = name
//            product.price = price
//            product.image = photo
//            self.delegate?.handledProduct(type: "update", product: product)
//        } else {
//            let product = Product(id: "", name: name, price: price, image: photo)
//            self.delegate?.handledProduct(type: "add", product: product)
//        }
        // Method 2: Split to two functions
        if var product = self.product {
            product.name = name
            product.price = price
            product.image = photo
            self.delegate?.updateProduct(product: product)
        } else {
            let product = Product(id: "", name: name, price: price, image: photo)
            self.delegate?.addNewProduct(product: product)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func handledImagePicker(_ gesture: UITapGestureRecognizer) {
        self.setupImagePicker()
        self.showActionSheet()
    }
    
    func showActionSheet() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Take Photo", style: .default, handler: { (_) in
                self.showImagePicker(type: .camera)
            })
            alertController.addAction(cameraAction)
        }
        
        let photoAction = UIAlertAction(title: "Photo", style: .default) { (_) in
            self.showImagePicker(type: .photoLibrary)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(photoAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func setupImagePicker() {
        self.imagePicker = UIImagePickerController()
        self.imagePicker?.delegate = self
        self.imagePicker?.allowsEditing = true
    }
    
    func showImagePicker(type: UIImagePickerControllerSourceType) {
        if let imagePicker = self.imagePicker {
            imagePicker.sourceType = type
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
}

extension AddProductViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            self.imageView.image = image
            self.imagePicker = nil
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.imagePicker = nil
        self.dismiss(animated: true, completion: nil)
    }
}






