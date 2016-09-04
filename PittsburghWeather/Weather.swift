//
//  Weather.swift
//  PittsburghWeather
//
//  Created by David Pavel on 9/3/16.
//  Copyright © 2016 David Pavel. All rights reserved.
//

import Foundation
import Alamofire

class Weather {
    
    private var _todayName: String!
    private var _todayHighTemp: String!
    private var _todayLowTemp: String!
    private var _todaySunriseTime: String!
    private var _todaySunsetTime: String!
    private var _weatherURL: String!
    
    init () {
        _todayName = getDayOfWeek()
        _todayHighTemp = "46°"
        _todayLowTemp = "39°"
        _todaySunriseTime = "6:39a"
        _todaySunsetTime = "7:47p"
        
        _weatherURL = "\(URL_BASE)"
    }
    
    var todayName: String {
        if _todayName == nil {
            return ""
        }
        
        return _todayName
    }
    
    var todayHighTemp: String {
        if _todayHighTemp == nil {
            return ""
        }
        
        return _todayHighTemp
    }
    
    var todayLowTemp: String {
        if _todayLowTemp == nil {
            return ""
        }
        
        return _todayLowTemp
    }
    
    var todaySunriseTime: String {
        if _todaySunsetTime == nil {
            return ""
        }
        
        return _todaySunriseTime
    }
    
    var todaySunsetTime: String {
        if _todaySunsetTime == nil {
            return ""
        }
        
        return _todaySunsetTime
    }
    
    func getDayOfWeek() -> String! {
        
        let date = NSDate()
        let formatter  = NSDateFormatter()
        formatter.dateFormat = "EEEE"
        
        return formatter.stringFromDate(date)
    }
    
    func downloadWeatherDetails(completed: DownloadComplete) {
        
        let url = NSURL(string: _weatherURL)!
        
        Alamofire.request(.GET, url).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let list = dict["list"] as? [AnyObject] {
                    
                    if let main = list[0]["main"] as? Dictionary<String, Int> {
                    
                        if let temp = main["temp"] {
                            
                            print("The temperature is \(temp) and I did it. I'm going to bed!")
                        }
                    }
                    
                }
                
            }
        }
    }
}