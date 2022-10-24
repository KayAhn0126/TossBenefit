//
//  BenefitListViewModel.swift
//  TossBenefit
//
//  Created by Kay on 2022/10/24.
//

import Foundation
import Combine

final class BenefitListViewModel {
    var myPointSectionItem: [AnyHashable]
    // for Output -> Data
    @Published var todayBenefitSectionItem: [AnyHashable] = []
    @Published var otherBenefitSectionItems: [AnyHashable] = []
    
    // for Input -> UserInteraction
    var pointDidTapped = PassthroughSubject<MyPoint, Never>()
    var todayDidTapped = PassthroughSubject<TodayBenefit, Never>()
    var otherDidTapped = PassthroughSubject<OtherBenefits, Never>()
    
    init(myPoint: [AnyHashable]) {
        self.myPointSectionItem = myPoint
    }
    
    func fetchData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.todayBenefitSectionItem = TodayBenefit.todayBenefit
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            self.otherBenefitSectionItems = OtherBenefits.otherBenefits
        }
    }
}
