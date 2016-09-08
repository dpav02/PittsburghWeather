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
    private var _todayCurrentTemp: String!
    private var _todayHighTemp: String!
    private var _todayLowTemp: String!
    private var _todaySunriseTime: String!
    private var _todaySunsetTime: String!
    private var _todayDesc: String!
    private var _todayIcon: String!
    private var _dayIcon: [String!]
    private var _dayName: [String!]
    private var _dayDesc: [String!]
    private var _weatherURL: String!
    private var _forecastURL: String!
    
    init () {
        
        _dayIcon = ["","",""]
        _dayName = ["","",""]
        _dayDesc = ["","",""]
        
        _todayName = self.getDayOfWeek(NSDate())
        _todayHighTemp = "46°"
        _todayLowTemp = "39°"
        _todaySunriseTime = "6:39a"
        _todaySunsetTime = "7:47p"
        
        _weatherURL = URL_BASE
        _forecastURL = URL_FORECAST
        
        
        print(URL_BASE)
        
        print(URL_FORECAST)
    }
    
    var todayName: String {
        if _todayName == nil {
            return ""
        }
        
        return _todayName
    }
    
    var todayCurrentTemp: String {
        if _todayCurrentTemp == nil {
            return ""
        }
        
        return _todayCurrentTemp
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
    
    var todayDesc: String {
        if _todayDesc == nil {
            return ""
        }
        
        return _todayDesc
    }
    
    var todayIcon: String {
        if _todayIcon == nil {
            return ""
        }
        
        return _todayIcon
    }
    
    var dayName: [String!] {
        return _dayName
    }
    
    var dayIcon: [String!] {
        return _dayIcon
    }
    
    var dayDesc: [String!] {
        return _dayDesc
    }

    func getDayOfWeek(date: NSDate) -> String! {
        
        let formatter  = NSDateFormatter()
        formatter.dateFormat = "EEEE"
        
        return formatter.stringFromDate(date)
    }
    
    func downloadWeatherDetails(completed: DownloadComplete) {
        
        let url = NSURL(string: _weatherURL)!
        
        Alamofire.request(.GET, url).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let main = dict["main"] as? Dictionary<String, AnyObject> {
                    
                    if let currentTemp = main["temp"] as? Double {
                        self._todayCurrentTemp = NSString(format: "%d °F", Int(round(currentTemp))) as String
                    }
                    
                    if let highTemp = main["temp_max"] as? Double {
                        self._todayHighTemp = NSString(format: "%d °F", Int(round(highTemp))) as String
                    }
                    
                    if let lowTemp = main["temp_min"] as? Double {
                        self._todayLowTemp = NSString(format: "%d °F", Int(round(lowTemp))) as String
                    }
                    
                }
                
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>] where weather.count > 0 {
                    
                    if let desc = weather[0]["description"] as? String {
                        self._todayDesc = desc.capitalizedString
                    }
                    
                    if let icon = weather[0]["icon"] as? String {
                        self._todayIcon = icon
                    }
                }
                
                let timeFormatter = NSDateFormatter()
                timeFormatter.dateFormat = "h:mm a"
                
                if let sysDetl = dict["sys"] as? Dictionary<String, AnyObject> {
                    if let sunrise = sysDetl["sunrise"] as? Double {
                        let date = NSDate(timeIntervalSince1970: sunrise)
                        self._todaySunriseTime = timeFormatter.stringFromDate(date)
                    }
                    
                    if let sunset = sysDetl["sunset"] as? Double {
                        let date = NSDate(timeIntervalSince1970: sunset)
                        self._todaySunsetTime = timeFormatter.stringFromDate(date)
                    }
                }
                completed()
            }
        }
    }
    func downloadForecast(completed: DownloadForecastComplete) {
        let url = NSURL(string: _forecastURL)!
        
        Alamofire.request(.GET, url).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                for x in 1..<4 {
                    
                    if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                        
                        if let date = list[x]["dt"] as? Double {
                            
                            let dt = NSDate(timeIntervalSince1970: date)
                            
                            let dayName = self.getDayOfWeek(dt)
                            
                            let index = dayName.startIndex.advancedBy(3)
                            let substring = dayName.substringToIndex(index)
                            
                            self._dayName[x-1] = substring
                            
                            if let weather = list[x]["weather"] as? [Dictionary<String, AnyObject>] where weather.count > 0 {
                                
                                if let desc = weather[0]["description"] as? String {
                                    self._dayDesc[x-1] = desc.capitalizedString
                                }
                                
                                if let icon = weather[0]["icon"] as? String {
                                    self._dayIcon[x-1] = icon
                                }
                            }
                            
                        }
                    }
                }
                completed()
            }
        }
    }
}