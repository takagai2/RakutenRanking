//
//  DataGatewayProtocol.swift
//  RakutenRanking
//
//  Created by mao takagai on 2018/04/19.
//  Copyright © 2018年 mao takagai. All rights reserved.
//

import Foundation

protocol DataGatewayProtocol {
    
    func saveItems(gender: Gender, age: Age, array: [Item])
    
    func getItems(gender: Gender, age: Age, _ callback: @escaping ([Item]) -> Void)
    
    func deleteDataObject(gender: Gender, age: Age)
    
    func deleteAllDataObject()
    
    func saveOrDeleteFavoriteItem(item: Item)
    
    func isFavorite(item: Item) -> Bool
    
    func getFavoriteItems(_ callback: @escaping ([Item]) -> Void)
    
    func deleteAllFavoriteObject()
    
    func saveRankingType(genderType: Gender, ageType: Age, displayPattern: Int)
    
    func getRankingType() -> (genderType: Gender, ageType: Age, displayPattern: Int)
}
