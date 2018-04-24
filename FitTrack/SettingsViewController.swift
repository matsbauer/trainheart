//
//  SettingsViewController.swift
//  FitTrack
//
//  Created by Mats Bauer on 23.04.18.
//  Copyright © 2018 Mats Bauer. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var labelCurrentweight: UITextField!
    let userid = defaults.integer(forKey: "userid")
    let weight = defaults.integer(forKey: "weight")

    override func viewDidLoad() {
        super.viewDidLoad()
        if(weight > 0){
            labelCurrentweight.text = String(weight)
        }
        else{
        }
    }
    
    @IBAction func refreshWeight(_ sender: UIButton) {
        //set default weight new
        defaults.set(labelCurrentweight.text, forKey: "weight")
        
        let alert = UIAlertController(title: "Einstellungen", message: "Dein Gewicht wurde erfolgreich aktualisiert.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
