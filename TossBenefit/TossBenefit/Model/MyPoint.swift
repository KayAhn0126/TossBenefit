//
//  MyPoint.swift
//  TossBenefit
//
//  Created by Kay on 2022/10/15.
//

import Foundation

struct MyPoint: Hashable {
    var point: Int
}

extension MyPoint {
    static let myPoint: [MyPoint] = [.default]
    
    static let `default` = MyPoint(point: 0)
}
