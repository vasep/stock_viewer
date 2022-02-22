//
//  HomeViewController.swift
//  StockViewer
//
//  Created by Vasil Panov on 16.2.22.
//

import Foundation
import UIKit

class HomeViewController:UIViewController,UIViewControllerTransitioningDelegate {
    var isFavStocks = false
    
    lazy var modelView: HomeViewModel = {
        var m = HomeViewModel(c: self, s: #selector(self.getStocksFromServier))
        return m
    }()
    
    lazy var homeView:HomeView = {
        var v = HomeView()
        v.delegate = self
        return v
    }()
    
    override func loadView() {
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isFavStocks {
            homeView.setup(isFavorite: true)
        } else {
            homeView.setup(isFavorite: false)
        }
        getStocksFromServier()
        self.hideKeyboardWhenTappedAround()
 }
    
    @objc func getStocksFromServier(){
        if isFavStocks {
            modelView.fetchItemsFromDB()
        } else {
            modelView.fetchItemsFromDB()
            modelView.fetchStocks()
        }
    }
}

extension HomeViewController: HomeViewDelegate {
    func refreshFavoriteData() {
    }
    
    func didDeleteFavoriteStock(favstock: StockFavoriteModel) {
        modelView.deleteItem(item: favstock)
    }
    
    func didAddFavoriteStock(stock: StockModel) {
        modelView.addItem(stock: stock)
    }
    
    func didSelectSortAlphabetically() {
        modelView.sortAlphabetically()
    }
    
    func didSelectSortByMarketCap() {
        modelView.sortByMakertCap()
    }
    
    func didSelectCountryFilter(country: String) {
        modelView.filterByCountry(country: country)
    }
    
    func didSelectStock(stock: String) {
        modelView.goToDetailsController(selectedStock: stock)
    }
    
    func didChangeSearchString(string: String) {
        modelView.refreshDataWithSearch(string: string)
    }
    
    func refreshData() {
        getStocksFromServier()
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func updateFavModel(favorite: [StockFavoriteModel]) {
        modelView.updateFavData()
    }
    
    func getFilte(result: [String]) {
        homeView.setFilterModel(result: result)
    }
    
    func getStocks(result: [StockModel]) {
        homeView.setModel(responseStock: result)
    }
    
    func getFavoriteStocks(favorite:[StockFavoriteModel]){
        homeView.setFavoriteModel(responseFavoriteModel: favorite)
    }
}
