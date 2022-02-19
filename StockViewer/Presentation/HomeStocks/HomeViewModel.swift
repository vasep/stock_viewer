//
//  HomeViewModel.swift
//  StockViewer
//
//  Created by Vasil Panov on 16.2.22.
//

import Combine
import Foundation
import UIKit
import Alamofire

protocol HomeViewModelDelegate:NSObjectProtocol {
    func getStocks(result: [StockModel])
}

class HomeViewModel: NSObject {
    
    private var homeController : HomeViewController
    private var selector:Selector
    weak var delegate:HomeViewModelDelegate!
    private var stockData = [StockModel]()

    init(c:HomeViewController,s:Selector) {
        self.homeController = c
        self.selector = s
        self.delegate = c
    }
    
    func fetchStocks(){
        Constatnt.ManagerApi.fetchStockList(successBlock: { (stocks) in
            self.delegate.getStocks(result: stocks)
            self.stockData = stocks
            self.createFilterModel()
        }, errorBlock: { (error) in
            
        })
    }
    
    func createFilterModel(){
        var countryArray = [String]()
        for stock in stockData {
            if !countryArray.contains(stock.country ?? "") {
                countryArray.append(stock.country!)
            }
        }
    }
    
    func refreshDataWithSearch(string:String){
        var filteredSearchStocks = [StockModel]()
        for data in stockData {
            if (data.companyName!.contains(string)) {
                filteredSearchStocks.append(data)
            }
        }
        
        self.delegate.getStocks(result: filteredSearchStocks)
    }
    
    func goToDetailsController(selectedStock: StockModel) {
        let vc = StockDetailsViewController()
        vc.selectedStockTickerName = selectedStock.symbol
        vc.modalPresentationStyle = .fullScreen
        self.homeController.navigationController?.present(vc, animated: true, completion: nil)
    }
}
