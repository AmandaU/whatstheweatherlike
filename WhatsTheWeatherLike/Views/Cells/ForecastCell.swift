//
//  ForecastCell.swift
//  WhatsTheWeatherLike
//
//  Created by Amanda Baret on 2020/05/16.
//  Copyright © 2020 Amanda Baret. All rights reserved.
//

import Foundation

import UIKit

class ForecastCell: UITableViewCell {
    
    @IBOutlet var weatherIcon: UIImageView!
    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var dayLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
   
    public func setup(forecast: ForecastModel)
    {
       tempLabel.text = forecast.tempFormatted
       dayLabel.text = forecast.day
        
        switch(forecast.weather)
        {
        case .rain:
            weatherIcon.image = UIImage(named: "rain_icon")
            break;
        case .misty:
            weatherIcon.image = UIImage(named: "rain_icon")
            break;
        case .cloudy:
            weatherIcon.image = UIImage(named: "cloudy_icon")
            break
        case .sunny:
            weatherIcon.image = UIImage(named: "clear_icon")
            break
        case .none:
            weatherIcon.image = UIImage(named: "clear_icon")
            break;
        }
    }
    
}
