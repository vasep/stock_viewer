//
//  StockFavoriteModel+CoreDataProperties.swift
//  StockViewer
//
//  Created by Vasil Panov on 21.2.22.
//
//

import Foundation
import CoreData


extension StockFavoriteModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StockFavoriteModel> {
        return NSFetchRequest<StockFavoriteModel>(entityName: "StockFavoriteModel")
    }

    @NSManaged public var symbom: String?
    @NSManaged public var companyName: String?

}

extension StockFavoriteModel : Identifiable {

}
