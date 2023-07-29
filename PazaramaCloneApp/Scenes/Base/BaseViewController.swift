//
//  BaseViewController.swift
//  PazaramaCloneApp
//
//  Created by bora ateş on 26.07.2023.
//

import UIKit

class BaseViewController<ViewModel>: UIViewController where ViewModel: ViewModelProtocol {
    
    var viewModel: ViewModel
    
    let screen = UIScreen.main.bounds
    
    var basketProducts: [ProductResponse] = []

    
    init(with viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel.outputDelegate = self as? ViewModel.T
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.viewDidAppear()
    }
}

extension BaseViewController {
    func popVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension BaseViewController: ViewModelOutputProtocol {
    
    
}
