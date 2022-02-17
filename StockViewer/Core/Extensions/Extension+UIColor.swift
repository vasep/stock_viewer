//
//  Extension+UIColor.swift
//  StockViewer
//
//  Created by Vasil Panov on 17.2.22.
//

import Foundation
import UIKit

extension UIColor {
    convenience init (hex:String){
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0, green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0, blue: CGFloat(rgbValue & 0x0000FF) / 255.0, alpha: CGFloat(1.0))
    }
    static func random() -> UIColor {
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 1.0)
    }
    
}
extension UIColor {
    var hexString: String {
        let colorRef = cgColor.components
        let r = colorRef?[0] ?? 0
        let g = colorRef?[1] ?? 0
        let b = ((colorRef?.count ?? 0) > 2 ? colorRef?[2] : g) ?? 0
        let a = cgColor.alpha
        
        var color = String(
            format: "#%02lX%02lX%02lX",
            lroundf(Float(r * 255)),
            lroundf(Float(g * 255)),
            lroundf(Float(b * 255))
        )
        
        if a < 1 {
            color += String(format: "%02lX", lroundf(Float(a)))
        }
        color.remove(at: color.startIndex)
        return color.lowercased()
    }
}
extension UIColor {
    static let darkColor = #colorLiteral(red: 0.231372549, green: 0.2274509804, blue: 0.2274509804, alpha: 1)
    static let lightColor = #colorLiteral(red: 0.9882352941, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
    static let yellowColor = #colorLiteral(red: 0.940011458, green: 0.7618615031, blue: 0.008508217521, alpha: 0.9027718322)
    static let lightGrayColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
}
