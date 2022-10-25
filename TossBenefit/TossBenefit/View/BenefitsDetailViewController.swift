//
//  BenefitsDetailViewController.swift
//  TossBenefit
//
//  Created by Kay on 2022/10/19.
//

import UIKit
import Combine

class BenefitsDetailViewController: UIViewController {

    @IBOutlet weak var todayBenefitButton: UIButton!
    @IBOutlet weak var vStackView: UIStackView!
    
    var viewModel: BenefitsDetailViewModel!
    var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bind()
    }
    
    private func setupUI() {
        navigationItem.largeTitleDisplayMode = .never
        todayBenefitButton.layer.masksToBounds = true
        todayBenefitButton.layer.cornerRadius = 5
    }
    
    private func bind() {
        viewModel.$todayBenefit
            .compactMap { $0 }
            .receive(on: RunLoop.main)
            .sink { [unowned self] todayBenefit in
                self.todayBenefitButton.setTitle(todayBenefit.ctaTitle, for: .normal)
            }.store(in: &subscriptions)
        viewModel.$otherBenefits
            .compactMap { $0 }
            .receive(on: RunLoop.main)
            .sink { [unowned self] otherBenefits in
                self.todayBenefitButton.setTitle(otherBenefits.ctaTitle, for: .normal)
            }.store(in: &subscriptions)
        viewModel.$benefitDetails
            .receive(on: RunLoop.main)
            .sink { [unowned self] details in
                self.addGuides(details)
            }.store(in: &subscriptions)
    }
    
    private func addGuides(_ details: BenefitDetails) {
        let guideViews: [BenefitsGuideView] = details.guides.map { guide in
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
