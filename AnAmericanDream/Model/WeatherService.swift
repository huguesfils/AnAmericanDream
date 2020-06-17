//
//  WeatherService.swift
//  AnAmericanDream
//
//  Created by Hugues Fils Caparos on 27/02/2020.
//  Copyright © 2020 Hugues Fils Caparos. All rights reserved.
//

import Foundation

class WeatherService {
    
    private enum WeatherError: Error {
        case noResponse
        case statusCodeIncorrect
        case noData
        case cantEncodeLocation
        case urlGenerationError
    }
    
    private static let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?"
    
    private let weatherSession: URLSession
       init(weatherSession: URLSession = URLSession(configuration: .default)) {
           self.weatherSession = weatherSession
       }
    
    func getWeather(defaultLocation: String?, latitude: Double?, longitude: Double?, completionHandler: @escaping (WeatherResponse?, Error?) -> ()) {
        
        let fullUrl: String
        if let defaultLocation = defaultLocation?
            .addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) {
            fullUrl = WeatherService.weatherUrl + "q=\(defaultLocation)&units=metric&appid=\(weatherKey)"
        } else if let latitude = latitude, let longitude = longitude {
            fullUrl = WeatherService.weatherUrl + "lat=\(latitude)&lon=\(longitude)&units=metric&appid=\(weatherKey)"
        } else {
            completionHandler(nil, WeatherError.urlGenerationError)
            return
        }
        guard let url = URL(string: fullUrl) else {
            completionHandler(nil, WeatherError.urlGenerationError)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = weatherSession.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard error == nil else {
                    completionHandler(nil, error)
                    return
                }
                guard let response = response as? HTTPURLResponse else {
                    completionHandler(nil, WeatherError.noResponse)
                    return
                }
                guard response.statusCode == 200 else {
                    completionHandler(nil, WeatherError.statusCodeIncorrect)
                    print(response.statusCode)
                    return
                }
                
                guard let data = data else {
                    completionHandler(nil, WeatherError.noData)
                    return
                }
                
                do {
                    let responseJSON = try JSONDecoder().decode(WeatherResponse.self, from: data)
                    completionHandler(responseJSON, error)
                } catch {
                    completionHandler(nil, error)
                }
            }
        }
        task.resume()
    }
}
