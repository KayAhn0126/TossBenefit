//
//  OtherBenefitCell.swift
//  TossBenefit
//
//  Created by Kay on 2022/10/15.
//

// MARK: - 다른 나머지 혜택들을 보여줄 셀
import UIKit

class OtherBenefitsCell: UICollectionViewCell {
    
    @IBOutlet weak var otherBenefitsImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var getPointLabel: UILabel!
    
    func configure(item: OtherBenefits) {
        otherBenefitsImage.image = UIImage(named: item.imageName)
        descriptionLabel.text = item.description
        getPointLabel.text = item.title
    }
}
