//
//  ProductResponse.swift
//  PazaramaCloneApp
//
//  Created by bora ateş on 27.07.2023.
//

import Foundation

struct ProductResponse: Codable {
    let id: String
    let productId: String
    let name: String
    let description: String
    let longDescription: String
    let imageUrl: String
    let images: [String]
    let price: String
    let features: Features
}

struct Features: Codable {
    let size: String
    let armType: String
    let patternName: String
}
