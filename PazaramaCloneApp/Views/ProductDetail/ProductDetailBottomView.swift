//
//  ProductDetailBottomView.swift
//  PazaramaCloneApp
//
//  Created by bora ateş on 27.07.2023.
//

import UIKit
import SnapKit

protocol ProductDetailBottomViewDelegate: AnyObject {
    func addBasketButtonAction()
}

class ProductDetailBottomView: UIView  {
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        
        return label
    }()
    
    private let addBasketButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sepete Ekle", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 8
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        return button
    }()
    
    weak var delegate: ProductDetailBottomViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layout()
        addBasketButton.addTarget(self, action: #selector(clickedConfirmButton), for: .touchUpInside)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc func clickedConfirmButton() {
        delegate?.addBasketButtonAction()
        
    }
    
    
    func layout() {
        addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().inset(16)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
        
        addSubview(addBasketButton)
        addBasketButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16)
            make.width.equalTo(200)
            make.height.equalTo(40)

        }
        
    }
    
    func configureUI(with response: ProductResponse) {
        let formattedPrice = Utils.shared.formatPrice(price: Double(response.price) ?? 0) ?? ""

        priceLabel.text = formattedPrice
        
        
    }
    
}
