//
//  BenefitListViewModel.swift
//  TossBenefit
//
//  Created by Kay on 2022/10/24.
//

import Foundation

final class BenefitListViewModel {
    var myPointSectionItem: [AnyHashable]
    @Published var todayBenefitSectionItem: [AnyHashable] = []
    @Published var otherBenefitSectionItems: [AnyHashable] = []
    
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
