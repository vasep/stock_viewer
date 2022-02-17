//
//  Extension+UIViewController.swift
//  StockViewer
//
//  Created by Vasil Panov on 17.2.22.
//

import Foundation
import UIKit
//MARK:- Dissmiss Keyboard on tap

public extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
