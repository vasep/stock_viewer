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
import CoreData

protocol HomeViewModelDelegate:NSObjectProtocol {
    func getStocks(result: [StockModel])
    func getFilte(result: [String])
    func getFavoriteStocks(favorite:[StockFavoriteModel])
    func updateFavModel(favorite:[StockFavoriteModel])
}

class HomeViewModel: NSObject {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var homeController : HomeViewController
    private var selector:Selector
    weak var delegate:HomeViewModelDelegate!
    private var stockData = [StockModel]()
    var favoriteStocksArr = [StockFavoriteModel]()
    
    init(c:HomeViewController,s:Selector) {
        self.homeController = c
        self.selector = s
        self.delegate = c
    }
    
    func fetchStocks(){
        DispatchQueue.main.async {
            self.homeController.showActivityIndicator(viewController: self.homeController)
        Constatnt.ManagerApi.fetchStockList(successBlock: { (stocks) in
            self.delegate.getStocks(result: stocks)
            self.stockData = stocks
            self.createFilterModel()
            self.homeController.hideActivityIndicator(viewController: self.homeController)
        }, errorBlock: { (error) in
            self.homeController.hideActivityIndicator(viewController: self.homeController)
        })
        }
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
    
    func updateFavData(){
        fetchItemsFromDB()
        self.delegate?.updateFavModel(favorite: self.favoriteStocksArr)
    }
    
    
    func fetchItemsFromDB() {
        do {
            self.favoriteStocksArr = try context.fetch(StockFavoriteModel.fetchRequest())
            self.delegate.getFavoriteStocks(favorite: self.favoriteStocksArr)
        } catch {
            //error
        }
    }
    
    func addItem(stock:StockModel){
        let item = StockFavoriteModel(context: context)
//        self.delegate?.updateFavModel(favorite: item)
        item.companyName = stock.companyName
        item.symbom = stock.symbol
        do{
            try context.save()
        } catch {
            //error
        }
    }
    
    func deleteItem(item:StockFavoriteModel) {
        context.delete(item)
        do{
            try context.save()
        } catch {
            
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
    
    func goToDetailsController(selectedStock: String) {
        let vc = StockDetailsViewController()
        vc.selectedStockTickerName = selectedStock
        vc.modalPresentationStyle = .fullScreen
        self.homeController.navigationController?.present(vc, animated: true, completion: nil)
    }
}
