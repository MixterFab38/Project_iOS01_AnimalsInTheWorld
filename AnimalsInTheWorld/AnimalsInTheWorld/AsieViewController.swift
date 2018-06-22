//
//  AsieViewController.swift
//  AnimalsInTheWorld
//
//  Created by Fabien Rodet on 13/12/2017.
//  Copyright © 2017 Fabien Rodet. All rights reserved.
//

import UIKit

struct Country: Decodable {
    let name: String
}


class AsieViewController: UIViewController {

    @IBOutlet weak var labelTest: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let url = "https://restcountries.eu/rest/v2/region/Asia"
        let urlObj = URL(string: url)
       
        
        URLSession.shared.dataTask(with: urlObj!) {(data, response, error) in
            do
            {
                var countries = try JSONDecoder().decode([Country].self, from: data!)
                
                for country in countries
                {
                    self.labelTest.text = self.labelTest.text! + country.name + "\n";
                    print(country.name)
                }
            }catch {
                print("We got an error")
            }
        }.resume()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
