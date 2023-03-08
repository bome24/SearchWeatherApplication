//
//  URL+Extensions.swift
//  SearchWeatherApplication
//
//  Created by BoMin on 2023/03/09.
//

import Foundation

extension URL {
    
    static func urlForWeatherAPI(city: String) -> URL? {
        return URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=b18d003fffe8e60291054e8e5b2d9590&units=metric")
    }
    
}
