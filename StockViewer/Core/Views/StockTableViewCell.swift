//
//  StockTableViewCell.swift
//  StockViewer
//
//  Created by Vasil Panov on 17.2.22.
//

import UIKit
import SnapKit

protocol StockTableViewCellDelegate:NSObjectProtocol{
    func addFavoriteStockAction(stock:StockModel, index:IndexPath)
    func deleteFavoriteStockAction(stock:StockFavoriteModel, index:IndexPath)
}

class StockTableViewCell: UITableViewCell {
    weak var delegate: StockTableViewCellDelegate?
    var model:StockModel!
    var favStockModel:StockFavoriteModel!
    var isFavorite = false
    var index:IndexPath!
    static var identifier = "StockTableViewCell"
    
    lazy var addImage: UIButton = {
        var i = UIButton()
        if isFavorite {
            i.setImage(UIImage(systemName:"minus"), for: .normal)
            DispatchQueue.main.async {
                i.addTarget(self, action: #selector(self.deleteFavoriteAction), for: .touchUpInside)
            }
        }else{
            if model.isFavorite{
                i.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
            }else{
                i.setImage(UIImage(systemName: "plus"), for: .normal)
            }
            DispatchQueue.main.async {
                i.addTarget(self, action: #selector(self.addToFavoritesAction), for: .touchUpInside)
            }
        }
        return i
    }()
    
    lazy var stockName: UILabel = {
        var l = UILabel()
        l.textColor = UIColor.black
        if isFavorite {
            l.text = self.favStockModel.companyName
        } else {
            l.text = self.model.companyName
        }
        l.font = UIFont.systemFont(ofSize: 17,weight: .light)
        l.textAlignment = .left
        l.numberOfLines = 0
        l.minimumScaleFactor = 0.1
        l.adjustsFontSizeToFitWidth = true
        return l
    }()
    
    init(style: UITableViewCell.CellStyle, reuseIdentifier: String?, model:StockModel, isFavorite:Bool,indexPath: IndexPath) {
        super.init(style: .default, reuseIdentifier: StockTableViewCell.identifier)
        self.selectionStyle = .none
        self.model = model
        self.isFavorite = isFavorite
        self.index = indexPath
        self.configure()
    }
    
    init(style: UITableViewCell.CellStyle, reuseIdentifier: String?, model:StockFavoriteModel, isFavorite:Bool, indexPath: IndexPath) {
        super.init(style: .default, reuseIdentifier: StockTableViewCell.identifier)
        self.selectionStyle = .none
        self.favStockModel = model
        self.isFavorite = isFavorite
        self.index = indexPath
        self.configure()
    }
    
    func configure() {
        self.addSubview(stockName)
        self.contentView.addSubview(addImage)
        setupAddImage()
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
    
    @objc func deleteFavoriteAction(){
        self.delegate?.deleteFavoriteStockAction(stock: favStockModel,index:self.index)
    }
    
    @objc func addToFavoritesAction(){
        self.delegate?.addFavoriteStockAction(stock: model,index:self.index)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

