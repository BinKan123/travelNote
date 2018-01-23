//
//  InspirationViewController.swift
//  MyTraveNote
//
//  Created by user134225 on 2018-01-12.
//  Copyright © 2018 user134225. All rights reserved.
//

import UIKit
import FirebaseDatabase



class InspirationViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var inspirationTable: UITableView!
    
    var insRef:DatabaseReference?
    var handle:DatabaseHandle?
    
//    var inspirationArray:[Inspirations] = []
//    struct Inspirations {
//        var place = ""
//        var photosURL = ""
//        var webURL = ""
//    }
//
    struct  postStruct {
        let title:String!

    }
    
    var inspirationArray = [postStruct]()
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return inspirationArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! InspirationTableViewCell
//        let cellIns = inspirationArray[indexPath.row]
//        cell.placeName?.text = cellIns.place
//        cell.webURL?.text = cellIns.webURL
//
//        let placeImg = cellIns.photosURL
//        let url = NSURL(string:placeImg)
//        let data = NSData(contentsOf: url as! URL)
//        let img = UIImage(data:data as! Data)
//        cell.placeImg.image = img
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! InspirationTableViewCell
        let cellIns = inspirationArray[indexPath.row]
        cell.labelTest?.text = cellIns.title

        return cell
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inspirationTable.delegate = self
        inspirationTable.dataSource = self
        
        //set firebase reference
        insRef = Database.database().reference()
        //retrieve data
        handle = insRef?.child("fruit").observe(.childAdded, with:{ (snapshot) in
            //            if let item = snapshot.value as? Inspirations{
            //                self.inspirationArray.append(item)
            //                self.inspirationTable.reloadData()
            //            }
            
           if let post = snapshot.value as? postStruct{
            self.inspirationArray.append(post)
                self.inspirationTable.reloadData()
            }
        })
            { (error) in
                print(error.localizedDescription)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
