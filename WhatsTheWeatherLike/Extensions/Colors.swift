//
//  Colors.swift
//  WhatsTheWeatherLike
//
//  Created by Amanda Baret on 2020/05/17.
//  Copyright © 2020 Amanda Baret. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
  
}

public struct Colors {
    
   static let SunnyGreen = UIColor(hex: "#ff47AB2F")
   static let RainyGrey = UIColor(hex: "#ff57575D")
   static let CloudyBlue = UIColor(hex: "#ff54717A")
   static let MistyPink = UIColor(hex: "#ffC4AEAD")
}
