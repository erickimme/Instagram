//
//  LoginViewController.swift
//  Instagram
//
//  Created by Rahul Balla on 2/12/18.
//  Copyright © 2018 Rahul Balla. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func onLogIn(_ sender: Any) {
        PFUser.logInWithUsername(inBackground: usernameText.text!, password: passwordText.text!) { (user: PFUser?, error: Error?) in
            
            if user != nil {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
            else{
                self.createAlert(alertTitle: "Log In Failed", alertMessage: (error?.localizedDescription)!, actionTitle: "OK", segue: false)
            }
        }
    }
    

    @IBAction func onSignUp(_ sender: Any) {
        let newUser = PFUser()
        newUser.username = usernameText.text
        newUser.password = passwordText.text
        
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if(success){
                self.createAlert(alertTitle: "Account created!", alertMessage: "You have successfully created a new account", actionTitle: "OK", segue: true)
            }
            else{
                self.createAlert(alertTitle: "Sign Up Failed", alertMessage: (error?.localizedDescription)!, actionTitle: "OK", segue: false)
            }
        }
    } 
    
    func createAlert(alertTitle: String, alertMessage: String, actionTitle: String, segue: Bool){
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        var action: UIAlertAction!
        if(segue == true){
            action = UIAlertAction(title: actionTitle, style: .default) { (action) -> Void in
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
        else{
            action = UIAlertAction(title: actionTitle, style: .default, handler: nil)
        }
        
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
