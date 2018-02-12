//
//  createViewController.swift
//  MyTraveNote
//
//  Created by user134225 on 2018-02-07.
//  Copyright © 2018 user134225. All rights reserved.
//

import UIKit
import  AVFoundation
import AVKit

class createViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var saveBtn: UIBarButtonItem!
    var imagePicker = UIImagePickerController()
    
    @IBOutlet weak var photoSource: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func chooseOption(_ sender: Any) {
        switch photoSource.selectedSegmentIndex
        {
        case 0:
            if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
                print("Button capture")
                
                imagePicker.delegate = self
                imagePicker.sourceType = .savedPhotosAlbum;
                imagePicker.allowsEditing = false
                
                self.present(imagePicker, animated: true, completion: nil)
            }
        case 1:
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePicker.delegate = self
                imagePicker.sourceType = .camera;
                imagePicker.allowsEditing = false
                self.present(imagePicker, animated: true, completion: nil)
            }
        case 2:
            performSegue(withIdentifier: "toVideo", sender: self)
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
        if let img =  imgView.image {
            UIImageWriteToSavedPhotosAlbum( img , nil, nil, nil)
        }
        
    }
    
    @IBAction func currentAddress(_ sender: Any) {

        performSegue(withIdentifier: "toMap", sender: self)
        
    }
    
    
}
