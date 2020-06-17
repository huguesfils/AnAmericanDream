//
//  CurrencyService.swift
//  AnAmericanDream
//
//  Created by Hugues Fils Caparos on 11/02/2020.
//  Copyright © 2020 Hugues Fils Caparos. All rights reserved.
//

import Foundation

class CurrencyService {
    
    private enum CurrencyError: Error {
        case noResponse
        case statusCodeIncorrect
        case noData
    }
    
    private static let currencyUrl = URL(string: "http://data.fixer.io/api/latest?access_key=\(currencyKey)")!
    
    private let currencySession: URLSession
    init(currencySession: URLSession = URLSession(configuration: .default)) {
        self.currencySession = currencySession
    }
    
    private var task: URLSessionDataTask?
    func getCurrency(completionHandler: @escaping (CurrencyResponse?, Error?) -> ()) {
        var request = URLRequest(url: CurrencyService.currencyUrl)
        request.httpMethod = "GET"
        
        task?.cancel()
        task = currencySession.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard error == nil else {
                    completionHandler(nil, error)
                    return
                }
                guard let response = response as? HTTPURLResponse else {
                    completionHandler(nil, CurrencyError.noResponse)
                    return
                }
                guard response.statusCode == 200 else {
                    completionHandler(nil, CurrencyError.statusCodeIncorrect)
                    return
                }
                guard let data = data else {
                    completionHandler(nil, CurrencyError.noData)
                    return
                }
                do {
                    let responseJSON = try JSONDecoder().decode(CurrencyResponse.self, from: data)
                    completionHandler(responseJSON, error)
                } catch {
                    completionHandler(nil, error)
                }
            }
        }
        task?.resume()
    }
}
