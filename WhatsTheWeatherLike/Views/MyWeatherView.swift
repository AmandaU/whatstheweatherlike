//
//  ViewController.swift
//  WhatsTheWeatherLike
//
//  Created by Amanda Baret on 2020/05/16.
//  Copyright © 2020 Amanda Baret. All rights reserved.
//

import UIKit

class MyWeatherView: UIViewController, UITableViewDelegate {
    
    @IBOutlet var ForecastTable: UITableView!
    @IBOutlet var maxLabel: UILabel!
    @IBOutlet var currentLabel: UILabel!
    @IBOutlet var addFavouriteButton: UIButton!
    @IBOutlet var minLabel: UILabel!
    @IBOutlet var listButton: UIButton!
    @IBOutlet var weatherImage: UIImageView!
    @IBOutlet var weatherLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    
    lazy var ViewModel =  MyWeatherViewModel(cacherService: CacherService(), weatherService: WeatherService(), locationManager: LocationManager())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewModel.delegate = self
        ForecastTable.dataSource = self
        ForecastTable.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func addFavouriteClick(_ sender: Any) {
        
        AlertHelper.addNameAlert(target: self) { (name) in
            self.ViewModel.AddToFavourites(name: name)
        }
    }
    
    @IBAction func listClick(_ sender: Any) {
        self.performSegue(withIdentifier: "favouritesSegue", sender: self)
    }
    
    private func SetForecast(dailyWeather: [daily] )
    {
        minLabel.text = String(dailyWeather[0].temp.min)
        maxLabel.text = String(dailyWeather[0].temp.max)
        currentLabel.text = String(dailyWeather[0].temp.day)
    }
}

// MARK: weather fetched delegate
extension MyWeatherView: WeatherFetchedDelegate {
    
    func WeatherFetched() {
        
        if let weathermodel = ViewModel.model, weathermodel.lat > 0 {
            DispatchQueue.main.async {
                
                self.weatherLabel.text = weathermodel.current.weather[0].description
                self.temperatureLabel.text = weathermodel.tempFormatted
                self.weatherImage.image = UIImage(named: weathermodel.current.weather[0].main)
                self.SetForecast(dailyWeather: weathermodel.daily)
                self.ForecastTable.reloadData()
            }
            
        }
    }
}

// MARK: - UITableViewDataSource
extension MyWeatherView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return self.ViewModel.forecasts.count
        
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            
            let cell =
                tableView.dequeueReusableCell(withIdentifier: "ForecastCell",
                                              for: indexPath) as! ForecastCell
            let  model = ViewModel.forecasts[indexPath.row]
            cell.setup(forecast: model)
            return cell
    }
}

