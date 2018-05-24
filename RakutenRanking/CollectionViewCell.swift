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
    let itemName: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 5, y: 65, width: screenSize.width / 3.0 - 10, height: screenSize.width / 3.0)
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 12, weight: .thin)
        label.numberOfLines = 2
        label.textAlignment = .left
        return label
    }()
    
    // 値段のlabelを生成
    let itemPrice: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 95, width: screenSize.width / 3.0 - 5, height: screenSize.width / 3.0)
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 14, weight: .thin)
        label.textAlignment = .right
        return label
    }()
    
    // 順位のlabelを生成
    let itemRank: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 85, width: screenSize.width / 3.0, height: screenSize.width / 3.0)
        label.textColor = UIColor.gray
        label.textAlignment = .left
        return label
    }()
    
    // 商品画像を生成
    let itemImage: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 12, y: 10, width: 100, height: 100))
        return image
    }()
    
    // お気に入り登録ボタンを生成
    let favoriteButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 70, y: 160, width: 50, height: 25)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.setTitle("Favo", for: UIControlState.normal)
        button.titleLabel?.font =  UIFont.systemFont(ofSize: 16)
        button.addTarget(self, action: #selector(ViewController.saveToOrDeleteFromFavoritesOnGridView(_:)), for: .touchUpInside)
        return button
    }()
    
    private func setup() {
        layer.borderColor = UIColor.darkGray.cgColor
        layer.borderWidth = 0.5
        
        contentView.addSubview(itemName)
        contentView.addSubview(itemPrice)
        contentView.addSubview(itemRank)
        contentView.addSubview(itemImage)
        contentView.addSubview(favoriteButton)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
