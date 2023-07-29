//
//  BasketTableviewCell.swift
//  PazaramaCloneApp
//
//  Created by bora ateş on 28.07.2023.
//

import UIKit
import SnapKit

class BasketTableviewCell: UITableViewCell {
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.borderColor = UIColor.systemGray.cgColor
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    private let productName: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        
        return label
    }()
    
    private let splitView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        
        return view
    }()
    
    private let productImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 8
        
        return image
    }()
    
    private let productDesc: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        
        return label
    }()
    
    private let productPrice: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layout()
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
        
    }
    
    func configure(with model: ProductListItem ) {
        
        let name = model.name ?? ""
        let desc = model.productDesc ?? ""

        productName.text = name
        
        let urlString = model.imageUrl ?? ""
        
        productImage.kf.setImage(with: URL(string: urlString))
        
        productDesc.text =  desc
        
        let formattedPrice = Utils.shared.formatPrice(price: Double(model.price ?? "") ?? 0 )
        
        
        productPrice.text = formattedPrice
        
    }
    
    func layout() {
        
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10)
        }
        
        containerView.addSubview(productName)
        productName.snp.makeConstraints { make in
            make.top.equalTo(self.containerView.snp.top).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview()
            
        }
        
        containerView.addSubview(splitView)
        splitView.snp.makeConstraints { make in
            make.top.equalTo(self.productName.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(10)
            make.height.equalTo(2)
        }
        
        containerView.addSubview(productImage)
        productImage.snp.makeConstraints { make in
            make.top.equalTo(self.splitView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(80)
            make.width.equalTo(80)
            
        }
        
        containerView.addSubview(productDesc)
        productDesc.snp.makeConstraints { make in
            make.top.equalTo(self.splitView.snp.bottom).offset(20)
            make.leading.equalTo(self.productImage.snp.trailing).offset(20)
            make.trailing.equalToSuperview()
        }
        
        containerView.addSubview(productPrice)
        productPrice.snp.makeConstraints { make in
            make.top.equalTo(self.productDesc.snp.bottom).offset(10)
            make.leading.equalTo(self.productImage.snp.trailing).offset(20)
            make.trailing.equalToSuperview()
        }
        
        
        
        
    }
    
    
}
