//
//  TranslationService.swift
//  AnAmericanDream
//
//  Created by Hugues Fils Caparos on 11/02/2020.
//  Copyright © 2020 Hugues Fils Caparos. All rights reserved.
//

import Foundation

class TranslationService {
    
    private enum TranslationError: Error {
        case noResponse
        case statusCodeIncorrect
        case noData
    }
    
    private static let translationUrL = URL(string: "https://translation.googleapis.com/language/translate/v2")!
    
    private let translationSession: URLSession
    init(translationSession: URLSession = URLSession(configuration: .default)) {
        self.translationSession = translationSession
    }
    
    func getTranslation(text: String, from: String, to: String, completionHandler : @escaping (TranslationResponse?, Error?) -> ()) {
        var request = URLRequest(url: TranslationService.translationUrL)
        request.httpMethod = "POST"
        
        let body = "q=\(text)&target=\(to)&format=text&source=\(from)&key=\(translationKey)"
        request.httpBody = body.data(using: .utf8)
        
        let task = translationSession.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard error == nil else {
                    completionHandler(nil, error)
                    return
                }
                guard let response = response as? HTTPURLResponse else {
                    completionHandler(nil, TranslationError.noResponse)
                    return
                }
                guard response.statusCode == 200 else {
                    completionHandler(nil, TranslationError.statusCodeIncorrect)
                    print(response.statusCode)
                    return
                }
                
                guard let data = data else {
                    completionHandler(nil, TranslationError.noData)
                    return
                }
                
                do {
                    let responseJSON = try JSONDecoder().decode(TranslationResponse.self, from: data)
                    completionHandler(responseJSON, error)
                } catch {
                    completionHandler(nil, error)
                }
            }
        }
        task.resume()
    }
}
