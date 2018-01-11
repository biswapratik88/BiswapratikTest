//
//  ViewController.swift
//  BiswapratikTest
//
//  Created by navsoft-design on 11/01/18.
//  Copyright © 2018 navsoft-design. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var storeTable: UITableView!
    var storeLocations = [Location]()
    var task = URLSessionTask()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchStoreLocations()
    }

    func fetchStoreLocations() {
        let requestURL = NSURL(string: "http://lcboapi.com/stores?product_id=438457")!
        let request = NSMutableURLRequest(url: requestURL as URL)
        request.httpMethod = "GET"
        let session = URLSession.shared
        task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            do {
                if(error == nil) {
                    if(data != nil) {
                        let result = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! NSDictionary
                        let locationResult = result.object(forKey: "result") as! [NSDictionary]
                        for eachLocation in locationResult {
                            let newLocation = Location()
                            newLocation.id = eachLocation.object(forKey: "id") as? Int
                            newLocation.name = eachLocation.object(forKey: "name") as? String
                            newLocation.latitude = eachLocation.object(forKey: "latitude") as? Double
                            newLocation.longitude = eachLocation.object(forKey: "longitude") as? Double
                            self.storeLocations.append(newLocation)
                        }
                        DispatchQueue.main.async {
                            self.storeTable.reloadData()
                        }
                    }
                }
            } catch {
            }
        }
        task.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storeLocations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "ElementCell")
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = storeLocations[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let mapVC = storyBoard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        mapVC.thisLocation = storeLocations[indexPath.row]
        self.navigationController?.pushViewController(mapVC, animated: true)
    }
    
}

