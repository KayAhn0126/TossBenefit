//
//  TodayBenefitDetailViewController.swift
//  TossBenefit
//
//  Created by Kay on 2022/10/19.
//

import UIKit

class TodayBenefitDetailViewController: UIViewController {

    var todayBenefit: TodayBenefit = .pressToGetMoney
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
    }
}
