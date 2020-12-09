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
    "Partly Cloudy Moon": "cloud.moon.fill",
    "Partly Cloudy": "cloud.sun.fill",
    "Cloudy": "cloud.fill",
    "Overcast": "smoke.fill",
    "Mist": "cloud.fog.fill",
    "Patchy Rain Possible": "cloud.drizzle.fill",
    "Patchy Snow Possible": "cloud.hail.fill",
    "Patchy Sleet Possible": "cloud.sleet.fill",
    "Patchy Freezing Drizzle possible": "cloud.hail.fill",
    "Thundery Outbreaks Possible": "cloud.bolt.rain.fill",
    "Blowing Snow": "cloud.snow.fill",
    "Blizzard": "wind.snow",
    "Fog": "cloud.fog.fill",
    "Freezing Fog": "cloud.fog",
    "Patchy Light Drizzle": "cloud.drizzle.fill",
    "Light Rain": "cloud.rain.fill",
    "Moderate Rain at Times": "cloud.rain.fill",
    "Heavy Rain": "cloud.heavyrain.fill",
    "Light Freezing Rain": "cloud.hail.fill",
    "Heavy Rain at Times": "cloud.heavyrain.fill"
    ]
    
    //時間和格式
    static var taskDateFormat: DateFormatter{
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd, HH:mm"
        return formatter
    }
    let dueDate = Date()
    let event = Event()
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
            event.setCity(getCity: "Taipei") { (result) in
                display = result!
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(display: ViewData(getTemp: true, city: "Taipei", temperature: 20, weatherDescription: "Clear"))
    }
}
