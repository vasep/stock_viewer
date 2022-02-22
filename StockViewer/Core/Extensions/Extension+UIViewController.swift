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
    
    public func showActivityIndicator (viewController : UIViewController){
        let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.center = viewController.view.center
        activityIndicator.color = UIColor.yellowColor
        activityIndicator.startAnimating()
        viewController.view.addSubview(activityIndicator)
        activityIndicator.isHidden = false
        viewController.view.isUserInteractionEnabled = false
        
    }

    public func hideActivityIndicator (viewController : UIViewController ){
        for subview in viewController.view.subviews as [UIView] {
            if let activityIndicator = subview as? UIActivityIndicatorView {
                activityIndicator.stopAnimating()
                activityIndicator.isHidden = true
                activityIndicator.removeFromSuperview()
                viewController.view.isUserInteractionEnabled = true
            }
        }
    }
}
