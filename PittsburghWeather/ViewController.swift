//
//  ViewController.swift
//  PittsburghWeather
//
//  Created by David Pavel on 9/3/16.
//  Copyright © 2016 David Pavel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dayOfWeekLbl: UILabel!
    
    @IBOutlet weak var todayHighTempLbl: UILabel!
    @IBOutlet weak var todayLowTempLbl: UILabel!
    
    @IBOutlet weak var todaySunriseTimeLbl: UILabel!
    @IBOutlet weak var todaySunsetTimeLbl: UILabel!
    
    var weather = Weather.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadWeather()
    }
    
    func loadWeather() {
        
        weather.downloadWeatherDetails {
            self.dayOfWeekLbl.text = self.weather.todayName
            self.todayHighTempLbl.text = self.weather.todayHighTemp
            self.todayLowTempLbl.text = self.weather.todayLowTemp
            self.todaySunriseTimeLbl.text = self.weather.todaySunriseTime
            self.todaySunsetTimeLbl.text = self.weather.todaySunsetTime
        }
    }
}