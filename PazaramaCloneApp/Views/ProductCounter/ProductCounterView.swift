//
//  ProductCounterView.swift
//  PazaramaCloneApp
//
//  Created by bora ateş on 30.07.2023.
//

import UIKit
import SnapKit


protocol ProductCounterViewDelegate: AnyObject {
    func minusButtonAction()
    func plusButtonAction()
}


class ProductCounterView: UIView {
    
    private let hStackView: UIStackView = {
        let view = UIStackView()
        view.backgroundColor = .clear
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.alignment = .fill
        return view
    }()
    
    private let incrementButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "minus"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()
    
    private let productCount: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        label.text = "1"
        return label
    }()
    
    private let decrimentButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "plus"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()
    
    weak var delegate: ProductCounterViewDelegate?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layout()
        
        incrementButton.addTarget(self, action: #selector(incrementActionClicked), for: .touchUpInside)
        decrimentButton.addTarget(self, action: #selector(decrimentActionClicked), for: .touchUpInside)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
        
    }
    
    @objc func incrementActionClicked() {
        print("minus Clicked")
        delegate?.minusButtonAction()
        
    }
    
    @objc func decrimentActionClicked() {
        print("plus Clicked")
        delegate?.plusButtonAction()
        
        
    }
    
    func updateProducCount(with count: String) {
        productCount.text = count
        
    }
    
    func layout() {
        
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray5.cgColor
        
        hStackView.addArrangedSubview(incrementButton)
        hStackView.addArrangedSubview(productCount)
        hStackView.addArrangedSubview(decrimentButton)
        
        addSubview(hStackView)
        hStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            
        }
        
        /*
        addSubview(incrementButton)
        incrementButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.leading.equalToSuperview().offset(10)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
        addSubview(productCount)
        productCount.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.leading.equalTo(self.incrementButton.snp.trailing).offset(10)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
     
        
        addSubview(decrimentButton)
        decrimentButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.leading.equalTo(self.productCount.snp.trailing).offset(10)
            make.trailing.equalToSuperview()
            make.width.equalTo(50)
            make.height.equalTo(50)
            
        }
        */
        
    }
    
    
    
}
