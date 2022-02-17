//
//  StockTableViewCell.swift
//  StockViewer
//
//  Created by Vasil Panov on 17.2.22.
//

import UIKit
import SnapKit

protocol StockTableViewCellDelegate:NSObjectProtocol{
    func addFavoriteStockAction(restaurant:Stock)
    func deleteFavoriteRestaurantAction(restaurant:Stock)
}

class StockTableViewCell: UITableViewCell {
    weak var delegate: StockTableViewCellDelegate?
    var model:StockMockUp!
    var isFavorite = false
    static var identifier = "StockTableViewCell"
    
    lazy var addImage: UIButton = {
        var i = UIButton()
        i.setImage(UIImage(systemName: "plus"), for: .normal)
        i.addTarget(self, action: #selector(addToFavoritesAction), for: .touchUpInside)
        return i
    }()
    
    lazy var stockName: UILabel = {
        var l = UILabel()
        l.textColor = UIColor(red:0.32, green:0.18, blue:0.12, alpha:1.0)
        l.text = self.model.name
        l.font = UIFont.systemFont(ofSize: 11,weight: .light)
        l.textAlignment = .left
        l.numberOfLines = 0
        l.minimumScaleFactor = 0.1
        l.adjustsFontSizeToFitWidth = true
        return l
    }()
    
    init(style: UITableViewCell.CellStyle, reuseIdentifier: String?, model:StockMockUp, isFavorite:Bool ) {
        super.init(style: .default, reuseIdentifier: StockTableViewCell.identifier)
        self.selectionStyle = .none
        self.model = model
        self.isFavorite = isFavorite
        self.configure()
    }
    
    func configure() {
        self.addSubview(stockName)
        
        if !isFavorite {
            self.addSubview(addImage)
            setupAddImage()
        }
        setupNameLabel()
    }
    
    func setupAddImage(){
        addImage.snp.makeConstraints {(c) in
            c.right.equalToSuperview().inset(20)
            c.bottom.top.equalToSuperview()

        }
    }
    
    func setupNameLabel() {
        stockName.snp.makeConstraints { (c) in
            c.top.equalToSuperview()
            c.left.equalToSuperview().offset(20)
            c.bottom.equalToSuperview()
            c.height.equalTo(30)
        }
    }
    
    @objc func addToFavoritesAction(){
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

