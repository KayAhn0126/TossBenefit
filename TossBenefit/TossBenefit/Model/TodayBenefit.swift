//
//  TodayBenefit.swift
//  TossBenefit
//
//  Created by Kay on 2022/10/16.
//

import Foundation

struct TodayBenefit: Benefit {
    var id = UUID()
    var imageName: String
    var title: String
    var description: String
    var ctaTitle: String
    var type: String
}

extension TodayBenefit {
    
    static let today: TodayBenefit = .pressToGetMoney
    
    static let pressToGetMoney = TodayBenefit(
        imageName: "ic_alarm",
        title: "10원 받기",
        description: "버튼 누르고",
        ctaTitle: "누르고 10원 받기",
        type: "button"
    )
}

