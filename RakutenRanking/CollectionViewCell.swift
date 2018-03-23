//
//  CollectionViewCell.swift
//  RakutenRanking
//
//  Created by mao takagai on 2018/03/23.
//  Copyright © 2018年 mao takagai. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    private let rankingListLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: screenSize.width / 3.0, height: screenSize.width / 3.0)
        label.textColor = UIColor.gray
        label.textAlignment = .center
        return label
    }()
    
    private func setup() {
        layer.borderColor = UIColor.darkGray.cgColor
        layer.borderWidth = 3.0
        
        contentView.addSubview(rankingListLabel)
    }
    
    func setupContents(textName: String) {
        rankingListLabel.text = textName
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
