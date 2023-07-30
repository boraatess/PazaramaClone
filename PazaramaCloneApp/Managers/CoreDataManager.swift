//
//  CoreDataManager.swift
//  PazaramaCloneApp
//
//  Created by bora ateş on 28.07.2023.
//

import Foundation
import UIKit
import CoreData

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
        
        let entity = NSEntityDescription.entity(forEntityName: "ProductListItem", in: context)
        
        for item in getAllItems() {
            if item.productID == product.productId {
                item.quantity += 1
                do {
                    try context.save()
                } catch {
                    print("Failed saving")
                }
                return
            }
        }
        
        let newItem = ProductListItem(context: context)
        newItem.name = product.name
        newItem.imageUrl = product.imageUrl
        newItem.price = product.price
        newItem.productDesc = product.description
        newItem.productID = product.productId
        newItem.quantity = 1
        
        do {
            try context.save()
        }
        catch {
            print("Failed saving")
        }
        
    }
    
    // plus product quantity
    func plusProductQuantity(product: ProductListItem) {
        product.quantity += 1
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }

    // minus product quantity
    func minusProductQuantity(product: ProductListItem) {
      
        if product.quantity > 1 {
            product.quantity -= 1
        }
        do {
            try context.save()
        } catch {
            print("Failed saving")
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
