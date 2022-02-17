//
//  Extension+CGFloat.swift
//  StockViewer
//
//  Created by Vasil Panov on 17.2.22.
//

import Foundation
import UIKit

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
