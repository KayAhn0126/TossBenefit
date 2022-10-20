//
//  BenefitsDetailViewController.swift
//  TossBenefit
//
//  Created by Kay on 2022/10/19.
//

import UIKit

class BenefitsDetailViewController: UIViewController {

    @IBOutlet weak var todayBenefitButton: UIButton!
    
    var todayBenefit: TodayBenefit? = nil
    var otherBenefit: OtherBenefits? = nil
    var todayDetail: BenefitDetails = .default
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        todayBenefitButton.layer.masksToBounds = true
        todayBenefitButton.layer.cornerRadius = 5
        
        let currentCTATitle: String
        if otherBenefit == nil {
            currentCTATitle = todayBenefit!.ctaTitle
        } else {
            currentCTATitle = otherBenefit!.ctaTitle
        }
        todayBenefitButton.setTitle(currentCTATitle, for: .normal)
    }
}
