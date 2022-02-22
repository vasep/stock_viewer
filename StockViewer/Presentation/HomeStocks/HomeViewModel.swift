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
    func getFilter(result: [String])
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
                self.fetchItemsFromDB()
                self.stockData = stocks
                self.createFilterModel()
                for favStock in self.favoriteStocksArr {
                    for stock in 0..<self.stockData.count {
                        if favStock.symbom == self.stockData[stock].symbol{
                            self.stockData[stock].isFavorite = true
                        }
                    }
                }
                self.delegate.getStocks(result: self.stockData)

                self.homeController.hideActivityIndicator(viewController: self.homeController)
            }, errorBlock: { (error) in
                self.homeController.hideActivityIndicator(viewController: self.homeController)
            })
        }
    }
    
    func updateStockModel(index:IndexPath) {
        if self.stockData[index.row].isFavorite != true {
            let myalert = UIAlertController(title: "Add to Favorite", message: "Are you sure you that you want to add this stock to your favorites?", preferredStyle: UIAlertController.Style.alert)
            
            myalert.addAction(UIAlertAction(title: "Accept", style: .default) { (action:UIAlertAction!) in
                self.stockData[index.row].isFavorite = true
                self.delegate?.getStocks(result: self.stockData)
                self.addItem(stock: self.stockData[index.row])
            })
            myalert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
                print("Cancel")
            })
            
            homeController.present(myalert, animated: true)
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
        self.delegate?.getFilter(result: countryArray)
    }
    
    func updateFavData(){
        fetchItemsFromDB()
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
        item.companyName = stock.companyName
        item.symbom = stock.symbol
        do{
            try context.save()
        } catch {
            //error
        }
    }
    
    func deleteItem(item:IndexPath) {
        let myalert = UIAlertController(title: "Remove Favorite", message: "Are you sure you that you want to remove this stock from your favorite list?", preferredStyle: UIAlertController.Style.alert)
        
        myalert.addAction(UIAlertAction(title: "Accept", style: .default) { (action:UIAlertAction!) in

            self.context.delete(self.favoriteStocksArr[item.row])
            self.favoriteStocksArr.remove(at: item.row)
            self.delegate?.getFavoriteStocks(favorite: self.favoriteStocksArr)
            do{
                try self.context.save()
            } catch {
                
            }
        })
        myalert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
            print("Cancel")
        })
        
        homeController.present(myalert, animated: true)
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
    
    func presentUIalert(){
        
    }
}
