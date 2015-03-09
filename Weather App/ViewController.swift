//
//  ViewController.swift
//  Weather App
//
//  Created by Gerardo Camilo on 04/11/14.
//  Copyright (c) 2014 ___GRCS___. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtCity: UITextField!
    
    @IBOutlet weak var lblWeatherResult: UILabel!
    
    
    @IBAction func getWeather(sender: AnyObject) {
        
        let city = txtCity.text
        
        var weather = getWeatherByCity(city)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setWeatherText(text: String){
        if(!text.isEmpty){
            self.lblWeatherResult.text = text
        }
    }
    
    func getWeatherByCity(city: String) -> String {
        lblWeatherResult.text = "Getting weather..."
        //var city = "santodomingo"
        var result: String = String()
        var url1 = "http://www.weather-forecast.com/locations/"
        var url2 = url1 + city.stringByReplacingOccurrencesOfString(" ", withString: "") + "/forecasts/latest"
        println(url2)
        
        let URL = NSURL(string: url2)
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(URL!){
            (data, response, error) in
            
            let decodedData = NSString(data: data, encoding: NSUTF8StringEncoding)
            
            let separator = "<span class=\"phrase\">"

            if (decodedData?.containsString(separator) != nil){
            
                var contentArray = decodedData!.componentsSeparatedByString(separator)
                
                var separator2 = "</span>"
            
                var newContentArray = contentArray[1].componentsSeparatedByString(separator2)
                
                var weatherForecast = (newContentArray[0] as String).stringByReplacingOccurrencesOfString("&deg;", withString: "º")
                println(weatherForecast)
                
                dispatch_async(dispatch_get_main_queue()){
                    self.setWeatherText(weatherForecast)
                }
                
            } else {
                dispatch_async(dispatch_get_main_queue()){
                    self.setWeatherText("City not found. Please try again.")
                }//end dispatch_async
            } //end else
        
        }
        
        task.resume()
        
        return result
    }
    
}

