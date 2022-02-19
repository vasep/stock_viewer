//
//  Constants.swift
//  StockViewer
//
//  Created by Vasil Panov on 18.2.22.
//

import Foundation
import Moya

struct Constatnt {
    struct ManagerApi{
        let plugin: PluginType = NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))
        static let fetchStockData = MoyaProvider<Router>(plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))])
        
        typealias errorHandler = (_ error: Int) -> Void
    }
    
    struct Network {
        static let baseUrl = "https://financialmodelingprep.com/api/v3"
        static let apiKey = "d64d179adb2bcbf73edd76abd7e9e477"
        
        static let header = [
            "Content-Type" : "application/json"
        ]
    }
}


