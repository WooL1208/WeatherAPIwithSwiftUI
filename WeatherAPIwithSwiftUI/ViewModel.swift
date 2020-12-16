//
//  ViewModel.swift
//  WeatherAPIwithSwiftUI
//
//  Created by WooL on 2020/12/9.
//

import Foundation

class Event {
    let dataSource = DataSource()
    
    func setCity(getCity:String, completion: @escaping(ViewData?, Bool) -> Void) {
        dataSource.getWeatherData(city: getCity) { (viewData, isSuccess) in
            completion(viewData, isSuccess)
        }
    }
    
}

struct ViewData {
    var getTemp = false
    var city = "city"
    var temperature = 0
    var weatherDescription = "Clear"
    var success = true
}
