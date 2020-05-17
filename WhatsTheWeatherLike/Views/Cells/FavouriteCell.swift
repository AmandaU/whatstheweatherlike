//
//  FavouriteCell.swift
//  WhatsTheWeatherLike
//
//  Created by Amanda Baret on 2020/05/16.
//  Copyright © 2020 Amanda Baret. All rights reserved.
//

import Foundation
import UIKit

class FavouriteCell: UITableViewCell {
    
    @IBOutlet var lastUpdateLabel: UILabel!
    @IBOutlet var weatherIcon: UIImageView!
    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
     
    public func setup(favourite: WeatherFavourite)
    {
        lastUpdateLabel.text = favourite.lastUpdated
        nameLabel.text = favourite.name
        tempLabel.text = String(favourite.weatherModel.tempFormatted)
        let currentWeather = favourite.weatherModel.current.weather[0].main
        weatherIcon.image = UIImage(named: currentWeather ?? "Clear")
        switch(currentWeather)
        {
        case "Rain":
            weatherIcon.image = UIImage(named: "rain_icon")
            break;
        case "Mist":
            weatherIcon.image = UIImage(named: "rain_icon")
            break;
        case "Clouds":
            weatherIcon.image = UIImage(named: "cloudy_icon")
            break
        case "Clear":
            weatherIcon.image = UIImage(named: "clear_icon")
            break
        case .none:
            weatherIcon.image = UIImage(named: "clear_icon")
            break;
        default:
            weatherIcon.image = UIImage(named: "clear_icon")
            break;
            
        }
    }
    
}
