//
//  Weather.swift
//  SearchWeatherApplication
//
//  Created by BoMin on 2023/03/08.
//

import Foundation

struct WeatherResult: Decodable {
    let main: Weather
}

extension WeatherResult {
    
    static var empty: WeatherResult {
        return WeatherResult(main: Weather(temp: 0.0, feelsLike: 0.0, humidity: 0.0))
    }
    
}

struct Weather: Decodable {
    let temp: Double
    let feelsLike: Double
    let humidity: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case humidity
    }
}
