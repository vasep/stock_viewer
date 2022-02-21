//
//  FavoriteModel+CoreDataProperties.swift
//  StockViewer
//
//  Created by Vasil Panov on 21.2.22.
//
//

import Foundation
import CoreData


extension FavoriteModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteModel> {
        return NSFetchRequest<FavoriteModel>(entityName: "FavoriteModel")
    }

    @NSManaged public var isActivelyTrading: Bool
    @NSManaged public var symbol: String?
    @NSManaged public var companyName: String?
    @NSManaged public var marketCap: Int64
    @NSManaged public var sector: String?
    @NSManaged public var industry: String?
    @NSManaged public var beta: Double
    @NSManaged public var price: Double
    @NSManaged public var lastAnnualDividend: Double
    @NSManaged public var exchange: String?
    @NSManaged public var volume: Int64
    @NSManaged public var exchangeShortName: String?
    @NSManaged public var country: String?
    @NSManaged public var isEtf: Bool

}

extension FavoriteModel : Identifiable {

}
