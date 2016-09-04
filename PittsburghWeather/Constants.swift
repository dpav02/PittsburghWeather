//
//  Constants.swift
//  PittsburghWeather
//
//  Created by David Pavel on 9/3/16.
//  Copyright © 2016 David Pavel. All rights reserved.
//

import Foundation

// NOTE: This is hard-coded for the city of Pittsburgh, PA. That being said, this can be modified in the future.
public let CITY_ID = "5206379"
public let UNITS = ",us&units=imperial"
public let API_KEY = "178cd54523d502c2e1d8288e7ec45f07"


public let URL_BASE = "http://api.openweathermap.org/data/2.5/forecast/city?id=\(CITY_ID)\(UNITS)&APPID=\(API_KEY)"

typealias DownloadComplete = () -> ()