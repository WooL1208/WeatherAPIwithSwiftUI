//
//  ContentView.swift
//  WeatherAPIwithSwiftUI
//
//  Created by WooL on 2020/10/28.
//

import SwiftUI

struct ContentView: View {
    //天氣圖示
    let icon = [
    "Clear": "moon.stars.fill",
    "Sunny": "sun.max.fill",
    "Partly cloudy Moon": "cloud.moon.fill",
    "Partly cloudy": "cloud.sun.fill",
    "Cloudy": "cloud.fill",
    "Overcast": "smoke.fill",
    "Mist": "cloud.fog.fill",
    "Patchy rain possible": "cloud.drizzle.fill",
    "Patchy snow possible": "cloud.hail.fill",
    "Patchy sleet possible": "cloud.sleet.fill",
    "Patchy freezing drizzle possible": "cloud.hail.fill",
    "Thundery outbreaks possible": "cloud.bolt.rain.fill",
    "Blowing snow": "cloud.snow.fill",
    "Blizzard": "wind.snow",
    "Fog": "cloud.fog.fill",
    "Freezing fog": "cloud.fog",
    "Patchy light drizzle": "cloud.drizzle.fill",
    "Light rain": "cloud.rain.fill",
    "Moderate rain at times": "cloud.rain.fill",
    "Heavy rain": "cloud.heavyrain.fill",
    "Light freezing rain": "cloud.hail.fill",
    "Heavy rain at times": "cloud.heavyrain.fill"
    ]
    
    //時間和格式
    static var taskDateFormat: DateFormatter{
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd, HH:mm"
        return formatter
    }
    let dueDate = Date()
    let dataSource = DataSource()
    @State var display = ViewData()
    
    var body: some View {
        VStack{
            if display.getTemp {
                Text("\(dueDate, formatter: Self.taskDateFormat)").font(.subheadline)
                Text("\(display.city)").font(.largeTitle)
                Text("\(display.weatherDescription)").font(.title)
                HStack{
                    Image(systemName: icon[display.weatherDescription]!)
                        .resizable()
                        .frame(width: 50, height: 50, alignment: .center)
                    Text("\(display.temperature)°C")
                        .font(.largeTitle)
                }
            }
        }.onAppear() {
            dataSource.getWeatherData { (viewData) in
                display = viewData!
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(display: ViewData())
    }
}
