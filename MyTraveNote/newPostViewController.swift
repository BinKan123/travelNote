//
//  newPostViewController.swift
//  MyTraveNote
//
//  Created by user134225 on 2018-02-20.
//  Copyright © 2018 user134225. All rights reserved.
//

import UIKit
import Firebase

class newPostViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate{

    @IBOutlet weak var postText: UITextView!
    
    @IBOutlet weak var imageCollection: UICollectionView!
    
    @IBAction func showPopUp(_ sender: Any) {
        let  popUpView = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "photoOptionID") as! popUpViewController
        self.addChildViewController(popUpView)
        popUpView.view.frame = self.view.frame
        self.view.addSubview(popUpView.view)
        popUpView.didMove(toParentViewController: self)
    }
   
    var ref:DatabaseReference?
    let uid=Auth.auth().currentUser?.uid
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArrayInCreate.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellImage",for:indexPath)
            as! newCollectionViewCell
        
        cell.imageToSave.image = imageArrayInCreate[indexPath.row]
        
        return cell
    }
    
    @IBAction func currentLocation(_ sender: Any) {
        self.performSegue(withIdentifier: "pickLocation", sender: self)
        
    }
    
    @IBAction func savePost(_ sender: Any) {
        
        let newPostRef = Database.database().reference().child("photoPosts").child(self.uid!).childByAutoId()
        let newPostKey = newPostRef.key
        
       // if let imageData = UIImageJPEGRepresentation(self.collectionView.cell.imageToSave.image!, 0.6){
       /*     let imageStorageRef = Storage.storage().reference().child("images")
            let newImageRef = imageStorageRef.child(newPostKey)
            
            newImageRef.putData(imageData).observe(.success, handler: { (snapshot) in
                let  imageDownloadURL = snapshot.metadata?.downloadURL()?.absoluteString
                let newPostDictionary = [
                    "imageDownloadURL": imageDownloadURL,
                    "postText": self.postText.text
                ]
                newPostRef.setValue(newPostDictionary)
                
            })
        }*/
        
        //show it's saved
        let alert = UIAlertController(title: "Yeah!", message: "New post is saved", preferredStyle: UIAlertControllerStyle.alert)
        
        let cancel = UIAlertAction(title: "See my photo list", style: UIAlertActionStyle.cancel, handler: { action in
            //run your function here
            self.performSegue(withIdentifier: "back2MainList", sender: self)
            
        })
        
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
