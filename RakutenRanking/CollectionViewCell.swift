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
        label.frame = CGRect(x: 5, y: 100, width: screenSize.width / 3.0 - 5, height: screenSize.width / 3.0)
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .left
        return label
    }()
    
    // 順位のlabelを生成
    let itemRank: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 4, y: 4, width: 32, height: 32)
        label.backgroundColor = UIColor.gray.withAlphaComponent(0.80)
        label.font = UIFont(name: "Gill Sans", size: 20)
        label.layer.cornerRadius = 15
        label.clipsToBounds = true
        label.textColor = UIColor.white
        label.textAlignment = .center
        return label
    }()
    
    // 商品画像を生成
    let itemImage: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        image.center = CGPoint(x: (screenSize.width / 3.0) / 2.0, y: (screenSize.height / 3.0) / 4.0)
        return image
    }()
    
    // １位から３位までのアイコンを表示する画像を生成
    let rankImage: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 5, y: 145, width: 30, height: 30))
        return image
    }()
    
    // お気に入り登録ボタンを生成
    let favoriteButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 90, y: 145, width: 40, height: 40)
        button.setImage(UIImage(named: "NotFavorite"), for: .normal)
        button.addTarget(self, action: #selector(ViewController.saveToOrDeleteFromFavoritesOnGridView(_:)), for: .touchUpInside)
        return button
    }()
    
    private func setup() {
        layer.borderColor = UIColor.darkGray.cgColor
        layer.borderWidth = 0.5
        
        contentView.addSubview(itemName)
        contentView.addSubview(rankImage)
        contentView.addSubview(itemPrice)
        contentView.addSubview(itemImage)
        contentView.addSubview(favoriteButton)
        contentView.addSubview(itemRank)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // セル再利用時に初期化する
    override func prepareForReuse() {
        super.prepareForReuse()
        favoriteButton.setImage(UIImage(named: "NotFavorite"), for: .normal)
        rankImage.image = nil
    }
    
}
