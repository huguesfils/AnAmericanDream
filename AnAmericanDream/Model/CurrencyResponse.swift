//
//  CurrencyResponse.swift
//  AnAmericanDream
//
//  Created by Hugues Fils Caparos on 14/02/2020.
//  Copyright © 2020 Hugues Fils Caparos. All rights reserved.
//

import Foundation

struct CurrencyResponse: Codable {
    var base: String
    var rates: [String: Double]
}
