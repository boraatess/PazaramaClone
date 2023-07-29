//
//  ProductInformationView.swift
//  PazaramaCloneApp
//
//  Created by bora ateş on 27.07.2023.
//

import UIKit
import SnapKit

class ProductInformationView: UIView {
    
    private let productName: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        label.numberOfLines = .zero
        return label
    }()
    
    private let productDescription: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .center
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var tableView: ContentSizedTableView = {
        let tableview = ContentSizedTableView()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(DescriptionCell.self, forCellReuseIdentifier: "descriptionCell")
        tableview.register(FeaturesCell.self, forCellReuseIdentifier: "featuresCell")
        tableview.isScrollEnabled = false
        tableview.allowsSelection = false
        
        return tableview
    }()
    
    var productFeatures: Features?
    var longDescription: String = ""
    
    var featuresViewModel: [FeaturesViewModel] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func getHeight() -> CGFloat {
        return self.tableView.contentSize.height
    }
    
    func layout() {
        
        addSubview(productName)
        productName.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(30)
        }
        addSubview(productDescription)
        productDescription.snp.makeConstraints { make in
            make.top.equalTo(self.productName.snp.bottom).offset(10)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.productDescription.snp.bottom).offset(10)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            
        }
        
    }
    
    func configureUI(with response: ProductResponse) {
        productName.text = response.name
        self.longDescription = response.longDescription
        productDescription.text = response.description
        self.productFeatures = response.features
        
        featuresViewModel = [FeaturesViewModel(name: "Kalıp", value: response.features.size),
                             FeaturesViewModel(name: "Kol Tipi", value: response.features.armType),
                             FeaturesViewModel(name: "Desen", value: response.features.patternName)
        ]
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            
        }
    }
    
}

extension ProductInformationView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            
        case 0:
            return 1
        case 1:
            return featuresViewModel.count
        default: return 0
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.section {
        case 0:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "descriptionCell", for: indexPath) as! DescriptionCell
           
            cell.configure(with: self.longDescription)
            
            return cell
        case 1:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "featuresCell", for: indexPath) as! FeaturesCell
            
            let viewModel = featuresViewModel[indexPath.row]
            
            cell.configure(with: viewModel)
            
            return cell
            
        default:
            return .init()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
            
        case 0:
            return 200
            
        case 1:
            return 50
            
        default:
            return 0
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 40))
        
        let label = UILabel(frame: CGRect(x: 20, y: 10, width: frame.size.width, height: 20))
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        
        view.addSubview(label)

        if section == 1 {
            label.text = "Ürün Özellikleri"
        }
        else {
            label.text = ""
        }
        
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 50
        }
        else {
            return 0
        }
    }
    
}
