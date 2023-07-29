//
//  ContentSizedCollectionView.swift
//  PazaramaCloneApp
//
//  Created by bora ateş on 26.07.2023.
//

import UIKit

final class ContentSizedCollectionView: UICollectionView {
    override var contentSize:CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}
