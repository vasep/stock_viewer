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
    func getFilte(result: [String])
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
    
    func sortByMakertCap(){
        var sortedArray = [StockModel]()
        sortedArray = stockData.sorted{ $0.marketCap! > $1.marketCap! }
        delegate.getStocks(result: sortedArray)
    }
    
    func sortAlphabetically() {
        var sortedArray = [StockModel]()
        sortedArray = stockData.sorted{ $0.companyName! < $1.companyName! }
        delegate.getStocks(result: sortedArray)
    }
    
    func filterByCountry(country: String){
        var filteredStockArray = [StockModel]()
        for stock in stockData {
            if stock.country!.contains(country) {
                filteredStockArray.append(stock)
            }
        }
        if country == "All" {
            fetchStocks()
        } else {
            stockData = filteredStockArray
            delegate.getStocks(result: filteredStockArray)
        }
    }
    
    func createFilterModel(){
        var countryArray = ["All"]
        for stock in stockData {
            if !countryArray.contains(stock.country ?? "") {
                countryArray.append(stock.country!)
            }
        }
        self.delegate.getFilte(result: countryArray)
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
