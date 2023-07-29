//
//  CustomScroll.swift
//  PazaramaCloneApp
//
//  Created by bora ateş on 28.07.2023.
//

import Foundation

import UIKit

final class CustomScroll: UIScrollView {
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .clear
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.spacing = 6
        let contentInset = UIView()
        contentInset.heightAnchor.constraint(equalToConstant: 6).isActive = true
        stackView.addArrangedSubview(contentInset)
        return stackView
    }()
    
    init() {
        super.init(frame: .zero)
        
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        addSubview(stackView)
        stackView.snp.makeConstraints { maker in
            maker.leading.trailing.top.bottom.equalToSuperview()
            maker.width.equalToSuperview()
        }
    }
}

