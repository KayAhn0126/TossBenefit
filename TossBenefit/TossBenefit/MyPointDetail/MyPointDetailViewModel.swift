//
//  MyPointDetailViewModel.swift
//  TossBenefit
//
//  Created by Kay on 2022/10/24.
//

import Foundation
import Combine

final class MyPointDetailViewModel {
    @Published var point: MyPoint
    
    init(point: MyPoint) {
        self.point = point
    }
}
