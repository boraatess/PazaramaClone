//
//  DemoObject.swift
//  PazaramaCloneApp
//
//  Created by bora ateş on 27.07.2023.
//

import Foundation


class DemoObject: Encodable {
    
    var id: String = ""
    var productId: String = ""
    var name: String = ""
    var description: String = ""
    var longDescription: String = ""
    var imageUrl: String = ""
    var images: [String] = []
    var price: String = ""
    var size: String = ""
    var armType: String = ""
    var patternName: String = ""
}

extension Encodable {
    
    var toDict: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else {
            return nil
        }
        
        return try? JSONSerialization.jsonObject(with: data,options: .fragmentsAllowed) as? [String : Any]
    }
    
}
