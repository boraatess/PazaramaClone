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


/* struct Job {
 let number: Int
 let name, client: String
}
extension Job: Codable {
 init(dictionary: [String: Any]) throws {
     self = try JSONDecoder().decode(Job.self, from: JSONSerialization.data(withJSONObject: dictionary))
 }
 private enum CodingKeys: String, CodingKey {
     case number = "jobNumber", name = "jobName", client
 }
}*/
