//
//  ForecastModel.swift
//  WhatsTheWeatherLike
//
//  Created by Amanda Baret on 2020/05/16.
//  Copyright © 2020 Amanda Baret. All rights reserved.
//

import Foundation

struct ForecastModel {
    var day: String = ""
    var weather: WeatherType?
    var temperature : Double!
    
    var tempFormatted : String {
        get {
            let cent  = Int((temperature - 32.0) / 1.8)
             return "\(String(cent))°C"
        }
    }
}
