//
//  RankingGatewayProtocol.swift
//  RakutenRanking
//
//  Created by mao takagai on 2018/03/28.
//  Copyright © 2018年 mao takagai. All rights reserved.
//

import Foundation

protocol RankingGatewayProtocol {
    
    func getOverallRankingRes(_ callback: ([Item]) -> Void)
    
    func getRankingByGenderRes(gender: Gender, _ closure: ([Item]) -> Void)
    
    func getRankingByAgeRes(age: Age, _ closure: ([Item]) -> Void)
    
    func getRankingByGenderAgeRes(gender: Gender, age: Age, _ closure: ([Item]) -> Void)
    
}
