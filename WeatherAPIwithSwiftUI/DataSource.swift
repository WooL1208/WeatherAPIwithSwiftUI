//
//  DataSource.swift
//  WeatherAPIwithSwiftUI
//
//  Created by WooL on 2020/11/18.
//

import Foundation
class DataSource{
    func getWeatherData(completion: @escaping(ViewData?) -> Void ) {
        var viewData = ViewData()
        let jsonURLString =  "http://api.weatherstack.com/current?access_key=[my key]&query=[location]"
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
                let weather = try JSONDecoder().decode(Weather.self, from: data)
                viewData.city = weather.location?.name ?? ""
                viewData.temperature = weather.current?.temperature ?? 0
                viewData.weatherDescription = weather.current?.weather_descriptions[0] ?? ""
                viewData.getTemp.toggle()
                completion(viewData)
            } catch let err {
                print ("Json Err", err)
            }
        }.resume()
    }
}
struct ViewData {
    var getTemp = false
    var city = "city"
    var temperature = 0
    var weatherDescription = "Clear"
}
// MAKE STRUCT VARIABLES OPTIONAL TO PREVENT CRASHING WHEN VARIABLE IS EMPTY
struct Weather : Decodable {
    let request : Request?
    let location : Location?
    let current : Current?
}
struct Current : Decodable {
    let observation_time : String?
    let temperature : Int?
    let weather_code : Int?
    let weather_icons : [String?]
    let weather_descriptions : [String?]
    let wind_speed : Int?
    let wind_degree : Int?
    let wind_dir : String?
    let pressure : Int?
    let precip : Double?
    let humidity : Int?
    let cloudcover : Int?
    let feelslike : Int?
    let uv_index : Int?
    let visibility : Int?
}
struct Location : Decodable {
    let name : String?
    let country : String?
    let region : String?
    let lat : String?
    let lon : String?
    let timezone_id : String?
    let localtime : String?
    let localtime_epoch : Int?
    let utc_offset : String?
}
struct Request : Decodable {
    let type : String?
    let query : String?
    let language : String?
    let unit : String?
}
