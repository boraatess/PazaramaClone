//
//  SplashViewModel.swift
//  PazaramaCloneApp
//
//  Created by bora ateş on 26.07.2023.
//

import Foundation

protocol SplashViewModelOutput: ViewModelOutputProtocol {
    func goHomeView()
    func showError(error: String)
}

protocol SplashViewModelInput: ViewModelProtocol {
    func checkNetworkConnection()
    
}

final class SplashViewModel: SplashViewModelInput {
    
 
    typealias T = SplashViewModelOutput
    weak var outputDelegate: T?

    
    func checkNetworkConnection() {
        
        if Reachability.isConnectedToNetwork() {
            print("Internet Connection Available!")
            self.outputDelegate?.goHomeView()
            
        }
        else{
            print("Internet Connection not Available!")
            self.outputDelegate?.showError(error: "Internet Connection not Available!")
            
        }
        
    }
    
}
 
