    //
    //  MyWeatherViewModel.swift
    //  WhatsTheWeatherLike
    //
    //  Created by Amanda Baret on 2020/05/16.
    //  Copyright © 2020 Amanda Baret. All rights reserved.
    //
    
    import Foundation
    
    class MyWeatherViewModel {
        
        weak var delegate: WeatherFetchedDelegate?
        
        var model: WeatherModel?
        var cacherService: CacherService!
        var weatherService: WeatherService!
        var locationManager: LocationManager!
        var forecasts = [ForecastModel]()
        
        init(cacherService: CacherService, weatherService: WeatherService, locationManager: LocationManager){
            self.weatherService = weatherService
            self.locationManager = locationManager
            self.cacherService = cacherService
            self.locationManager.delegate = self
        }
        
        func AddToFavourites(name: String){
            
            var weatherFavourites = (self.cacherService!.load(fileName: "WEATHERFAVOURITES")) ?? WeatherFavourites() as WeatherFavourites
            
            let dateString = Date().FormattedDateString(format: "yyyy-MM-dd HH:mm:ss")
            var weatherFavourite = WeatherFavourite(fileName: "WEATHERFAVOURITE", name: name, lastUpdated: dateString, weatherModel: model)
            
            weatherFavourites.weatherFavourites.append(weatherFavourite)
            cacherService?.persist(item: weatherFavourites, completion: { (url, eror) in})
        }
        
        func GetCurrentWeather( success:  @escaping (Bool)->()) {
            
            if(ConnectivityManager.Instance.IsConnected){
                weatherService.FetchCurrentWeather(success: { (model) in
                    self.model = model
                    self.DoForecast()
                    self.delegate?.WeatherFetched(success: true)
                }) { (error) in
                    
                }
            }else {
                self.delegate?.WeatherFetched(success: false)
            }
        }
        
        func GetForecastWeather( success:  @escaping (Bool)->()) {
            weatherService.FetchCurrentWeather(success: { (number) in
            }) { (error) in
                
            }
        }
        
        func LocateUser() {
            locationManager.LocateUser()
        }
        
        private func GetDayOfWeek(day: Int) -> String! {
            var dayComponent = DateComponents()
            dayComponent.day = day // For removing one day (yesterday): -1
            let theCalendar = Calendar.current
            guard let nextDate = theCalendar.date(byAdding: dayComponent, to: Date()) else { return "Monday" }
            let customDateFormatter = DateFormatter()
            let day = customDateFormatter.weekdaySymbols[Calendar.current.component(.weekday, from: nextDate)]
            print(day)
            return day
        }
        
        func DoForecast(){
            if let fiveDayForecast = model?.daily.prefix(5) {
                let  f =  (fiveDayForecast.enumerated().map{ (index,day) in
                    return ForecastModel(day: GetDayOfWeek(day: index ), weather: WeatherType(rawValue: day.weather[0].main),
                                         temperature: day.temp.day)
                } ) as [ForecastModel]
                forecasts.append(contentsOf: f)
            }
        }
    }
    
    extension MyWeatherViewModel: UserLocationDelegate{
        func UserLocated(success: Bool) {
            if(success){
                GetCurrentWeather { [weak self] success in
                    self?.delegate?.WeatherFetched(success: true)
                }
            }else {
                self.delegate?.WeatherFetched(success: false)
            }
            
            
            
        }
    }
