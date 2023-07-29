//
//  ImagesCollectionViewCell.swift
//  PazaramaCloneApp
//
//  Created by bora ateş on 28.07.2023.
//

import UIKit
import SnapKit

class ImagesCollectionViewCell: UICollectionViewCell {
    
    private let imageCover: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
        
    }
    
    func layout() {
        
        addSubview(imageCover)
        imageCover.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            
        }
        
    }
    
    func configure(with urlString: String) {
        
        imageCover.kf.setImage(with: URL(string: urlString))
        
        
    }
    
}
