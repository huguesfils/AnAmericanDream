//
//  TranslationResponse.swift
//  AnAmericanDream
//
//  Created by Hugues Fils Caparos on 11/02/2020.
//  Copyright © 2020 Hugues Fils Caparos. All rights reserved.
//

import Foundation

struct TranslationResponse: Codable {
    var data: TranslationData?
}

struct TranslationData: Codable {
    var translations: [Translations]
}

struct Translations: Codable {
    var translatedText: String
}
