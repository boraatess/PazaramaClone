//
//  HomeViewModel.swift
//  PazaramaCloneApp
//
//  Created by bora ateş on 26.07.2023.
//

import Foundation
import FirebaseDatabase

protocol HomeViewModelOutput: ViewModelOutputProtocol {
    func configureProducts(with products: [ProductResponse])
}

protocol HomeViewModelInput: ViewModelProtocol {
    func fetchDatas()
}

final class HomeViewModel: HomeViewModelInput {
    
 
    typealias T = HomeViewModelOutput
    weak var outputDelegate: T?
    
    let reference = Database.database().reference()
    
    var listObject = [DemoObject]()
    
    var productsArray: [ProductResponse] = []

    
    func fetchDatas() {
        
        for i in 0...9 {
            
            reference.child(String(i)).observeSingleEvent(of: .value) { dataSnap in
                
                guard let value = dataSnap.value as? [String : Any ] else { return }
                
                print("product value \(i): \(value)")
                
                if let name = value["name"] as? String, let price = value["price"] as? String,
                    let desc = value["description"] as? String, let size = value["size"] as? String,
                   let armType = value["armType"] as? String, let url = value["imageUrl"] as? String,
                   let longDescription = value["longDescription"] as? String,
                   let images = value["images"] as? [String],
                   let patternType = value["patternName"] as? String,
                    let productId = value["productId"] as? String  {
                    
                    let response = ProductResponse(id: String(i), productId: productId, name: name, description: desc, longDescription: longDescription, imageUrl: url, images: images, price: price,
                                                   features: Features(size: size, armType: armType, patternName: patternType))
                    
                    self.productsArray.append(response)
                    
                    let count = self.productsArray.count
                    
                    print("Products response : \(self.productsArray) and count : \(count)")
                    
                    if count >= 10 {
                        self.productsArray = self.productsArray.sorted(by: { $0.id < $1.id })
                        
                        self.outputDelegate?.configureProducts(with: self.productsArray)
                        
                    }
                    
                }
                
            }
            
        }
      
    }
    
    
    func readDataByChild() {
        
        
    }
    
    func writeDatasToDB() {
        
        for i in 0...9 {
            
            let demoObject = DemoObject()
            demoObject.id = "\(i)"
            demoObject.productId = UUID().uuidString
            let randomNum = Int.random(in: 1000...10000)
            demoObject.price = "\(randomNum)"
            demoObject.armType = "Kısa Kol"
            demoObject.patternName = "Desenli"
            demoObject.size = "Regular"
            demoObject.name = "Bershka"
            demoObject.imageUrl = "bershka elbise image url"
            demoObject.description = "Bershka uzun elbise"
            demoObject.longDescription = Constants.description
            demoObject.images = ["image url 1", "image url 2", "image url 3"]
            
            
            reference.child(String(i)).setValue(demoObject.toDict)

        }
        
    }
    
    
}
 
