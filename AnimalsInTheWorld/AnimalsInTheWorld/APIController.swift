//
//  APIController.swift
//  AnimalsInTheWorld
//
//  Created by Fabien Rodet on 15/12/2017.
//  Copyright © 2017 Fabien Rodet. All rights reserved.
//

import Foundation

class APIController {
    
    func searchItunesFor(searchTerm: String) {
        
        // L'API iTunes demande des termes multiples, séparés par des + , alors remplacez les espaces par des +
        let itunesSearchTerm = searchTerm.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
        
        // Maintenant échappez tout ce qui n'est pas URL-friendly
        if let escapedSearchTerm = itunesSearchTerm.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding) {
            let urlPath = "https://itunes.apple.com/search?term=\(escapedSearchTerm)&media=software"
            let url: NSURL = NSURL(string: urlPath)
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithURL(url!, completionHandler: {data, response, error -> Void in
                println("Tâche terminée")
                if(error) {
                    // Si une erreur survient lors de la requête web, l'afficher en console
                    println(error.localizedDescription)
                }
                var err: NSError?
                
                var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as? NSDictionary
                if(err != nil) {
                    // Si une erreur survient pendant l'analyse du JSON, l'afficher en console
                    println("Erreur JSON \(err!.localizedDescription)")
                }
                let results: NSArray = jsonResult["results"] as? NSArray
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableData = results
                    self.appsTableView!.reloadData()
                })
            })
            task.resume()
        }
    }
}
