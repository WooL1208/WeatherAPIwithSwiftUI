//
//  ViewModel.swift
//  WeatherAPIwithSwiftUI
//
//  Created by WooL on 2020/12/9.
//

import Foundation

class Event {
    let dataSource = DataSource()
    
    func setCity(getCity:String, completion: @escaping(ViewData?) -> Void) {
        dataSource.getWeatherData(city: getCity) { (viewData) in
            var result = ViewData()
            result = viewData!
            completion(result)
        }
    }
}

struct ViewData {
    var getTemp = false
    var city = "city"
    var temperature = 0
    var weatherDescription = "Clear"
}
