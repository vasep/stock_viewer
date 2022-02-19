//
//  File.swift
//  StockViewer
//
//  Created by Vasil Panov on 18.2.22.
//

import Foundation
import Moya

extension Constatnt.ManagerApi {

    typealias getStockModel = (_ result: [StockModel]) -> Void
    typealias getStockNews = (_ result: [StockNewsModel]) -> Void

    static func fetchStockList(successBlock: (getStockModel)? = nil,errorBlock: (Constatnt.ManagerApi.errorHandler)? = nil){
        Constatnt.ManagerApi.fetchStockData.request(.getStockList(marCap: 1000000000, moreThan: 10000, sector: "Technology", exchange: "NASDAQ", limit: 100, apiKey: Constatnt.Network.apiKey)) { (result) in
            switch result {
            case let .success(response):
                switch response.statusCode {
                case 200:
                    let response = try! JSONDecoder().decode([StockModel].self, from: response.data)
                    successBlock!(response)
                default:
                    errorBlock!(response.statusCode)
                }
            case let .failure(error):
                errorBlock!(error.errorCode)
            }
        }
    }
    
    static func fetchStockNews(ticker : String, successBlock: (getStockNews)? = nil,errorBlock: (Constatnt.ManagerApi.errorHandler)? = nil){
        Constatnt.ManagerApi.fetchStockData.request(.getStockNews(tockers: ticker, limit: 100, apiKey: Constatnt.Network.apiKey)) { (result) in
            switch result {
            case let .success(response):
                switch response.statusCode {
                case 200:
                    let response = try! JSONDecoder().decode([StockNewsModel].self, from: response.data)
                    successBlock!(response)
                default:
                    errorBlock!(response.statusCode)
                }
            case let .failure(error):
                errorBlock!(error.errorCode)
            }
        }
    }
}
