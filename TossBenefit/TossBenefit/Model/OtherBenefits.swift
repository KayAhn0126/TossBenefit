//
//  OtherBenefits.swift
//  TossBenefit
//
//  Created by Kay on 2022/10/16.
//

import Foundation

struct OtherBenefits: Benefit {
    var id = UUID()
    var imageName: String
    var title: String
    var description: String
    var ctaTitle: String
    var type: String
}

extension OtherBenefits {
    static let otherBenefits: [OtherBenefits] = [.thisWeek, .walk, .brand, .tossPay, .quiz, .openChat, .rideTaxi, .card]
    
    // other Benefits
    static let thisWeek = OtherBenefits(
        imageName: "ic_alarm",
        title: "6500원 받기",
        description: "이번주 미션을 받아보세요",
        ctaTitle: "이번주 미션 해보기",
        type: "thisWeek"
    )
    
    static let walk = OtherBenefits(
        imageName: "ic_shoes",
        title: "10원 받기",
        description: "10걸음 걸었다면",
        ctaTitle: "10걸음 걷고 10원 받기",
        type: "walk"
    )

    static let brand = OtherBenefits(
        imageName: "ic_heart",
        title: "브랜드 캐시백 받기",
        description: "좋아하는 브랜드에서",
        ctaTitle: "캐시백 받기",
        type: "brand"
    )
    
    static let tossPay = OtherBenefits(
        imageName: "ic_shoes",
        title: "할인, 캐시백 받기",
        description: "토스페이 결제할 때",
        ctaTitle: "할인, 캐시백 받기",
        type: "tossPay"
    )
    
    static let quiz = OtherBenefits(
        imageName: "ic_alarm",
        title: "돈 상자 받기",
        description: "보험 퀴즈 풀고",
        ctaTitle: "돈 상자 받기",
        type: "quiz"
    )
    
    static let openChat = OtherBenefits(
        imageName: "ic_alarm",
        title: "최대 15,000원 받기",
        description: "오픈채팅방 운영하고",
        ctaTitle: "최대 15,000원 받기",
        type: "openChat"
    )
    
    static let rideTaxi = OtherBenefits(
        imageName: "ic_shoes",
        title: "3,000원 받기",
        description: "택시 타고",
        ctaTitle: "3,000원 받기",
        type: "rideTaxi"
    )
    
    static let card = OtherBenefits(
        imageName: "ic_heart",
        title: "100,000원 받기",
        description: "카드쓰고",
        ctaTitle: "100,000원 받기",
        type: "card"
    )
}
