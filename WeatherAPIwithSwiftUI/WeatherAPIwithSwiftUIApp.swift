//
//  WeatherAPIwithSwiftUIApp.swift
//  WeatherAPIwithSwiftUI
//
//  Created by WooL on 2020/10/28.
//

import SwiftUI

@main
struct WeatherAPIwithSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(display: ViewData())
        }
    }
}

struct WeatherAPIwithSwiftUIApp_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
