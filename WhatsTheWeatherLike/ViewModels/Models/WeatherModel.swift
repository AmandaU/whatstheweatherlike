//
//  WeatherModel.swift
//  WhatsTheWeatherLike
//
//  Created by Amanda Baret on 2020/05/16.
//  Copyright © 2020 Amanda Baret. All rights reserved.
//

import Foundation
import CoreLocation

struct WeatherFavourites: Cachable, Codable {
    var fileName: String = "WEATHERFAVOURITES"
    var weatherFavourites = [WeatherFavourite]()
}

struct WeatherFavourite:  Cachable, Codable {
    var fileName: String = "WEATHERFAVOURITE"
    
    var name: String = ""
    var lastUpdated: String = ""
    var  weatherModel : WeatherModel!
    
    private enum CodingKeys: String, CodingKey {
        case  name, lastUpdated, weatherModel
    }
}

struct WeatherModel: Cachable, Codable{
    var fileName: String = "WEATHERMODEL"
    
    
    var lat: Double = 0.0
    var lon: Double = 0.0
    var current: current!
    var daily: [daily]!
    
    var tempFormatted : String {
        get {
            let cent  = Int((current.temp - 32.0) / 1.8)
            return "\(String(cent))°C"
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case  lat, lon, current, daily
    }
    
}

struct current: Cachable, Codable {
    var fileName: String = "CURRENT"
    
    var temp: Double!
    var weather: [weather]!
    
    private enum CodingKeys: String, CodingKey {
        case temp, weather
    }
}

struct weather: Cachable, Codable {
    var fileName: String = "WEATHER"
    
    var main: String!
    var description: String!
    var icon: String!
    
    private enum CodingKeys: String, CodingKey {
        case main, description, icon
    }
}

struct daily: Cachable, Codable {
    var fileName: String = "DAILY"
    var temp: temp!
    var weather: [weather]!
    
    private enum CodingKeys: String, CodingKey {
        case temp, weather
    }
}

struct temp: Cachable, Codable {
    var fileName: String = "TEMP"
    
    var day: Double!
    var min: Double!
    var max: Double!
    
    private enum CodingKeys: String, CodingKey {
        case day, min, max
    }
}
