//
//  ProductCollectionViewCell.swift
//  PazaramaCloneApp
//
//  Created by bora ateş on 26.07.2023.
//

import UIKit
import SnapKit
import Kingfisher

protocol ProductCollectionViewCellDelegate: AnyObject {
    func productAddedtoBasket(with product: ProductResponse)
}

class ProductCollectionViewCell: UICollectionViewCell {
    
    private let viewContent: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.systemGray5.cgColor
        return view
    }()
    
    private let productImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    private let addBasketButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sepete Ekle", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 8
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        return button
    }()
    
    var productResult: ProductResponse?
    weak var delegate: ProductCollectionViewCellDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layout()
        addBasketButton.addTarget(self, action: #selector(addBasketClicked), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc func addBasketClicked() {
        print("sepete eklendi")
        
        guard let response = self.productResult else { return }
        delegate?.productAddedtoBasket(with: response)
    }
    
    func configureCell(with response: ProductResponse) {
        self.productResult = response
        titleLabel.text = response.name
        
        let formattedPrice = Utils.shared.formatPrice(price: Double(response.price) ?? 0)
        priceLabel.text = formattedPrice
        descriptionLabel.text = response.description
        
        let urlString = response.imageUrl
        productImage.kf.setImage(with: URL(string: urlString))
    }
    
    func layout() {
        
        addSubview(viewContent)
        viewContent.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().inset(5)
            make.bottom.equalToSuperview().inset(5)
        }
        
        viewContent.addSubview(productImage)
        productImage.snp.makeConstraints { make in
            make.top.equalTo(self.viewContent.snp.top)
            make.leading.equalTo(self.viewContent.snp.leading)
            make.trailing.equalTo(self.viewContent.snp.trailing)
            make.height.equalTo(250)
        }
        
        viewContent.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.productImage.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview()
        }
        
        viewContent.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(6)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview()
        }
        
        viewContent.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(self.descriptionLabel.snp.bottom).offset(6)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview()
        }
        
        viewContent.addSubview(addBasketButton)
        addBasketButton.snp.makeConstraints { make in
            make.top.equalTo(self.priceLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().inset(10)
        }
        
    }
    
}
