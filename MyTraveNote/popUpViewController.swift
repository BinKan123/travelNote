//
//  popUpViewController.swift
//  MyTraveNote
//
//  Created by user134225 on 2018-02-20.
//  Copyright © 2018 user134225. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

public var imageArrayInCreate = [UIImage]()

class popUpViewController: UIViewController,UITextViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func selectPhoto(_ sender: Any) {
        performSegue(withIdentifier:"back2Create",sender:self)
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            print("Button capture")

            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;             imagePicker.allowsEditing = false

            self.present(imagePicker, animated: true, completion: nil)
        }
        //performSegue(withIdentifier:"back2Create",sender:self)
    }

    @IBAction func takePhoto(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.cameraCaptureMode = .photo
            
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func takeVideo(_ sender: Any) {
        
    }
    
    //pick from gallery
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        self.dismiss(animated: true, completion: { () -> Void in

        })

       imageArrayInCreate.append(image)
        print("numbers of pics in imageArrayInCreate is=",imageArrayInCreate.count)

        self.view.removeFromSuperview()

    }
    
    //show taken picture
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
       
    imageArrayInCreate.append((info[UIImagePickerControllerOriginalImage] as? UIImage)!)
        imagePicker.dismiss(animated:true, completion: nil)
        self.view.removeFromSuperview()
        
        
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        var newPost = segue.destination as! newPostViewController
//        func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
//            self.dismiss(animated: true, completion: { () -> Void in
//
//            })
//
//            imageArrayInCreate.append(image)
//            //newPost.imageTest.image = image
//                self.view.removeFromSuperview()
//
//        }
//
//    }
    
    
    @IBAction func closePopUp(_ sender: Any) {
        self.view.removeFromSuperview()
    }
    
   
}
