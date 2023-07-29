//
//  ProductDetailViewController.swift
//  PazaramaCloneApp
//
//  Created by bora ateş on 26.07.2023.
//

import UIKit
import SnapKit

class ProductDetailViewController: BaseViewController<ProductDetailViewModel> {
    
    private let scrollView: CustomScroll = {
        let scroll = CustomScroll()
        
        return scroll
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    private let backArrow: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "leftArrow"), for: .normal)
        return button
    }()
    
    private let basketButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "basket"), for: .normal)
        return button
    }()
    
    private lazy var imageCollection: ContentSizedCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = .zero
        layout.minimumInteritemSpacing = .zero
        let collectionView = ContentSizedCollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.layer.masksToBounds = true
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(ImagesCollectionViewCell.self, forCellWithReuseIdentifier: "imagesCell")
        
        return collectionView
    }()
    
    private let pageController: UIPageControl = {
        let page = UIPageControl()
        page.backgroundColor = .clear
        page.tintColor = .systemGray5
        page.pageIndicatorTintColor = .black
        
        return page
    }()
    
    private let productInformation: ProductInformationView = {
        let view = ProductInformationView()
        
        return view
    }()
    
    private lazy var bottomView: ProductDetailBottomView = {
        let view = ProductDetailBottomView()
        view.delegate = self
        view.backgroundColor = .white
        
        return view
    }()
        
    var productResponse: ProductResponse?
    var productImages: [String] = []
    var currentIndex: Int = 0
    var currentPage = 0

    
    override init(with viewModel: ProductDetailViewModel) {
        super.init(with: viewModel)
        
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        backArrow.addTarget(self, action: #selector(backArrowClicked), for: .touchUpInside)
        basketButton.addTarget(self, action: #selector(addBasketClicked), for: .touchUpInside)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        configureUI()
        DispatchQueue.main.async {
            self.imageCollection.reloadData()
        }
        
    }
    
    @objc func backArrowClicked() {
        self.popVC()
    }
    
    @objc func addBasketClicked() {
        print("my basket opening")
        let vc = BasketViewController(with: .init())
        vc.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func configureUI() {
      //  self.productImages = productResponse?.images ?? []
        guard let response =  self.productResponse else { return }
        self.productImages = response.images
        
        pageController.numberOfPages = response.images.count
        pageController.currentPage = currentIndex
        
        productInformation.configureUI(with: response)
        
        bottomView.configureUI(with: response)
        
    }
    
}

extension ProductDetailViewController {
    
    func layout() {
        
        view.backgroundColor = .white
        
        let width = screen.width - 20
        scrollView.contentSize.width = width
        
        let height = screen.height * 1.5
        
        view.addSubview(backArrow)
        backArrow.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(25)
            make.height.equalTo(25)
        }
        
        view.addSubview(basketButton)
        basketButton.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(20)
            make.trailing.equalToSuperview().inset(16)
            make.width.equalTo(25)
            make.height.equalTo(25)
        }
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(self.backArrow.snp.bottom)
            make.leading.equalTo(self.view.snp.leading).offset(10)
            make.trailing.equalTo(self.view.snp.trailing).inset(10)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)

        }

        imageCollection.heightAnchor.constraint(equalToConstant: screen.width + 50).isActive = true
        scrollView.stackView.addArrangedSubview(imageCollection)
        
        pageController.heightAnchor.constraint(equalToConstant: 20).isActive = true
        scrollView.stackView.addArrangedSubview(pageController)
        
        productInformation.heightAnchor.constraint(equalToConstant: screen.height).isActive = true
        scrollView.stackView.addArrangedSubview(productInformation)
        
        
        view.addSubview(bottomView)
        bottomView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(20)
            make.height.equalTo(80)
        }
       
        bottomView.addShadow()
        
    }
    
}

extension ProductDetailViewController: ProductDetailBottomViewDelegate {
    
    func addBasketButtonAction() {
        
        print("added to basket by detail")
        guard let response =  self.productResponse else { return }

        CoreDataManager.shared.createItem(with: response)
        
        Utils.shared.showPopup(title: "", message: "ürün sepete eklendi", view: self)
        
    }
    
}

extension ProductDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = imageCollection.dequeueReusableCell(withReuseIdentifier: "imagesCell", for: indexPath) as! ImagesCollectionViewCell
        
        cell.configure(with: productImages[indexPath.row])
                
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        let page = Int((scrollView.contentOffset.x + width / 2) / width)
        if currentPage != page {
            currentPage = page
            pageController.currentPage = currentPage
        }
    }
    
    
}

extension ProductDetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: screen.width, height: screen.width)
        
    }
    
}

