//
//  CameraViewController.swift
//  FitTrack
//
//  Created by Mats Bauer on 22.04.18.
//  Copyright © 2018 Mats Bauer. All rights reserved.
//

import UIKit
import Alamofire

class CameraViewController: UIViewController {
    
    let userid = defaults.integer(forKey: "userid")

    //@IBOutlet weak var labelManual: UITextField!
    @IBOutlet weak var labelExercises: UILabel!
    @IBOutlet weak var imageScanner: UIImageView!
    @IBOutlet weak var labelTotalweight: UILabel!
    @IBOutlet weak var labelMachinesNr: UILabel!
    @IBOutlet weak var buttonEndex: UIButton!
    @IBOutlet weak var buttonNextec: UIButton!
    @IBOutlet weak var buttonStartex: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginurl = "https://makethemostof500.com/FitTrack/checkcurrenttraining.php?userid=" + String(userid) + ""
        
        Alamofire.request(loginurl, method: .get).responseJSON
            {
                response in
                print(response)
                
                if let result = response.result.value {
                    let jsonData = result as! NSDictionary
                    
                    let trainingvar = jsonData.value(forKey: "error") as! String?
                    
                    if trainingvar == "0"{
                        self.labelMachinesNr.text = "Do It"
                        self.buttonEndex.isHidden = true
                        self.buttonNextec.isHidden = true
                        self.buttonStartex.isHidden = false
                    }
                    else{
                        self.buttonEndex.isHidden = false
                        self.buttonNextec.isHidden = false
                        self.buttonStartex.isHidden = true
                        
                        self.labelExercises.text = jsonData.value(forKey: "exercises") as! String?
                        
                        self.labelTotalweight.text = jsonData.value(forKey: "totalweight") as! String?
                        
                        self.labelMachinesNr.text = jsonData.value(forKey: "machines") as! String?
                    }
                    
                    
                }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
