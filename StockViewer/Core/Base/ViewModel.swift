//
//  ViewModel.swift
//  StockViewer
//
//  Created by Vasil Panov on 16.2.22.
//

protocol ViewModel {

    func onViewDidLoad()
    func onViewWillAppear()
    func onViewDidAppear()
    func onViewWillDisappear()
    func onViewDidDisappear()
}

class BaseViewModel: ViewModel {
    
    deinit {
        debugPrint("deinit of ", String(describing: self))
    }

    func onViewDidLoad() {}
    func onViewWillAppear() {}
    func onViewDidAppear() {}
    func onViewWillDisappear() {}
    func onViewDidDisappear() {}
}
