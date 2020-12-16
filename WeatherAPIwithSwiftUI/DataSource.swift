//
//  DataSource.swift
//  WeatherAPIwithSwiftUI
//
//  Created by WooL on 2020/11/18.
//

import Foundation
class DataSource {
    
    func getWeatherData(city: String, completion: @escaping(ViewData?, Bool) -> Void ) {
        var viewData = ViewData()
        let key = ""
        let jsonURLString =  "http://api.weatherstack.com/current?access_key=" + key + "&query=" + city
        // make URL
        
        let url = URL(string: jsonURLString)!
        // start a session
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            // check for error
            if error != nil {
                print(error!.localizedDescription)
            }
            // check for 200 OK status
            guard let data = data else { return }
            do {
                let error = try JSONDecoder().decode(WeatherError.self, from: data)
                var isSuccess = true
                if let _ = error.success {
                    isSuccess = false
                    completion(viewData, isSuccess)
                } else {
                    let weather = try JSONDecoder().decode(Weather.self, from: data)
                    viewData.city = weather.location?.name ?? ""
                    viewData.temperature = weather.current?.temperature ?? 0
                    viewData.weatherDescription = weather.current?.weather_descriptions[0] ?? ""
                    viewData.getTemp.toggle()
                    completion(viewData, isSuccess)
                }
            } catch let err {
                print ("Json Err", err)
                
            }
        }.resume()
    }
}
