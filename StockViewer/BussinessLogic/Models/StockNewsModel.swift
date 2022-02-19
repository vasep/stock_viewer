//
//  StockDetailModel.swift
//  StockViewer
//
//  Created by Vasil Panov on 19.2.22.
//

import Foundation

struct StockNewsModel : Codable {
    let symbol : String?
    let publishedDate : String?
    let title : String?
    let image : String?
    let site : String?
    let text : String?
    let url : String?

    enum CodingKeys: String, CodingKey {

        case symbol = "symbol"
        case publishedDate = "publishedDate"
        case title = "title"
        case image = "image"
        case site = "site"
        case text = "text"
        case url = "url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        symbol = try values.decodeIfPresent(String.self, forKey: .symbol)
        publishedDate = try values.decodeIfPresent(String.self, forKey: .publishedDate)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        site = try values.decodeIfPresent(String.self, forKey: .site)
        text = try values.decodeIfPresent(String.self, forKey: .text)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }

}
