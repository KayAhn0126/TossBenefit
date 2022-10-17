//
//  BenefitListViewController.swift
//  TossBenefit
//
//  Created by Kay on 2022/10/15.
//

import UIKit

class BenefitListViewController: UIViewController {
    
    // - 사용자는 포인트를 볼 수 있다.
    // - 사용자는 오늘의 혜택을 볼 수 있다.
    // - 사용자는 나머지 혜택 리스트를 볼 수 있다. -> 여기까지 생각해보면 collection view 사용
    //
    // - 사용자는 포인트 셀을 눌렀을 때, 포인트 상세 뷰로 넘어간다. -> didSelectedItem func
    // - 사용자는 혜택 관련 셀을 눌렀을 때, 혜택 상세 뷰로 넘어간다.
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    enum Section {
        case mypoint
        case todayBenefit
        case otherBenefits
    }
    
    typealias Item = AnyHashable
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
    // MARK: - Snapshot에 사용될 각각의 items 배열 생성
    var myPointSectionItem: [AnyHashable] = MyPoint.myPoint
    var todayBenefitSectionItems: [AnyHashable] = TodayBenefit.todayBenefit
    var otherBenefitSectionItems: [AnyHashable] = OtherBenefits.otherBenefits
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
}

