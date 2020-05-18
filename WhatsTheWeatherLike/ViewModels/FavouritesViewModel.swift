//
//  FavouritesViewModel.swift
//  WhatsTheWeatherLike
//
//  Created by Amanda Baret on 2020/05/16.
//  Copyright © 2020 Amanda Baret. All rights reserved.
//

import Foundation

class FavouritesViewModel {
    
    var cacherService: CacherService?
    var weatherService: WeatherService?
    var Favourites:  WeatherFavourites?
    
    init(cacherService: CacherService, weatherService: WeatherService) {
        self.cacherService = cacherService
        self.weatherService = weatherService
    }
    
    public func GetCachedFavourites(){
        let weatherFavourites = (self.cacherService!.load(fileName: "WEATHERFAVOURITES")) ?? WeatherFavourites() as WeatherFavourites
        
        self.Favourites = weatherFavourites
    }
    
    public func FetchFavourites(success: @escaping (Bool)->())
    {
        if(ConnectivityManager.Instance.IsConnected && LocationManager.Instance.UserLocation.latitude != 0){
            
            let myGroup = DispatchGroup()
            
            for i in 0 ..< (Favourites?.weatherFavourites.count)! {
                myGroup.enter()
                var weatherFavourite = Favourites?.weatherFavourites[i]
                weatherService?.FetchCurrentWeather(lat: weatherFavourite!.weatherModel.lat, lon: weatherFavourite!.weatherModel.lon, success: { (model) in
                    weatherFavourite?.weatherModel = model
                   weatherFavourite?.lastUpdated = Date().FormattedDateString(format: "yyyy-MM-dd HH:mm:ss")
                }, failure: { (error) in
                    print("Couldnt fetch latest weather for favourite")
                })
            }
            
            myGroup.notify(queue: .main) {
                print("Finished all requests.")
            }
            cacherService?.persist(item: self.Favourites!, completion: { (url, eror) in})
            success(true)
        }
    }
}
