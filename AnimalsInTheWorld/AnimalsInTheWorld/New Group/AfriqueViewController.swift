//
//  AfriqueViewController.swift
//  AnimalsInTheWorld
//
//  Created by Fabien Rodet on 13/12/2017.
//  Copyright © 2017 Fabien Rodet. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class AfriqueViewController: UIViewController {
    
   
    
    @IBOutlet weak var labelTest: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let  Url = URL(string: "https://raw.githubusercontent.com/Abhishekverma99/Use-swift-3.0/master/db.json")
        Alamofire.request(Url!).validate().responseJSON { (response) in
            if ((response.result.value) != nil) {
                let jsondata = JSON(response.result.value!)
                print(jsondata)
            }
        }
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
