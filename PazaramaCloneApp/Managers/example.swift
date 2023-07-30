//
//  example.swift
//  PazaramaCloneApp
//
//  Created by bora ateş on 31.07.2023.
//

import Foundation
 
/*
 
 // add product to core data
 static func addProduct(product: Product) {
     let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
     let entity = NSEntityDescription.entity(forEntityName: "ProductItem", in: context)
     // control product is exist or not
     for item in getAllProducts() {
         if item.title == product.title {
             item.quantity += 1
             do {
                 try context.save()
             } catch {
                 print("Failed saving")
             }
             return
         }
     }
     let newProduct = NSManagedObject(entity: entity!, insertInto: context)
     newProduct.setValue(product.title, forKey: "title")
     newProduct.setValue(product.price, forKey: "price")
     newProduct.setValue(1, forKey: "quantity")
     do {
         try context.save()
     } catch {
         print("Failed saving")
     }
 }

 // plus product quantity
 static func plusProductQuantity(product: ProductItem) {
     let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
     product.quantity += 1
     do {
         try context.save()
     } catch {
         print("Failed saving")
     }
 }

 // minus product quantity
 static func minusProductQuantity(product: ProductItem) {
     let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
     if product.quantity > 1 {
         product.quantity -= 1
     }
     do {
         try context.save()
     } catch {
         print("Failed saving")
     }
 }
 
 */
