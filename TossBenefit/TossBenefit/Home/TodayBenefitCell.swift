//
//  TodayBenefitCell.swift
//  TossBenefit
//
//  Created by Kay on 2022/10/15.
//

// MARK: - 오늘의 혜택을 보여줄 셀
import UIKit

class TodayBenefitCell: UICollectionViewCell {
    
    @IBOutlet weak var cellContentView: UIView!
    @IBOutlet weak var todayBenefitImage: UIImageView!
    @IBOutlet weak var todayBenefitLabel: UILabel!
    @IBOutlet weak var todayBenefitButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // cellContentView.backgroundColor = .opaqueSeparator -> 기존 방식
        cellContentView.backgroundColor = .systemGray.withAlphaComponent(0.3)
        cellContentView.layer.cornerRadius = 10
        
        todayBenefitButton.layer.masksToBounds = true
        todayBenefitButton.layer.cornerRadius = 10
    }
    
    func configure(item: TodayBenefit) {
        todayBenefitImage.image = UIImage(systemName: "sparkles")?.withRenderingMode(.alwaysOriginal)
        todayBenefitLabel.text = item.title
        todayBenefitButton.setTitle(item.ctaTitle, for: .normal)
    }
}
