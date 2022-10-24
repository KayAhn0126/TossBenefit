//
//  MyPointCell.swift
//  TossBenefit
//
//  Created by Kay on 2022/10/15.
//

// MARK: - 내 포인트를 보여줄 셀
import UIKit

class MyPointCell: UICollectionViewCell {
    
    @IBOutlet weak var myPointImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var currentPointLabel: UILabel!
    
    func configure(item: MyPoint) {
        myPointImage.image = UIImage(named: "ic_point")
        descriptionLabel.text = "내 포인트"
        currentPointLabel.text = "\(item.point)원"
    }
}
