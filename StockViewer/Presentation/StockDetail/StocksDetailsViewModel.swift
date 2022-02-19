//
//  StocksDetailsViewModel.swift
//  StockViewer
//
//  Created by Vasil Panov on 16.2.22.
//

import Foundation

protocol StocksDetailsViewModelDelegate:NSObjectProtocol {
    func getStockNews(result:[StockNewsModel])
}

final class StocksDetailsViewModel: NSObject {
    
    private var stockViewController : StockDetailsViewController
    private var selector:Selector
    weak var delegate:StocksDetailsViewModelDelegate!
    
    private var newsSource = [StockNewsModel]()

    init(c:StockDetailsViewController,s:Selector) {
        self.stockViewController = c
        self.selector = s
        self.delegate = c
    }
    
    func fetchNewsForStock(ticker:String) {
        Constatnt.ManagerApi.fetchStockNews(ticker: ticker, successBlock: { (news) in
            self.delegate.getStockNews(result: news)
        }, errorBlock: { (error) in
            
        })
    }
    
}
