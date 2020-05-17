//
//  WeatherService.swift
//  WhatsTheWeatherLike
//
//  Created by Amanda Baret on 2020/05/16.
//  Copyright © 2020 Amanda Baret. All rights reserved.
//

import Foundation

enum WeatherType: String, CustomStringConvertible {
    
    case sunny = "Clear"
    case rain = "Rain"
    case cloudy = "Clouds"
    case misty = "Misty"
    
    var description: String {
        get {
            return self.rawValue
        }
    }
}


class WeatherService {
    
    var API_Key  = "6662fb42d03980df0c3a8580c80a1174"
    
    public func FetchCurrentWeather( success:  @escaping (WeatherModel)->(),
                                     failure:  @escaping (String)->())
    {
        FetchCurrentWeather(lat: LocationManager.Instance.UserLocation.latitude, lon: LocationManager.Instance.UserLocation.longitude, success: { (model) in
            success(model)
        }) { (error) in
            failure(error)
        }
    }
    
    public func FetchCurrentWeather( lat: Double, lon: Double, success:  @escaping (WeatherModel)->(),
                                     failure:  @escaping (String)->())
    {
        let url = "https://api.openweathermap.org/data/2.5/onecall"
        var urlComponents = URLComponents(string: url)
        
        urlComponents?.queryItems = [
            URLQueryItem(name: "lat", value: String(lat)),
            URLQueryItem(name: "lon", value: String(lon)),
            URLQueryItem(name: "exclude", value: "minutely,hourly"),
            URLQueryItem(name: "appid", value: API_Key)
        ]
        
        print(urlComponents?.url?.absoluteString as Any)
        var request = URLRequest(url: (urlComponents?.url)!)
        request.httpMethod = "GET"
        // Set HTTP Request Header
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        session.dataTask(with: request) { (data, response, error) in
            
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("Response data string:\n \(dataString)")
                
                do {
                    
                    var weatherModel: WeatherModel = WeatherModel()
                    let jsonData = dataString.data(using: .utf8)!
                    weatherModel = try! JSONDecoder().decode(WeatherModel.self, from: jsonData)
                    
                    print(weatherModel)
                    success(weatherModel)
                }
            }
        }.resume()
    }
}
