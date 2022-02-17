//
//  Extension+SnapKit.swift
//  StockViewer
//
//  Created by Vasil Panov on 17.2.22.
//

import Foundation
import SnapKit
extension UIView {
    var safeArea: ConstraintBasicAttributesDSL {
        #if swift(>=3.2)
            if #available(iOS 11.0, *) {
                return self.safeAreaLayoutGuide.snp
            }
            return self.snp
        #else
            return self.snp
        #endif
    }
}
extension ConstraintMaker {
    public func aspectRatio(_ x: Double, by y: Double, self instance: ConstraintView) {
        self.width.equalTo(instance.snp.height).multipliedBy(x / y)
    }
}
