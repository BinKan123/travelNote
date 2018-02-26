//
//  createViewController.swift
//  MyTraveNote
//
//  Created by user134225 on 2018-02-07.
//  Copyright © 2018 user134225. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import Firebase

class createViewController: UIViewController,UITextViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var saveBtn: UIBarButtonItem!
    
    @IBOutlet weak var textPost: UITextView!
    
    
    @IBOutlet weak var photoSource: UISegmentedControl!
    
    
    var ref:DatabaseReference?
    let uid=Auth.auth().currentUser?.uid
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    //self.textPost.placeholder = "What's on your mind?"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func chooseOption(_ sender: Any) {
        switch photoSource.selectedSegmentIndex
        {
        case 0:
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                print("Button capture")
                
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;             imagePicker.allowsEditing = false
                
                self.present(imagePicker, animated: true, completion: nil)
            }
        case 1:
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePicker.delegate = self
                imagePicker.sourceType = .camera
                imagePicker.cameraCaptureMode = .photo
                
                imagePicker.allowsEditing = false
                self.present(imagePicker, animated: true, completion: nil)
            }
        case 2:
            print("now clicked video")
            //performSegue(withIdentifier: "toVideo", sender: self)
        default:
            break
        }
    }
    
    //pick from gallery
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        self.dismiss(animated: true, completion: { () -> Void in
            
        })
        
        imgView.image = image
    }
    
    //show taken picture
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imgView.image = info[UIImagePickerControllerOriginalImage] as? UIImage

        imagePicker.dismiss(animated:true, completion: nil)
    }
   
    @IBAction func savePic(_ sender: Any) {
        
        let newPostRef = Database.database().reference().child("photoPosts").child(self.uid!).childByAutoId()
        let newPostKey = newPostRef.key
        
        if let imageData = UIImageJPEGRepresentation(imgView.image!, 0.6){
            let imageStorageRef = Storage.storage().reference().child("images")
            let newImageRef = imageStorageRef.child(newPostKey)
            
            newImageRef.putData(imageData).observe(.success, handler: { (snapshot) in
                let  imageDownloadURL = snapshot.metadata?.downloadURL()?.absoluteString
                let newPostDictionary = [
                    "imageDownloadURL": imageDownloadURL,
                    "postText": self.textPost.text
                ]
                newPostRef.setValue(newPostDictionary)
                
            })
    }
        //show it's saved
        let alert = UIAlertController(title: "Yeah!", message: "New post is saved", preferredStyle: UIAlertControllerStyle.alert)
        
        let cancel = UIAlertAction(title: "See my photo list", style: UIAlertActionStyle.cancel, handler: { action in
            //run your function here
            self.performSegue(withIdentifier: "backToMain", sender: self)
            
        })
        
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func currentAddress(_ sender: Any) {

        performSegue(withIdentifier: "toMap", sender: self)
        
    }
    
    
    //dismiss keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textPost.resignFirstResponder()
       
    }
    
}
