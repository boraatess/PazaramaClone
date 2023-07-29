//
//  DescriptionCell.swift
//  PazaramaCloneApp
//
//  Created by bora ateş on 28.07.2023.
//

import UIKit
import SnapKit
import ExpandableLabel

class DescriptionCell: UITableViewCell {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 16)
        label.text = "Ürün Açıklaması"
        label.numberOfLines = 0
        return label
    }()
    
    private let descLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 16)
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    func layout() {
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview()
        }
        
        addSubview(descLabel)
        descLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview()
            
            
        }
        
    }
    
    func configure(with description: String) {
        descLabel.text = description
    }
    
}
