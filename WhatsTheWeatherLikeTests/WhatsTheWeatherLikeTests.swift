//
//  WhatsTheWeatherLikeTests.swift
//  WhatsTheWeatherLikeTests
//
//  Created by Amanda Baret on 2020/05/16.
//  Copyright © 2020 Amanda Baret. All rights reserved.
//

import XCTest
@testable import WhatsTheWeatherLike

class WhatsTheWeatherLikeTests: XCTestCase {
    
    var viewFavouritesModel = FavouritesViewModel(cacherService: CacherService(), weatherService: WeatherService())
    var viewCurrentModel = MyWeatherViewModel(cacherService: CacherService(), weatherService: WeatherService(), locationManager: LocationManager())

    override func setUpWithError() throws {
        super.setUp()
    }

    override func tearDownWithError() throws {
        super.tearDown()
    }

    func testFetchFavourites() throws {
        viewFavouritesModel.FetchFavourites { (success) in
            if(success)
            {
                XCTAssert(success)
            }else {
                XCTAssert(false)
            }
        }
    }

    func testFetchCurrentWeather() throws {
        viewCurrentModel.GetCurrentWeather { (success) in
            if(success)
            {
                XCTAssert(success)
            }else {
                XCTAssert(false)
            }
        }
    }
    
}
