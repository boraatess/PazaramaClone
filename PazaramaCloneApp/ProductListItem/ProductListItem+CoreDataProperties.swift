//
//  ProductListItem+CoreDataProperties.swift
//  PazaramaCloneApp
//
//  Created by bora ateş on 28.07.2023.
//
//

import Foundation
import CoreData


extension ProductListItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductListItem> {
        return NSFetchRequest<ProductListItem>(entityName: "ProductListItem")
    }

    @NSManaged public var name: String?
    @NSManaged public var price: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var productDesc: String?

}

extension ProductListItem : Identifiable {

}
