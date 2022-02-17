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
        self.hideKeyboardWhenTappedAround()
 }
    
}

extension HomeViewController: HomeViewDelegate {
    func didSelectStock(stock: StockMockUp) {
        print()
    }
    
    func didSelectStock(stock: Stock) {
        print()
    }
    
    func didChangeSearchString(string: String) {
        print()
    }
    
    func refreshData() {
        print()
    }
    
    
}
