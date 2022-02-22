//
//  HomeView.swift
//  StockViewer
//
//  Created by Vasil Panov on 16.2.22.
//

import Foundation
import UIKit
import SnapKit
import ActionSheetPicker_3_0

protocol HomeViewDelegate: NSObjectProtocol {
    func didSelectStock(stock:String)
    func didChangeSearchString(string:String)
    func didSelectCountryFilter(country:String)
    func didSelectSortAlphabetically()
    func didSelectSortByMarketCap()
    func didAddFavoriteStock(stock:StockModel)
    func didDeleteFavoriteStock(index:IndexPath)
    func refreshFavoriteData()
    func configureModel(index: IndexPath)
    func refreshData()
}

final class HomeView: UIView,UISearchBarDelegate {
    weak var delegate:HomeViewDelegate!
    var isFavoriteStocks = false
    var responseStocks = [StockModel]()
    var respnseFavoriteStockModel = [StockFavoriteModel]()
    var filterModel = [String]()
    let searchTextField = UISearchBar()
    
    lazy var tableView:UITableView = {
        let t = UITableView()
        t.register(StockTableViewCell.self, forCellReuseIdentifier: StockTableViewCell.identifier)
        t.delegate = self
        t.dataSource = self
        t.backgroundColor = UIColor.lightColor
        return t
    }()
    
    lazy var noFavoriteStocksLabel:UILabel = {
        var l = UILabel()
        l.textColor = UIColor.black
        l.font = UIFont.systemFont(ofSize: 22,weight: .light)
        l.textAlignment = .left
        l.numberOfLines = 0
        l.minimumScaleFactor = 0.1
        l.adjustsFontSizeToFitWidth = true
        l.text = "You dont have any Favorite Stocks"
        return l
    }()
    
