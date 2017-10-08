//
//  ViewController.swift
//  Weather App
//
//  Created by Merlin Zhao on 8/11/17.
//  Copyright © 2017 Merlin Zhao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBAction func search(_ sender: Any) {
        
        if let url = URL(string: "http://www.weather-forecast.com/locations/" + textField.text!.replacingOccurrences(of: " ", with: "-") + "/forecasts/latest"){
            
        cityLabel.text = textField.text?.uppercased()
        let request = NSMutableURLRequest(url: url)
            
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
                
            var message = ""
                
            if let error = error {
                print(error)
                    
            }else {
                if let unwrappedData = data {
                    let dataString = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue)
                        
                    var stringSeparator = "Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">"
                        
                    if let contentArray = dataString?.components(separatedBy: stringSeparator) {
                        if contentArray.count > 1{
                            stringSeparator = "</span>"
                            let newContentArray = contentArray[1].components(separatedBy: stringSeparator)
                            if  newContentArray.count > 1{
                                    
                                message = newContentArray[0].replacingOccurrences(of: "&deg;", with: "°")
                                    
                                    
                                    
                                print(message)
                            }
                        }
                    }
                }
            }
            if message == "" {
                message = "Weather not found. Please check spelling or internet connection."
            }
            DispatchQueue.main.sync(execute: {
                self.result.text = message
            })
        }
        task.resume()
        
            
        } else {
            result.text = "Weather not found. Please check spelling or internet connection."
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    @objc func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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

