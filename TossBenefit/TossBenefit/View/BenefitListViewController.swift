//
//  BenefitListViewController.swift
//  TossBenefit
//
//  Created by Kay on 2022/10/15.
//

import UIKit
import Combine

class BenefitListViewController: UIViewController {
    
    // - 사용자는 포인트를 볼 수 있다.
    // - 사용자는 오늘의 혜택을 볼 수 있다.
    // - 사용자는 나머지 혜택 리스트를 볼 수 있다. -> 여기까지 생각해보면 collection view 사용
    //
    // - 사용자는 포인트 셀을 눌렀을 때, 포인트 상세 뷰로 넘어간다. -> didSelectedItem func
    // - 사용자는 혜택 관련 셀을 눌렀을 때, 혜택 상세 뷰로 넘어간다.
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    enum Section: Int, CaseIterable{
        case mypoint
        case todayBenefit
        case otherBenefits
    }
    
    typealias Item = AnyHashable
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
    // MARK: - Snapshot에 사용될 각각의 items 배열 생성
    var subscriptions = Set<AnyCancellable>()
    
    var viewModel: BenefitListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = BenefitListViewModel(myPoint: MyPoint.myPoint)
        // CollectionView
        //  - Presentation, -> Cell을 어떻게 구성할지?
        //  - Data,         -> 내용을 무엇으로 채울지?
        //  - Layout        -> 내용이 채워진 Cell들을 어떻게 보여줄지?
        
        configureCollectionView()
        setupUI()
        bind()
        viewModel.fetchData()
    }
    
    private func configureCollectionView() {
        // MARK: - Presentation 구현
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { [unowned self] collectionView, indexPath, item in
            guard let section = Section(rawValue: indexPath.section) else { return nil }
            let cell = self.configureCell(for: collectionView, section: section, item: item, indexPath: indexPath)
            return cell
        })
        
        // MARK: - Data 구현
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(viewModel.myPointSectionItem, toSection: .mypoint)
        snapshot.appendItems([], toSection: .todayBenefit)
        snapshot.appendItems([], toSection: .otherBenefits)
        dataSource.apply(snapshot)
        
        // MARK: - 내용으로 채워진 cell들을 어떻게 보여줄지 layout 메서드에서 구현
        collectionView.collectionViewLayout = layout()
        collectionView.delegate = self
    }
    
    private func setupUI() {
        navigationItem.title = "혜택"
    }
    
    private func bind() {
        // Output -> Data
        viewModel.$todayBenefitSectionItem
            .receive(on: RunLoop.main)
            .sink { items in
                self.applySnapShot(items: items, section: .todayBenefit)
            }.store(in: &subscriptions)
        
        viewModel.$otherBenefitSectionItems
            .receive(on: RunLoop.main)
            .sink { items in
                self.applySnapShot(items: items, section: .otherBenefits)
            }.store(in: &subscriptions)
        
        // Input -> User Interaction
        viewModel.pointDidTapped
            .receive(on: RunLoop.main)
            .sink { [unowned self] point in
                let myPointDetailStoryBoard = UIStoryboard(name: "MyPointDetail", bundle: nil)
                let vc = myPointDetailStoryBoard.instantiateViewController(withIdentifier: "MyPointDetailViewController") as! MyPointDetailViewController
                vc.viewModel = MyPointDetailViewModel(point: point)
                self.navigationController?.pushViewController(vc, animated: true)
            }.store(in: &subscriptions)
        
        viewModel.todayDidTapped
            .receive(on: RunLoop.main)
            .sink { [unowned self] todayBenefit in
                let todayBenefitStoryBoard = UIStoryboard(name: "BenefitsDetail", bundle: nil)
                let vc = todayBenefitStoryBoard.instantiateViewController(withIdentifier: "BenefitsDetailViewController") as! BenefitsDetailViewController
                vc.viewModel = BenefitsDetailViewModel(unknownBenefit: todayBenefit)
                self.navigationController?.pushViewController(vc, animated: true)
            }.store(in: &subscriptions)
        
        viewModel.otherDidTapped
            .receive(on: RunLoop.main)
            .sink { [unowned self] otherBenefits in
                let otherBenefitStoryBoard = UIStoryboard(name: "BenefitsDetail", bundle: nil)
                let vc = otherBenefitStoryBoard.instantiateViewController(withIdentifier: "BenefitsDetailViewController") as! BenefitsDetailViewController
                vc.viewModel = BenefitsDetailViewModel(unknownBenefit: otherBenefits)
                self.navigationController?.pushViewController(vc, animated: true)
            }.store(in: &subscriptions)
    }
    
    private func applySnapShot(items: [Item], section: Section) {
        var snapshot = dataSource.snapshot()
        snapshot.appendItems(items, toSection: section)
        dataSource.apply(snapshot)
    }
    
    // MARK: - Section에 따라 셀 구현하는 메서드
    private func configureCell(for collectionView: UICollectionView, section: Section, item: Item, indexPath: IndexPath) -> UICollectionViewCell? {
        switch section {
        case .mypoint :
            let myPointCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyPointCell", for: indexPath) as! MyPointCell
            myPointCell.configure(item: item as! MyPoint)
            return myPointCell
        case .todayBenefit :
            let todayBenefitCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodayBenefitCell", for: indexPath) as! TodayBenefitCell
            todayBenefitCell.configure(item: item as! TodayBenefit)
            return todayBenefitCell
        case .otherBenefits :
            let otherBenefitsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "OtherBenefitsCell", for: indexPath) as! OtherBenefitsCell
            otherBenefitsCell.configure(item: item as! OtherBenefits)
            return otherBenefitsCell
        }
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
        let spacing: CGFloat = 10
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(60))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(60))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 16, bottom: 0, trailing: 16)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}

// MARK: - cell이 선택이 되었을때 실행되는 메서드
extension BenefitListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = dataSource.itemIdentifier(for: indexPath)
        
        if let myPoint = item as? MyPoint {
            viewModel.pointDidTapped.send(myPoint)
        } else if let todayBenefit = item as? TodayBenefit {
            viewModel.todayDidTapped.send(todayBenefit)
        } else if let otherBenefits = item as? OtherBenefits {
            viewModel.otherDidTapped.send(otherBenefits)
        }
    }
}

