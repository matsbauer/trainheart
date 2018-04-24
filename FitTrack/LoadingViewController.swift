//
//  LoadingViewController.swift
//  FitTrack
//
//  Created by Mats Bauer on 22.04.18.
//  Copyright © 2018 Mats Bauer. All rights reserved.
//

import UIKit
import Foundation
import SystemConfiguration

class LoadingViewController: UIViewController {

    @IBOutlet weak var buttonEinloggen: UIButton!
    @IBOutlet weak var buttonContinue: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userid = defaults.integer(forKey: "userid")
        print(userid)
        if(userid > 0){
            //load segue continue
            //performSegue(withIdentifier: "continueHome", sender: nil)
            
        }
        else{
            buttonContinue.isHidden = true
            buttonEinloggen.isHidden = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
