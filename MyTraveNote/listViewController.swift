//
//  listViewController.swift
//  MyTraveNote
//
//  Created by user134225 on 2018-02-07.
//  Copyright © 2018 user134225. All rights reserved.
//

import UIKit
import Firebase


class listViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate{
 
    @IBOutlet weak var postList: UICollectionView!
   
    @IBAction func toCreate(_ sender: Any) {
     self.performSegue(withIdentifier: "toCreateNew", sender: self)
      
    }
    
    var ref: DatabaseReference?
    var databaseHandle: DatabaseHandle?
    
    
    struct travelNotes{
        var imageURL = ""
        var postText = ""
    }
    var postArray: [travelNotes] = []
   
    let uid=Auth.auth().currentUser?.uid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postList.delegate = self
        postList.dataSource = self
        
        ref = Database.database().reference()
        postArray.removeAll()
        
        //define item size
        let itemSize = UIScreen.main.bounds.width/3-3
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(20, 0, 10, 0)
        layout.itemSize = CGSize(width:itemSize,height:itemSize)
        layout.minimumLineSpacing = 3
        layout.minimumInteritemSpacing = 3
        postList.collectionViewLayout = layout
        
        //retrieve user's own data from database
        databaseHandle = ref?.child("photoPosts").child(uid!).observe(.value,with:{(snapshot) in
            
            if let postNotes = snapshot.value as? [String: AnyObject]{
                
                for (_,postEach) in postNotes{
                    
                    var notes=travelNotes()
                    notes.postText = (postEach["postText"] as? String)!
                    notes.imageURL = (postEach["imageDownloadURL"]  as? String)!
                    
                    self.postArray.insert(notes,at:0)
                    
                    //self.postArray.append(notes)
                    
                }
              
            }
          
            self.postList.reloadData()
            
        })
        {(error) in
            print(error.localizedDescription)
        }
    
    }
 
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",for:indexPath)
            as!postCollectionViewCell
        
        let url = URL(string:postArray[indexPath.row].imageURL)
        if let data = try? Data(contentsOf: url!)
        {
            cell.postImage.image = UIImage(data: data)
        }
        //cell.postText.text = postArray[indexPath.row].postText
        
        return cell
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