    lazy var filterBtn: UIButton = {
        var b = UIButton()
        let image =  UIImage(systemName: "camera.filters")
        b.setImage(image, for: .normal)
        DispatchQueue.main.async {
            b.addTarget(self, action: #selector(self.handleFilterBtnClick), for: .touchUpInside)
        }
        return b
    }()
    
    init(){
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleFilterBtnClick() {
        setupMainSheetPicker()
    }
    
    func setFavoriteModel(responseFavoriteModel : [StockFavoriteModel]) {
        self.respnseFavoriteStockModel = responseFavoriteModel
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func setModel(responseStock: [StockModel]){
        self.responseStocks = responseStock
        
//        let myGroup = DispatchGroup()
//        myGroup.notify(queue: .main) {
//            myGroup.enter()
//            for favStock in self.respnseFavoriteStockModel {
//                for stock in 0..<self.responseStocks.count {
//                    if favStock.symbom == self.responseStocks[stock].symbol{
//                        self.responseStocks[stock].isFavorite = true
//                    }
//                }
//            }
//            myGroup.leave()
//        }
//
//        myGroup.notify(queue: .main) {
//            myGroup.enter()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
//            myGroup.leave()
//        }
    }
    
    func setFilterModel(result:[String]){
        self.filterModel = result
    }
    
    func setup(isFavorite:Bool){
        self.isFavoriteStocks = isFavorite
        self.backgroundColor = UIColor.white
        
        if isFavorite {
            if self.respnseFavoriteStockModel.count != 0 {
                self.addSubview(tableView)
                setupTableView()
            } else {
                setupNoFavsLbl()
            }
        } else {
            self.addSubview(searchTextField)
            self.addSubview(filterBtn)
            self.addSubview(tableView)
            setupSearchAndFilterElements()
            setupTableView()
        }
    }
    
    func setupNoFavsLbl(){
        self.addSubview(noFavoriteStocksLabel)
        noFavoriteStocksLabel.snp.makeConstraints { (c) in
            c.centerY.centerX.equalToSuperview()
        }
    }
    
    func sortAlphabetically() {
        self.delegate?.didSelectSortAlphabetically()
    }
    
    func sortByMarketCap() {
        self.delegate?.didSelectSortByMarketCap()
    }
    
    func setupFilterByCountrySheetPicker() {
        ActionSheetStringPicker.show(withTitle: "Filter By Country",
                                     rows: filterModel,
                                     initialSelection: 1,
                                     doneBlock: { picker, value, index in
            
            self.delegate?.didSelectCountryFilter(country: self.filterModel[value])
            
            return
        },
                                     cancel: { picker in
            return
        },
                                     origin: self)
    }
    
    func setupMainSheetPicker() {
        let stringActionPickerArray = ["Sort By Market Cap", "Sort Alphabetically", "Filter By Country", ]
        ActionSheetStringPicker.show(withTitle: "Filters & Sorts",
                                     rows: stringActionPickerArray,
                                     initialSelection: 1,
                                     doneBlock: { picker, value, index in
            
            if stringActionPickerArray[value] == "Sort By Market Cap" {
                DispatchQueue.main.async {
                    self.sortByMarketCap()
                }
            } else if stringActionPickerArray[value] == "Sort Alphabetically" {
                DispatchQueue.main.async {
                    self.sortAlphabetically()
                }
            } else if stringActionPickerArray[value] == "Filter By Country" {
                DispatchQueue.main.async {
                    self.setupFilterByCountrySheetPicker()
                }
            }
            return
        },
                                     cancel: { picker in
            return
        },
                                     origin: self)
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
        searchTextField.layer.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
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
            c.height.equalTo(40)
            c.width.equalTo(40)
        }
        
        searchTextField.snp.makeConstraints {(c) in
            c.top.equalTo(self.safeArea.top)
            c.left.equalToSuperview().inset(20)
            c.right.equalTo(filterBtn.snp.left)
            c.height.equalTo(40)
        }
    }
}

//MARK: TableView Extensions
extension HomeView:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFavoriteStocks {
            return respnseFavoriteStockModel.count
        } else {
            return responseStocks.count
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isFavoriteStocks {
            let model = respnseFavoriteStockModel[indexPath.row]
            let cell = StockTableViewCell(style: .default, reuseIdentifier: StockTableViewCell.identifier, model: model, isFavorite: isFavoriteStocks, indexPath: indexPath)
            cell.delegate = self
            return cell
        } else {
            let model = responseStocks[indexPath.row]
            let cell = StockTableViewCell(style: .default, reuseIdentifier: StockTableViewCell.identifier, model:model,isFavorite: isFavoriteStocks,indexPath: indexPath )
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isFavoriteStocks{
            delegate?.didSelectStock(stock: respnseFavoriteStockModel[indexPath.row].symbom!)
        }else {
            delegate?.didSelectStock(stock: responseStocks[indexPath.row].symbol!)
        }
    }
    
}

//MARK: UISearch Extensions
extension HomeView {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let text = searchBar.text{
            if text.count > 2 {
                DispatchQueue.main.async {
                    if let delegate = self.delegate {
                        delegate.didChangeSearchString(string:text)
                    }
                }
            }
            if text.count == 0 {
                DispatchQueue.main.async {
                    searchBar.perform(#selector(self.resignFirstResponder), with: nil, afterDelay: 0.1)
                    if let delegate = self.delegate {
                        delegate.refreshData()
                    }
                }
            }
        }
    }
}

//MARK: StockTableViewCellDelegate
extension HomeView:StockTableViewCellDelegate {
    func addFavoriteStockAction(stock: StockModel, index: IndexPath) {
        self.delegate?.didAddFavoriteStock(stock: stock)
        self.delegate?.configureModel(index: index)
    }
    
    func deleteFavoriteStockAction(stock: StockFavoriteModel, index: IndexPath) {
        self.delegate.didDeleteFavoriteStock(index: index)
        if self.respnseFavoriteStockModel.count == 1 {
            tableView.removeFromSuperview()
            setupNoFavsLbl()
        } else {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

