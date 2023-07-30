//
//  FeaturesCell.swift
//  PazaramaCloneApp
//
//  Created by bora ateş on 28.07.2023.
//

import UIKit
import SnapKit
import ExpandableLabel

class FeaturesCell: UITableViewCell {
    
    private let featureName: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    private let featureValue: UILabel = {
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
    
    func layout() {
        addSubview(featureName)
        featureName.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
        }
        
        addSubview(featureValue)
        featureValue.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(10)
        }
        
    }
    
    func configure(with viewModel: FeaturesViewModel) {
        featureName.text = viewModel.name
        featureValue.text = viewModel.value
    }
    
}
