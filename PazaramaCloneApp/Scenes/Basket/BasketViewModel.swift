//
//  BasketViewModel.swift
//  PazaramaCloneApp
//
//  Created by bora ateş on 26.07.2023.
//

import Foundation


protocol BasketViewModelOutput: ViewModelOutputProtocol {
    func configureItems(with items: [ProductListItem])
    func configureTotalPrice(with price: String)
}

protocol BasketViewModelInput: ViewModelProtocol {
    func fetchDatas()
}

class BasketViewModel: BasketViewModelInput {

    typealias T = BasketViewModelOutput
    weak var outputDelegate: T?

    func fetchDatas() {
        
        let products = CoreDataManager.shared.getAllItems()
        
        print("basket products : \(products)")

        self.outputDelegate?.configureItems(with: products)
        
        calculateTotalPrice(with: products)
        
    }
    
    func calculateTotalPrice(with products: [ProductListItem]) {
        var total = 0
        
        products.forEach { prod in
            let price = Int(prod.price ?? "")
            total += price ?? 0
        }
        
        let formattedPrice = Utils.shared.formatPrice(price: Double(total)) ?? ""
        
        self.outputDelegate?.configureTotalPrice(with: formattedPrice)
    }
    
    func deleteSelectedItem(with product: ProductListItem) {
        
        CoreDataManager.shared.deleteItem(item: product)
        fetchDatas()
    }
    
    func deleteAllItems(with products: [ProductListItem]) {
        
        products.forEach { item in
            CoreDataManager.shared.deleteItem(item: item)
        }
        
        fetchDatas()
        
    }
    
}
