//
//  Networking.swift
//  StockViewer
//
//  Created by Vasil Panov on 18.2.22.
//


import Foundation

import Moya

enum Router {
    
//    "marketCapMoreThan" : 1000000000,
//    "volumeMoreThan" : 10000,"sector" : "Technology","exchange" : "NASDAQ","limit" : 100,"apikey" : "d64d179adb2bcbf73edd76abd7e9e477"
//    tickers=MSFT&limit=1000&apikey=d64d179adb2bcbf73edd76abd7e9e477
    case getStockList(marCap : Int? = nil, moreThan: Int? = nil, sector : String, exchange : String, limit  : Int? = nil, apiKey:String )
    case getStockNews(tockers: String, limit : Int? = nil, apiKey : String)
}

extension Router:TargetType {
    var baseURL: URL {
        return URL(string: Constatnt.Network.baseUrl)!
    }
    
    var method: Moya.Method {
        switch self {
        case .getStockList,.getStockNews:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getStockNews:
            return "/stock_news"
        case .getStockList:
            return "/stock-screener/"
        }
    }
    
    var task: Task {
        switch self {
        case .getStockList:
            return .requestParameters(parameters: parameters!, encoding: URLEncoding.queryString)
        case .getStockNews:
            return .requestParameters(parameters: parameters!, encoding: URLEncoding.queryString)
        }
    }
    
    var parameters: [String : Any]? {
        var params:[String: Any] = [:]

        switch self {
        case .getStockList(let par1, let par2, let par3, let par4, let par5, let par6):
            params["marketCapMoreThan"] = par1
            params["volumeMoreThan"] = par2
            params["sector"] = par3
            params["exchange"] = par4
            params["limit"] = par5
            params["apikey"] = par6
            return params
        case .getStockNews(let par1, let par2, let par3):
            params["tickers"] = par1
            params["limit"] = par2
            params["apikey"] = par3
            return params
        }
    }
    
    var header : [String : String] {
        switch self {
        case .getStockList, .getStockNews:
            return Constatnt.Network.header
        }
    }
    
    var headers: [String : String]? {
        var header:[String:String] = [:]
           return header
       }
}
  
