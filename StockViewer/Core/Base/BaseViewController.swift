//
//  BaseViewController.swift
//  StockViewer
//
//  Created by Vasil Panov on 16.2.22.
//

import UIKit

class BaseViewController<VM: ViewModel>: UIViewController {
    var viewModel: VM
    
    init(viewModel: VM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    @objc func configureView(){
        print("config")
    }
}
