//
//  BasketViewController.swift
//  PazaramaCloneApp
//
//  Created by bora ateş on 26.07.2023.
//

import UIKit
import SnapKit

class BasketViewController: BaseViewController<BasketViewModel> {
    
    private let backArrow: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "leftArrow"), for: .normal)
        return button
    }()
    
    private let cleanAll: UIButton = {
        let button = UIButton()
        button.setTitle("Sepeti Temizle", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.backgroundColor = .white
        button.titleLabel?.numberOfLines = 0
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textColor = .black
        label.text = "Sepetim"
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    private lazy var tableView: ContentSizedTableView = {
        let tableview = ContentSizedTableView()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(BasketTableviewCell.self, forCellReuseIdentifier: "basketCell")
        
        return tableview
    }()
    
    private let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textColor = .black
        
        return label
    }()
    
    private let confirmBasketButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sepeti Onayla", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        return button
    }()
    
    var productItems = [ProductListItem]()
    
    
    override init(with viewModel: BasketViewModel) {
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
        confirmBasketButton.addTarget(self, action: #selector(confirmButtonClicked), for: .touchUpInside)
        cleanAll.addTarget(self, action: #selector(cleanAllClicked), for: .touchUpInside)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.fetchDatas()
        
    }
    
    @objc func backArrowClicked() {
        self.popVC()
    }
    
    @objc func cleanAllClicked() {
        deleteAllAlert(title: "Uyarı", message: "Tüm ürünleri silmek istiyor musunuz?")
    }
    
    @objc func confirmButtonClicked() {
  
        Utils.shared.showPopup(title: "Uyarı", message: "Henüz hazır değil. geliştirilmeye devam ediliyor", view: self)
    }
    
    func deleteAllAlert(title: String, message: String ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Evet", style: .default) { action in
            self.viewModel.deleteAllItems(with: self.productItems)
        }
        
        let cancel = UIAlertAction(title: "İptal", style: .destructive)
        alert.addAction(yesAction)
        alert.addAction(cancel)
        
        self.present(alert, animated: true)
    }
    
}

extension BasketViewController {
    
    func layout() {
        
        view.backgroundColor = .white
        
        view.addSubview(backArrow)
        backArrow.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(25)
            make.height.equalTo(25)
        }
        
        view.addSubview(cleanAll)
        cleanAll.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(20)
            make.trailing.equalToSuperview().inset(10)
            make.width.equalTo(150)
            make.height.equalTo(20)
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(self.backArrow.snp.trailing).offset(20)
            make.trailing.equalToSuperview()
            make.height.equalTo(30)
        }
        
        view.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(10)
            make.leading.equalTo(self.backArrow.snp.trailing).offset(20)
            make.trailing.equalToSuperview()
            make.height.equalTo(10)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.descriptionLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        view.addSubview(bottomView)
        bottomView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(100)
        }
        
        bottomView.addSubview(confirmBasketButton)
        confirmBasketButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
            make.width.equalTo(200)
        }
        
        bottomView.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leadingMargin.equalToSuperview().offset(16)
            make.trailing.equalTo(self.confirmBasketButton.snp.leading)
            make.height.equalTo(40)

        }
        
    }
    
}

extension BasketViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productItems.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "basketCell", for: indexPath) as! BasketTableviewCell
        
        let model = self.productItems[indexPath.row]
        
        cell.configure(with: model)
        cell.selectionStyle = .none
        cell.isUserInteractionEnabled = true
        cell.contentView.isUserInteractionEnabled = true
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Sil") { _, _, completionHandler in
            
            let product = self.productItems[indexPath.row]
            
            self.showAlert(title: "Uyarı", message: "Bu ürünü silmek istiyor musunuz?", product: product)
            
            completionHandler(true)
            
        }
        
        deleteAction.backgroundColor = .systemRed
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
        
    }
    
    func showAlert(title: String, message: String, product: ProductListItem ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Evet", style: .default) { action in
            self.viewModel.deleteSelectedItem(with: product)
        }
        
        let cancel = UIAlertAction(title: "İptal", style: .destructive)
        
        alert.addAction(yesAction)
        alert.addAction(cancel)
        
        
        self.present(alert, animated: true)
    }
    
}

extension BasketViewController: BasketTableviewCellDelegate {
    
    func decrimentAction() {
        
        viewModel.fetchDatas()
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func incrementAction() {
        
        viewModel.fetchDatas()
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
}

extension BasketViewController: BasketViewModelOutput {
    
    func configureTotalPrice(with price: String) {
        print("total price : \(price)")
        
        priceLabel.text = price
        
    }
    
    func configureItems(with items: [ProductListItem]) {
        print("items : \(items)")
        
        descriptionLabel.text = "\(items.count)  ürün"
        
        self.productItems = items
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            
        }
    }
    
}
