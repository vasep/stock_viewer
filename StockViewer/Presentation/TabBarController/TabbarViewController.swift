//
//  TabbarViewController.swift
//  StockViewer
//
//  Created by Vasil Panov on 16.2.22.
//

import UIKit

class TabbarViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        UITabBar.appearance().unselectedItemTintColor = #colorLiteral(red: 0.3058823529, green: 0.1725490196, blue: 0.1098039216, alpha: 1)
        self.delegate = self
 
        self.view.backgroundColor = UIColor.white
        self.view.tintColor = UIColor(hex: "4E2C1C")
        self.tabBar.barTintColor = UIColor(hex:"F6BC00")
        self.tabBar.tintColor = UIColor(hex: "4E2C1C")
        self.tabBar.itemPositioning = .automatic
        
        let homeViewController = HomeViewController()
        let homeNavigation = UINavigationController(rootViewController: homeViewController)
        homeNavigation.tabBarItem.image = UIImage(systemName: "list.dash")
//      homeNavigation.tabBarItem.selectedImage = R.image.activeNavigationButtonHome()
        homeNavigation.tabBarItem.setImageOnly()
        
        homeViewController.navigationController?.isNavigationBarHidden = true
        homeViewController.navigationController?.setNavigationBarHidden(true, animated: false)
        
        let myStocksViewController = HomeViewController()
        let myStocksNavigation = UINavigationController(rootViewController: myStocksViewController)
        myStocksNavigation.tabBarItem.image = UIImage(systemName: "heart")
        myStocksViewController.isFavStocks = true
//      homeNavigation.tabBarItem.selectedImage = R.image.activeNavigationButtonHome()
        myStocksNavigation.tabBarItem.setImageOnly()
        
        myStocksViewController.navigationController?.isNavigationBarHidden = true
        myStocksViewController.navigationController?.setNavigationBarHidden(true, animated: false)
        
        self.viewControllers = [homeNavigation,myStocksNavigation]
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let v = viewController as? UINavigationController {
            v.popViewController(animated: true)
        }
    }
}

extension UITabBarItem {
   func setImageOnly(){
       imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
       setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.clear], for: .selected)
       setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.clear], for: .normal)
   }
}
