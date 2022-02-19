//
//  StockDetailsViewController.swift
//  StockViewer
//
//  Created by Vasil Panov on 16.2.22.
//

import Foundation
import UIKit

final class StockDetailsViewController: UIViewController {
    
    var selectedStockTickerName : String!
    
    lazy var modelView: StocksDetailsViewModel = {
        var m = StocksDetailsViewModel(c: self, s: #selector(self.getStocksFromServier))
        return m
    }()
    
    lazy var stockView:StockDetailsView = {
        var v = StockDetailsView(tickerName: selectedStockTickerName)
        v.delegate = self
        return v
    }()

    override func loadView() {
        view = stockView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        stockView.setup()
        getStocksFromServier()
    }
    
    @objc func getStocksFromServier(){
        modelView.fetchNewsForStock(ticker: selectedStockTickerName)
    }
}

extension StockDetailsViewController: StockDetailDelegate {
    func dismissView() {
        self.dismiss(animated: true)
    }
}

extension StockDetailsViewController: StocksDetailsViewModelDelegate {
    func getStockNews(result: [StockNewsModel]) {
        stockView.setModel(responseNews: result)
    }
    
}
