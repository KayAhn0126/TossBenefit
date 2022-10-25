//
//  BenefitsDetailViewModel.swift
//  TossBenefit
//
//  Created by Kay on 2022/10/24.
//

import Foundation
import Combine

final class BenefitsDetailViewModel {
    @Published var todayBenefit: TodayBenefit?
    @Published var otherBenefits: OtherBenefits?
    @Published var benefitDetails: BenefitDetails
    
    init(unknownBenefit: AnyHashable) {
        if let todayBenefit = unknownBenefit as? TodayBenefit {
            self.todayBenefit = todayBenefit
        } else if let otherBenefit = unknownBenefit as? OtherBenefits {
            self.otherBenefits = otherBenefit
        }
        self.benefitDetails = .default
    }
}
