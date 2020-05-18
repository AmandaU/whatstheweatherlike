//
//  Connectivity.swift
//  WhatsTheWeatherLike
//
//  Created by Amanda Baret on 2020/05/16.
//  Copyright © 2020 Amanda Baret. All rights reserved.
//

import Foundation
import Network

class ConnectivityManager {
   let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "InternetConnectionMonitor")
    
    var isConnected: Bool = false;
    static let Instance = ConnectivityManager()
    
    init(){
        monitor.pathUpdateHandler = { pathUpdateHandler in
            if pathUpdateHandler.status == .satisfied {
                ConnectivityManager.self.Instance.isConnected = true
                print("Internet connection is on.")
            } else {
                ConnectivityManager.self.Instance.isConnected = false
                print("There's no internet connection.")
            }
        }
        monitor.start(queue: queue)
    }
    
    var IsConnected: Bool {
        get {
            return ConnectivityManager.Instance.isConnected
        }
    }
    
}
