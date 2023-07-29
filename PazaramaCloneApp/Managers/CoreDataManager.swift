//
//  CoreDataManager.swift
//  PazaramaCloneApp
//
//  Created by bora ateş on 28.07.2023.
//

import Foundation
import UIKit

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    func getAllItems() -> [ProductListItem] {
        var items = [ProductListItem]()
        
        do {
            items = try context.fetch(ProductListItem.fetchRequest())
            return items
            
        }
        catch {
            
            print("error...")
        }
        
        return items
        
    }
    
    func createItem(with product: ProductResponse) {
        
        var newItem = ProductListItem(context: context)
        newItem.name = product.name
        newItem.imageUrl = product.imageUrl
        newItem.price = product.price
        newItem.productDesc = product.description
        
        
        do {
            try context.save()
        }
        catch {
            
            print("error...")
        }
        
    }
    
    func deleteItem(item : ProductListItem) {
        
        context.delete(item)
        
        do {
            try context.save()
        }
        catch {
            
            print("error...")
        }
        
    }
    
    func updateItem(item : ProductListItem) {
        
        do {
            
        }
        catch {
            
            print("error...")
        }
        
    }
    
    
}
