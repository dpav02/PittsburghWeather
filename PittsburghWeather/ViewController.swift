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
    
    @IBOutlet weak var todayDesc: UILabel!
    @IBOutlet weak var todayCurrentTempLbl: UILabel!
    @IBOutlet weak var todayHighTempLbl: UILabel!
    @IBOutlet weak var todayLowTempLbl: UILabel!
    @IBOutlet weak var todayImage: UIImageView!
    
    @IBOutlet weak var todaySunriseTimeLbl: UILabel!
    @IBOutlet weak var todaySunsetTimeLbl: UILabel!
    
    @IBOutlet weak var day1Lbl: UILabel!
    @IBOutlet weak var day2Lbl: UILabel!
    @IBOutlet weak var day3Lbl: UILabel!
    
    @IBOutlet weak var day1Img: UIImageView!
    @IBOutlet weak var day2Img: UIImageView!
    @IBOutlet weak var day3Img: UIImageView!
    
    @IBOutlet weak var day1Desc: UILabel!
    @IBOutlet weak var day2Desc: UILabel!
    @IBOutlet weak var day3Desc: UILabel!
    
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
            self.todayCurrentTempLbl.text = self.weather.todayCurrentTemp
            self.todayDesc.text = self.weather.todayDesc
            self.todayImage.image = UIImage(named: self.weather.todayIcon)
        }
        
        weather.downloadForecast {
            self.day1Lbl.text = self.weather.dayName[0]
            self.day2Lbl.text = self.weather.dayName[1]
            self.day3Lbl.text = self.weather.dayName[2]
            
            self.day1Img.image = UIImage(named: self.weather.dayIcon[0])
            self.day2Img.image = UIImage(named: self.weather.dayIcon[1])
            self.day3Img.image = UIImage(named: self.weather.dayIcon[2])
            
            self.day1Desc.text = self.weather.dayDesc[0]
            self.day2Desc.text = self.weather.dayDesc[1]
            self.day3Desc.text = self.weather.dayDesc[2]
        }
    }
}