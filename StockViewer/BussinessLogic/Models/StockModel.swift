//
//  Stock.swift
//  StockViewer
//
//  Created by Vasil Panov on 17.2.22.
//

import Foundation
struct StockModel : Codable {
    let symbol : String?
    let companyName : String?
    let marketCap : Int?
    let sector : String?
    let industry : String?
    let beta : Double?
    let price : Double?
    let lastAnnualDividend : Double?
    let volume : Int?
    let exchange : String?
    let exchangeShortName : String?
    let country : String?
    let isEtf : Bool?
    let isActivelyTrading : Bool?

    enum CodingKeys: String, CodingKey {

        case symbol = "symbol"
        case companyName = "companyName"
        case marketCap = "marketCap"
        case sector = "sector"
        case industry = "industry"
        case beta = "beta"
        case price = "price"
        case lastAnnualDividend = "lastAnnualDividend"
        case volume = "volume"
        case exchange = "exchange"
        case exchangeShortName = "exchangeShortName"
        case country = "country"
        case isEtf = "isEtf"
        case isActivelyTrading = "isActivelyTrading"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        symbol = try values.decodeIfPresent(String.self, forKey: .symbol)
        companyName = try values.decodeIfPresent(String.self, forKey: .companyName)
        marketCap = try values.decodeIfPresent(Int.self, forKey: .marketCap)
        sector = try values.decodeIfPresent(String.self, forKey: .sector)
        industry = try values.decodeIfPresent(String.self, forKey: .industry)
        beta = try values.decodeIfPresent(Double.self, forKey: .beta)
        price = try values.decodeIfPresent(Double.self, forKey: .price)
        lastAnnualDividend = try values.decodeIfPresent(Double.self, forKey: .lastAnnualDividend)
        volume = try values.decodeIfPresent(Int.self, forKey: .volume)
        exchange = try values.decodeIfPresent(String.self, forKey: .exchange)
        exchangeShortName = try values.decodeIfPresent(String.self, forKey: .exchangeShortName)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        isEtf = try values.decodeIfPresent(Bool.self, forKey: .isEtf)
        isActivelyTrading = try values.decodeIfPresent(Bool.self, forKey: .isActivelyTrading)
    }

}
