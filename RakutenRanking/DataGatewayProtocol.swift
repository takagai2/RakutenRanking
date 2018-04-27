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
    
    func deleteDataObject()
    
    func saveFavoriteItem(item: Item)
    
    func getFavoriteItems(_ callback: @escaping ([Item]) -> Void)
    
    func deleteFavoriteObject()
    
    func getRankingType() -> (genderType: Gender, ageType: Age)
}
