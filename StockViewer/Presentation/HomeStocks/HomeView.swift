//
//  HomeView.swift
//  StockViewer
//
//  Created by Vasil Panov on 16.2.22.
//

import Foundation
import UIKit
import SnapKit

protocol HomeViewDelegate: NSObjectProtocol {
    func didSelectStock(stock:StockModel)
    func didChangeSearchString(string:String)
    func refreshData()
}

final class HomeView: UIView,UISearchBarDelegate {
    weak var delegate:HomeViewDelegate!
    var isFavoriteStocks = false
    var responseStocks = [StockModel]()
    let searchTextField = UISearchBar()

    
    lazy var tableView:UITableView = {
        let t = UITableView()
        t.register(StockTableViewCell.self, forCellReuseIdentifier: StockTableViewCell.identifier)
        t.delegate = self
        t.dataSource = self
        t.backgroundColor = UIColor.lightColor
        return t
    }()
    
    lazy var filterBtn: UIButton = {
        var b = UIButton()
        let image =  UIImage(systemName: "camera.filters")
        b.setImage(image, for: .normal)
        b.addTarget(self, action: #selector(handleFilterBtnClick), for: .touchUpInside)
        return b
    }()
    
    init(){
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleFilterBtnClick() {
        
    }
    
    func setModel(responseStock: [StockModel]){
        self.responseStocks = responseStock
        self.tableView.reloadData()
    }
    
    func setCountryFilterModel(){
        
    }
    
    func setup(isFavorite:Bool){
        self.isFavoriteStocks = isFavorite
        self.backgroundColor = UIColor.white        

        if !isFavorite {
            self.addSubview(searchTextField)
            self.addSubview(filterBtn)
            setupSearchAndFilterElements()
        }
        self.addSubview(tableView)
        setupTableView()
    }
    
    func setupTableView(){
        tableView.snp.makeConstraints { (c) in
            if isFavoriteStocks {
                c.top.equalTo(self.safeArea.top)
            }else{
                c.top.equalTo(searchTextField.snp.bottom).offset(10)
            }
            c.left.right.equalToSuperview()
            c.bottom.equalTo(self.safeArea.bottom)
        }
    }
    
    func setupSearchAndFilterElements(){
        
        searchTextField.backgroundImage = UIImage()
        searchTextField.layer.borderColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        searchTextField.layer.borderWidth = 1.5
        searchTextField.layer.cornerRadius = 10
        searchTextField.delegate = self
        searchTextField.placeholder = "Search"
        searchTextField.returnKeyType = .search
        searchTextField.enablesReturnKeyAutomatically = false
        
        let textFieldInsideSearchBar = searchTextField.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = UIColor.darkColor
        textFieldInsideSearchBar?.font = UIFont(name: "HelveticaNeue-UltraLight", size: 16)
        textFieldInsideSearchBar?.clearButtonMode = .whileEditing
        textFieldInsideSearchBar?.backgroundColor = .white
        
        filterBtn.snp.makeConstraints { (c) in
            c.top.equalTo(self.safeArea.top)
            c.right.equalToSuperview().inset(20)
            c.height.equalTo(30)
            c.width.equalTo(30)
        }
        
        searchTextField.snp.makeConstraints {(c) in
            c.top.equalTo(self.safeArea.top)
            c.left.equalToSuperview().inset(20)
            c.right.equalTo(filterBtn.snp.left)
            c.height.equalTo(30)
        }
    }
}

//MARK: TableView Extensions
extension HomeView:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return responseStocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = responseStocks[indexPath.row]
        let cell = StockTableViewCell(style: .default, reuseIdentifier: StockTableViewCell.identifier, model:model,isFavorite: isFavoriteStocks )
        cell.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate.didSelectStock(stock: responseStocks[indexPath.row])
    }
    
}

//MARK: UISearch Extensions
extension HomeView {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let text = searchBar.text{
            if text.count > 2 {
                if let delegate = delegate {
                    delegate.didChangeSearchString(string:text)
                }
            }
            if text.count == 0 {
                searchBar.perform(#selector(self.resignFirstResponder), with: nil, afterDelay: 0.1)
                if let delegate = delegate {
                    delegate.refreshData()
                }
            }
        }
    }
}

extension HomeView:StockTableViewCellDelegate {
    func addFavoriteStockAction(restaurant: StockModel) {
        print()
    }
    
    func deleteFavoriteRestaurantAction(restaurant: StockModel) {
        print()
    }
    
    
}

