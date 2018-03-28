//
//  RankingGatewayProtocol.swift
//  RakutenRanking
//
//  Created by mao takagai on 2018/03/28.
//  Copyright © 2018年 mao takagai. All rights reserved.
//

import Foundation

protocol RankingGatewayProtocol {
    
    var nameArray: [String] { get set }
    var priceArray: [String] { get set }
    var imageUrlArray: [String] { get set }
    var urlArray: [String] { get set }
    
    func getRes(url: String)
    
}
