//
//  ViewController.swift
//  MyTraveNote
//
//  Created by user134225 on 2018-01-11.
//  Copyright © 2018 user134225. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    @IBOutlet weak var SignInSignUp: UISegmentedControl!
    
    @IBOutlet weak var signIn: UIButton!
    
    var isSignedIn:Bool = true
    @IBAction func signInSelector(_ sender: UISegmentedControl) {
        //Flip the boolean
        isSignedIn = !isSignedIn
        
        //change according to the bool
        if isSignedIn{
            signIn.setTitle("Sign In",for:.normal)
        }else{
            signIn.setTitle("Sign Up",for:.normal)        }
    }
    
    @IBAction func signInBtn(_ sender: UIButton) {
        if let email = emailText.text,let password = passwordText.text{
            //check its status
            if isSignedIn{
                Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                    // check is use exist
                    if let u = user{
                        //found, to next page
                        self.performSegue(withIdentifier: "toMain", sender: self)
                    }else{
                        //not found, show error msg
                    
                        // create the alert
                        let alert = UIAlertController(title: "Authentication Failed", message: "Please Sign up first if your haven't, otherwise please choose one from bellow buttons", preferredStyle: UIAlertControllerStyle.alert)
                        
                        //defined the actions
                        let retrieve = UIAlertAction(title: "Retrieve password", style: .default, handler: { (action) -> Void in
                            Auth.auth().sendPasswordReset(withEmail: email) { error in
                                // Your code here
                            }
                        })
                        let cancel = UIAlertAction(title: "Retry", style: UIAlertActionStyle.cancel, handler: nil)
            
                    // add the actions (buttons)
                        alert.addAction(retrieve)
                        alert.addAction(cancel)
                        
                        // show the alert
                        self.present(alert, animated: true, completion: nil)
                    
                        
                    }
                }
                }
            
            else{
                //register user
                Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                    if let u = user{
                        //found, to next page
                        self.performSegue(withIdentifier: "toMain", sender: self)
                    }else{
                        //not found, show error msg
                       
                    
                }
            }
        }
    }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //dismiss keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailText.resignFirstResponder()
        passwordText.resignFirstResponder()
    }
    

    
    
    
    
    
    
    


}

