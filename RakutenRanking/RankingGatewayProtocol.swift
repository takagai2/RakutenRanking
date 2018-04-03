//
//  RankingGatewayProtocol.swift
//  RakutenRanking
//
//  Created by mao takagai on 2018/03/28.
//  Copyright © 2018年 mao takagai. All rights reserved.
//

import Foundation

protocol RankingGatewayProtocol {
    
    func getOverallRankingRes()
    
    func getRankingByGenderRes(gender: Gender)
    
    func getRankingByAgeRes(age: Age)
    
    func getRankingByGenderAgeRes(gender: Gender, age: Age)
    
}
