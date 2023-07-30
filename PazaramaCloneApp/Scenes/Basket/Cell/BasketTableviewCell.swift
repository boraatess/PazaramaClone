//
//  BasketTableviewCell.swift
//  PazaramaCloneApp
//
//  Created by bora ateş on 28.07.2023.
//

import UIKit
import SnapKit

protocol BasketTableviewCellDelegate: AnyObject {
    func decrimentAction()
    func incrementAction()
    
}

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
    
    private let minusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "minus"), for: .normal)
        button.layer.cornerRadius = 6
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray5.cgColor
        return button
    }()
    
    private let productCount: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        label.text = "1"
        label.textAlignment = .center
        return label
    }()
    
    private let plusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "plus"), for: .normal)
        button.layer.cornerRadius = 6
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray5.cgColor
        
        return button
    }()
    
    private let plusAndMinusView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray5.cgColor
        return view
    }()
    
    private let testButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 6
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray5.cgColor
        button.setTitle("test button", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.isUserInteractionEnabled = true
        button.clipsToBounds = true
        return button
    }()
    
    var productItem: ProductListItem?
    weak var delegate: BasketTableviewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.isUserInteractionEnabled = true
        layout()
        minusButton.addTarget(self, action: #selector(minusClicked), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(plusClicked), for: .touchUpInside)
        testButton.addTarget(self, action: #selector(plusClicked), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc func minusClicked() {
        print("minus Clicked")
        guard let productListItem = self.productItem else { return }
        
        if productListItem.quantity == 1 {
            CoreDataManager.shared.deleteItem(item: productListItem)
        }
        else {
            CoreDataManager.shared.minusProductQuantity(product: productListItem)
        }
        
        delegate?.decrimentAction()
    }
    
    @objc func plusClicked() {
        print("plus Clicked")
        guard let productListItem = self.productItem else { return }

        CoreDataManager.shared.plusProductQuantity(product: productListItem)
        delegate?.incrementAction()
    }
    
    func configure(with model: ProductListItem ) {
        self.productItem = model
        let name = model.name ?? ""
        let desc = model.productDesc ?? ""
        productName.text = name
        let urlString = model.imageUrl ?? ""
        productImage.kf.setImage(with: URL(string: urlString))
        productDesc.text =  desc
        let formattedPrice = Utils.shared.formatPrice(price: Double(model.price ?? "") ?? 0 )
        productPrice.text = formattedPrice
        productCount.text = String(model.quantity )
    }
    
    func layout() {
        
        contentView.addSubview(containerView)
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

        containerView.addSubview(plusAndMinusView)
        plusAndMinusView.snp.makeConstraints { make in
            make.top.equalTo(self.productPrice.snp.bottom).offset(20)
            make.leading.equalTo(self.productImage.snp.trailing).offset(20)
            make.width.equalTo(150)
            make.height.equalTo(40)
        }
           
        plusAndMinusView.addSubview(minusButton)
        minusButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(30)
            make.width.equalTo(50)
        }
        
        plusAndMinusView.addSubview(productCount)
        productCount.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(self.minusButton.snp.trailing)
            make.bottom.equalToSuperview()
            make.width.equalTo(50)
            make.height.equalTo(30)
        }
        
        plusAndMinusView.addSubview(plusButton)
        plusButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(self.productCount.snp.trailing)
            make.bottom.equalToSuperview()
            make.width.equalTo(50)
            make.height.equalTo(30)
            make.bottom.equalToSuperview()
            
        }
        
    }
    
}
