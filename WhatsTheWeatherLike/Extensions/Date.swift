//
//  Date.swift
//  WhatsTheWeatherLike
//
//  Created by Amanda Baret on 2020/05/17.
//  Copyright © 2020 Amanda Baret. All rights reserved.
//

import Foundation

extension Date {
    func FormattedDateString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: self)
    }
}
