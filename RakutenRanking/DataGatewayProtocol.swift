//
//  DataGatewayProtocol.swift
//  RakutenRanking
//
//  Created by mao takagai on 2018/04/19.
//  Copyright © 2018年 mao takagai. All rights reserved.
//

import Foundation

protocol DataGatewayProtocol {
    
    func saveObject(array: [Item])
    
    func callObject(gender: Gender?, age: Age?) -> [Item]
    
}
