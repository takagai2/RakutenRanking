//
//  DataGatewayProtocol.swift
//  RakutenRanking
//
//  Created by mao takagai on 2018/04/19.
//  Copyright © 2018年 mao takagai. All rights reserved.
//

import Foundation

protocol DataGatewayProtocol {
    
    func saveItems(array: [Item])
    
    func getItems(gender: Gender?, age: Age?, _ callback: @escaping ([Item]) -> Void)
    
}
