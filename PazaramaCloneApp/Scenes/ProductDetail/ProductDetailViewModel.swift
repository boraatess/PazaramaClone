//
//  ProductDetailViewModel.swift
//  PazaramaCloneApp
//
//  Created by bora ateş on 26.07.2023.
//

import Foundation

protocol ProductDetailViewModelOutput: ViewModelOutputProtocol {
   
}

protocol ProductDetailViewModelInput: ViewModelProtocol {
    func fetchDatas()
}

class ProductDetailViewModel: ProductDetailViewModelInput {

    typealias T = ProductDetailViewModelOutput
    weak var outputDelegate: T?

    
    func fetchDatas() {
        
    }
    
    
}
