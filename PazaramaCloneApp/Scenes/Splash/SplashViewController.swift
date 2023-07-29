//
//  SplashViewController.swift
//  PazaramaCloneApp
//
//  Created by bora ateş on 26.07.2023.
//

import UIKit

class SplashViewController: BaseViewController<SplashViewModel> {
    
    private let appLogoImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "pazaramaLogo")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    override init(with viewModel: SplashViewModel) {
        super.init(with: viewModel)
        
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.viewModel.checkNetworkConnection()
    }
    
    func showHome() {
        let vc = HomeViewController(with: .init())
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        nav.navigationController?.isNavigationBarHidden = true
        nav.navigationBar.isHidden = true
        present(nav, animated: true)
    }
    
    
}

extension SplashViewController {
    
    func layout() {
        
        view.backgroundColor = .white
        
        view.addSubview(appLogoImage)
        appLogoImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
        
    }
    
}

extension SplashViewController: SplashViewModelOutput {
    
    func showError(error: String) {
        print("error : \(error)")
        Utils.shared.showPopup(title: "Warning!", message: error, view: self)
    }
   
    func goHomeView() {
        self.showHome()
        
    }
    
}
