//
//  WeatherResponse.swift
//  AnAmericanDream
//
//  Created by Hugues Fils Caparos on 27/02/2020.
//  Copyright © 2020 Hugues Fils Caparos. All rights reserved.
//

import Foundation

struct WeatherResponse: Codable {
    var weather: [Weather]
    var main: Main
}

struct Weather: Codable {
    var icon: String
    var main: String
}

struct Main: Codable {
    var temp: Double
}
