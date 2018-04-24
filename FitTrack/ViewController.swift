//
//  ViewController.swift
//  FitTrack
//
//  Created by Mats Bauer on 22.04.18.
//  Copyright © 2018 Mats Bauer. All rights reserved.
//

import UIKit
import Alamofire

let defaults = UserDefaults.standard

class ViewController: UIViewController {

    @IBOutlet weak var loginUsername: UITextField!
    @IBOutlet weak var loginPassword: UITextField!
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldUsername: UITextField!
    @IBOutlet weak var labelMessage: UILabel!
    
    @IBAction func buttonlogin(_ sender: UIButton) {
        
        let loginurl = "https://makethemostof500.com/FitTrack/checklogin.php?username=" + loginUsername.text! + "&password=" + loginPassword.text! + ""
        
        Alamofire.request(loginurl, method: .get).responseJSON
            {
                response in
                //printing response
                print(response)
                
                //getting the json value from the server
                if let result = response.result.value {
                    
                    //converting it as NSDictionary
                    let jsonData = result as! NSDictionary
                    
                    //displaying the message in a popup
                    
                    let error = jsonData.value(forKey: "error") as! String?
                    
                    if (error == "failed"){
                        let alert = UIAlertController(title: "Login", message: "Fehler bei der Anmeldung - bitte probiere es nochmal.", preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                        self.present(alert, animated: true)
                    }
                    
                    else{
                        defaults.removeObject(forKey: "userid")
                        defaults.removeObject(forKey: "name")
                        
                        let userid = jsonData.value(forKey: "userid") as! String?
                        defaults.set(userid, forKey: "userid")
                        
                        let name = jsonData.value(forKey: "name") as! String?
                        defaults.set(name, forKey: "name")
                    }
                }
        }
        
    }
    
    
    
    
    @IBAction func buttonregister(_ sender: UIButton) {
            
            let url = "https://makethemostof500.com/FitTrack/register.php?username=" + textFieldUsername.text! + "&password=" + textFieldPassword.text! + "&email=" + textFieldEmail.text! + "&name=" + textFieldName.text! + "&deviceid=" + UIDevice.current.identifierForVendor!.uuidString + ""
            
            //Sending http post request
            Alamofire.request(url, method: .get).responseJSON
                {
                    response in
                    //printing response
                    print(response)
                    
                    //getting the json value from the server
                    if let result = response.result.value {
                        
                        //converting it as NSDictionary
                        let jsonData = result as! NSDictionary
                        
                        //displaying the message in a popup
                        
                        let alert = UIAlertController(title: "Registierung", message: jsonData.value(forKey: "message") as! String?, preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                        
                        self.present(alert, animated: true)
                        
                    }
                }
    
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

