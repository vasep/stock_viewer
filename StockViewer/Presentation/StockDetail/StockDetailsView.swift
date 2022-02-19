//
//  StockDetailsView.swift
//  StockViewer
//
//  Created by Vasil Panov on 16.2.22.
//

import Combine
import UIKit

protocol StockDetailDelegate: NSObjectProtocol {
    func dismissView()
}

final class StockDetailsView:UIView {
    weak var delegate:StockDetailDelegate!
    var responseStockNews = [StockNewsModel]()
    var selectedTickerName : String?
    
    lazy var navigationBar: UINavigationBar = {
        let navBar = UINavigationBar()
        let navItem = UINavigationItem(title: selectedTickerName!)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action:#selector(doneItemAction))
        navItem.leftBarButtonItem = doneItem
        navBar.setItems([navItem], animated: false)
        
        return navBar
    }()
    
    lazy var tableView:UITableView = {
        var t = UITableView()
        t.register(StockNewsTableViewCell.self, forCellReuseIdentifier: StockNewsTableViewCell.identifier)
        t.delegate = self
        t.dataSource = self
        t.backgroundColor = UIColor.lightColor
        return t
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(tickerName : String){
        self.selectedTickerName = tickerName
        super.init(frame: CGRect.zero)
    }
    
    func setup(){
        self.addSubview(tableView)
        self.addSubview(navigationBar)
        setupTableView()
        setupNavBar()
    }
    
    @objc func doneItemAction(){
        self.delegate.dismissView()
    }
    
    func setModel(responseNews: [StockNewsModel]){
        self.responseStockNews = responseNews
        self.tableView.reloadData()
    }
    
    func setupNavBar(){
        navigationBar.snp.makeConstraints { (c) in
            c.top.equalTo(self.safeArea.top)
            c.height.equalTo(50)
            c.left.equalToSuperview()
            c.right.equalToSuperview()
            c.bottom.equalTo(tableView.snp.top)
        }
    }
    
    func setupTableView(){
        tableView.snp.makeConstraints { (c) in
            c.top.equalTo(navigationBar.snp.bottom)
            c.left.right.equalToSuperview()
            c.bottom.equalTo(self.safeArea.bottom)
        }
    }
}

//MARK: TableView Extensions
extension StockDetailsView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        responseStockNews.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let model = responseStockNews[indexPath.row]
            let cell = StockNewsTableViewCell(style: .default, reuseIdentifier: StockNewsTableViewCell.identifier, model: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return responseStockNews[section].title
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
