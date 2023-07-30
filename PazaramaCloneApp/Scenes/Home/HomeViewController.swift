//
//  HomeViewController.swift
//  PazaramaCloneApp
//
//  Created by bora ateş on 26.07.2023.
//

import UIKit
import SnapKit


class HomeViewController: BaseViewController<HomeViewModel> {
    
    private let topView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let iconImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "pazaramaLogo")
        return iv
    }()
    
    private let basketButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "basket"), for: .normal)
        
        return button
    }()
    
    private let searchView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = .systemGray6
        return view
    }()
    
    private let iconSearch: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "search")
        return iv
    }()
    
    private lazy var searchTextField: UITextField = {
        let search = UITextField()
        search.placeholder = "Marka, ürün veya hizmet ara"
        search.delegate = self
        
        return search
    }()
    
    private lazy var collectionView: ContentSizedCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = .zero
        layout.minimumInteritemSpacing = .zero
        let collectionview = ContentSizedCollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.delegate = self
        collectionview.dataSource = self
        collectionview.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: "productCell")
        collectionview.backgroundColor = .clear
        return collectionview
    }()
    
    var productsArray: [ProductResponse] = []
    var filteredArray: [ProductResponse] = []
    
    override init(with viewModel: HomeViewModel) {
        super.init(with: viewModel)
        
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        viewModel.fetchDatas()

        basketButton.addTarget(self, action: #selector(addBasketClicked), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
   
        filteredArray = productsArray
    }
    
    @objc func addBasketClicked() {
        print("my basket opening")
        let vc = BasketViewController(with: .init())
        vc.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension HomeViewController {
    
    func layout() {
        
        view.backgroundColor = .white
                
        view.addSubview(topView)
        topView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(16)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(150)
        }
        
        topView.addSubview(iconImage)
        iconImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(30)
            make.width.equalTo(150)
            
        }
        
        topView.addSubview(basketButton)
        basketButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().inset(16)
            make.width.equalTo(32)
            make.height.equalTo(32)
        }
        
        topView.addSubview(searchView)
        searchView.snp.makeConstraints { make in
            make.top.equalTo(self.iconImage.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        
        searchView.addSubview(iconSearch)
        iconSearch.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview().offset(15)
            make.width.equalTo(16)
            make.height.equalTo(16)
        }
        
        searchView.addSubview(searchTextField)
        searchTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.leading.equalTo(self.iconSearch.snp.trailing).offset(20)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(5)
        }
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(self.topView.snp.bottom).offset(5)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
    }
    
}

extension HomeViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""

        filterDataForSearchText(currentText)
        
        return true
        
    }
    
    // MARK: - Data Filtering
     
     func filterDataForSearchText(_ searchText: String) {
         if searchText.isEmpty {
             filteredArray = productsArray
         } else {
             filteredArray = productsArray.filter { $0.name.lowercased().contains(searchText.lowercased()) }
         }
         
         collectionView.reloadData()
     }
    
}

extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let response = self.filteredArray[indexPath.row]
        let vc = ProductDetailViewController(with: .init())
        vc.productResponse = response
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCollectionViewCell
        
        let response = filteredArray[indexPath.row]
        cell.configureCell(with: response)
        cell.delegate = self
        return cell
    }
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width / 2
        return CGSize(width: width - 10, height: 450)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 5)
    }
    
}

extension HomeViewController: ProductCollectionViewCellDelegate {
    
    func productAddedtoBasket(with product: ProductResponse) {
        CoreDataManager.shared.createItem(with: product)
        Utils.shared.showPopup(title: "", message: "ürün sepete eklendi", view: self)
    }
    
}

extension HomeViewController: HomeViewModelOutput {
    
    func configureProducts(with products: [ProductResponse]) {
        print("home products : \(products)")
        self.productsArray = products
        filteredArray = productsArray

        DispatchQueue.main.async {
            self.collectionView.reloadData()
            
        }
    }
    
}
