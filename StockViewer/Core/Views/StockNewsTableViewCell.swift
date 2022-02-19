//
//  StockNewsTableViewCell.swift
//  StockViewer
//
//  Created by Vasil Panov on 19.2.22.
//

import UIKit
import SDWebImage

class StockNewsTableViewCell: UITableViewCell {

    var model:StockNewsModel!
    static var identifier = "StockNewsTableViewCell"

    lazy var stockImage: UIImageView = {
        var i = UIImageView()
        i.sd_setImage(with: URL(string: model.image!), completed: nil)
        return i
    }()
    
    lazy var newsLabel: UILabel = {
       var l = UILabel()
        l.sizeToFit()
        l.text = model.text
        l.numberOfLines = 0
        return l
    }()
    
    init(style: UITableViewCell.CellStyle, reuseIdentifier: String?, model:StockNewsModel) {
        super.init(style: .default, reuseIdentifier: StockTableViewCell.identifier)
        self.selectionStyle = .none
        self.model = model
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        self.addSubview(stockImage)
        self.addSubview(newsLabel)
        
        setupStockImage()
        setupLabel()
    }
    func setupLabel(){
        newsLabel.snp.makeConstraints { (c) in
            c.top.equalTo(stockImage.snp.bottom)
            c.right.left.equalToSuperview()
            c.bottom.equalToSuperview()
        }
    }
    
    func setupStockImage(){
        stockImage.snp.makeConstraints {(c) in
            c.top.equalTo(self.safeArea.top)
            c.right.left.equalToSuperview()
            c.height.equalTo(200)
        }
    }
}
