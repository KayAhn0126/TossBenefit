//
//  BenefitsDetailViewController.swift
//  TossBenefit
//
//  Created by Kay on 2022/10/19.
//

import UIKit

class BenefitsDetailViewController: UIViewController {

    @IBOutlet weak var todayBenefitButton: UIButton!
    @IBOutlet weak var vStackView: UIStackView!
    
    var todayBenefit: TodayBenefit? = nil
    var otherBenefits: OtherBenefits? = nil
    var benefitDetails: BenefitDetails = .default
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addGuides()
    }
    
    private func setupUI() {
        navigationItem.largeTitleDisplayMode = .never
        todayBenefitButton.layer.masksToBounds = true
        todayBenefitButton.layer.cornerRadius = 5
        
        let currentCTATitle: String
        if otherBenefits == nil {
            currentCTATitle = todayBenefit!.ctaTitle
        } else {
            currentCTATitle = otherBenefits!.ctaTitle
        }
        todayBenefitButton.setTitle(currentCTATitle, for: .normal)
    }
    
    private func addGuides() {
        let guideViews: [BenefitsGuideView] = benefitDetails.guides.map { guide in
            let guideView = BenefitsGuideView(frame: .zero)
            guideView.icon.image = UIImage(systemName: guide.iconName)
            guideView.title.text = guide.guide
            return guideView
        }
        
        guideViews.forEach { view in
            self.vStackView.addArrangedSubview(view)
            
            NSLayoutConstraint.activate([
                view.heightAnchor.constraint(equalToConstant: 60)
            ])
        }
    }
}
