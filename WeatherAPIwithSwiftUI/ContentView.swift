//
//  ContentView.swift
//  WeatherAPIwithSwiftUI
//
//  Created by WooL on 2020/10/28.
//

import SwiftUI

struct ContentView: View {
    
    @State var scale = true
    @State var search = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("輸入欲搜尋天氣之城市名稱", text: $search).textFieldStyle(RoundedBorderTextFieldStyle()).padding(30)
                Toggle("華氏/攝氏", isOn: $scale)
                    .padding(.horizontal, 30)
                NavigationLink(
                    destination: DisplayWeatherView(city: search, wantScale: scale),
                    label: {
                        Text("查詢")
                    })
                .foregroundColor(.blue)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 3))
            }
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}

struct DisplayWeatherView: View {
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
    var taskDateFormat: DateFormatter{
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd, HH:mm"
        return formatter
    }
    
    let dueDate = Date()
    let event = Event()
    @State var display = ViewData()
    @State var isSuccess = true
    @State var city: String
    @State var wantScale: Bool
    
    var body: some View {
        VStack{
            if isSuccess {
                if display.getTemp {
                    Text("\(dueDate, formatter: self.taskDateFormat)")
                        .font(.subheadline)
                    Text("\(display.city)").font(.largeTitle)
                    Text("\(display.weatherDescription)")
                        .font(.title)
                    HStack{
                        Image(systemName: (icon[display.weatherDescription] ?? icon["Clear"]!))
                            .resizable()
                            .frame(width: 50, height: 50, alignment: .center)
                        if wantScale {
                            Text("\(display.temperature)°C")
                                .font(.largeTitle)
                        } else {
                            Text("\(display.temperature * (9/5) + 32)°F")
                        }
                    }
                } else {
                    Text("請稍等...")
                        .font(.largeTitle)
                        .multilineTextAlignment(.center)
                }
            } else {
                Text("查詢錯誤")
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
            }
            
        }
        .onAppear(){
            event.setCity(getCity: city) { (viewData, isSuccess) in
                self.display = viewData!
                self.isSuccess = isSuccess
            }
        }
    }
    
    struct DisplayWeatherView_Previews: PreviewProvider {
        static var previews: some View {
            DisplayWeatherView(city: "Taipei", wantScale: true)
        }
    }
}
