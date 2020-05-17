//
//  FavouritesScene.swift
//  WhatsTheWeatherLike
//
//  Created by Amanda Baret on 2020/05/16.
//  Copyright © 2020 Amanda Baret. All rights reserved.
//

import Foundation
import UIKit

class FavouritesView: UIViewController, UITableViewDelegate {
    
    lazy var ViewModel: FavouritesViewModel = FavouritesViewModel(cacherService: CacherService(), weatherService: WeatherService())
    
    @IBOutlet var FavouritesTable: UITableView!
    
    
    var names: [WeatherModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        FavouritesTable.dataSource = self
        FavouritesTable.delegate = self
        navigationController?.setNavigationBarHidden(false, animated: false)
        ViewModel.GetCachedFavourites()
        FavouritesTable.reloadData()
        ViewModel.FetchFavourites { (success) in
            if (success)
            {
                self.FavouritesTable.reloadData()
            }
        }
    }
    
}

// MARK: - UITableViewDataSource
extension FavouritesView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return ViewModel.Favourites?.weatherFavourites.count ?? 0
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            
            let cell =
                tableView.dequeueReusableCell(withIdentifier: "FavouriteCell",
                                              for: indexPath) as! FavouriteCell
            
            let  model = ViewModel.Favourites?.weatherFavourites[indexPath.row]
            cell.setup(favourite: model!)
            return cell
    }
}
