//
//  CollectionViewCell.swift
//  RakutenRanking
//
//  Created by mao takagai on 2018/03/23.
//  Copyright © 2018年 mao takagai. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    // 商品名のlabelを生成
    var itemName: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 65, width: screenSize.width / 3.0, height: screenSize.width / 3.0)
        label.textColor = UIColor.gray
        label.textAlignment = .left
        return label
    }()
    
    // 値段のlabelを生成
    var itemPrice: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 85, width: screenSize.width / 3.0, height: screenSize.width / 3.0)
        label.textColor = UIColor.gray
        label.textAlignment = .right
        return label
    }()
    
    // 順位のlabelを生成
    var itemRank: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 85, width: screenSize.width / 3.0, height: screenSize.width / 3.0)
        label.textColor = UIColor.gray
        label.textAlignment = .left
        return label
    }()
    
    // 商品画像を生成
    var itemImage: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 12, y: 10, width: 100, height: 100))
        return image
    }()
    
    private func setup() {
        layer.borderColor = UIColor.darkGray.cgColor
        layer.borderWidth = 1.0
        
        contentView.addSubview(itemName)
        contentView.addSubview(itemPrice)
        contentView.addSubview(itemRank)
        contentView.addSubview(itemImage)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
