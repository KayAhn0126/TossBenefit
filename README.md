# TossBenefit

## 🍎 Hashable과 AnyHashable 차이

- 먼저 이 상황이 어떻게 생겼는지 알아보자.
- Item에는 우리가 보여줘야하는 것들이 들어가야한다. (내 포인트, 오늘의 혜택, 나머지 혜택)
- 하지만 모델로 본다면 (포인트)를 모델화한 MyPoint와 (오늘의 혜택, 나머지 혜택)을 모델화한 Benefit 구조체 2가지가 있다.
- 아래의 코드에서는 Item에 MyPoint와 Benefit 둘 다 들어가야 하기 때문에 처음엔 아래와 같은 시도를 했다.

```swift

typealias Item = Hashable

```

- 하지만 이렇게 작성했을때는 아래와 같은 상황이 발생했다.

![](https://i.imgur.com/cXr7jiU.png)

- 일단 현재 Hashable이 쓰여있는 자리에는 프로토콜 타입이 아닌 구현체가 들어가야한다. Hashable보다 더 큰 범위의 AnyHashable(구조체)를 사용했다.

```swift

typealias Item = AnyHashable

var dataSource: UICollectionViewDiffableDataSource<Section, Item>!

```

## 🍎 섹션이 여러개일때 각각의 데이터를 어떻게 구성 했는지~
- 먼저 Collection view를 생성하기 위해서는 3가지를 기억해야한다
    - **Presentation  -> Cell을 어떻게 구성할지?**
    - **Data          -> 내용을 무엇으로 채울지?**
    - **Layout        -> 내용이 채워진 Cell들을 어떻게 보여줄지?**

```swift
dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { [unowned self] collectionView, indexPath, item in
            guard let section = Section(rawValue: indexPath.section) else { return nil }
            let cell = self.configureCell(for: collectionView, section: section, item: item, indexPath: indexPath)
            return cell                                                                  
})
```
- indexPath를 통해 해당 cell의 section을 가져오고, section에 따라 cell을 구성하는 configureCell 메서드를 실행한다.
- configureCell 메서드 내부
```swift
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
```

- dataSource에 적용할 snapshot을 아래와 같이 구성한다.
```swift
var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
    snapshot.appendSections(Section.allCases)
    snapshot.appendItems(myPointSectionItem, toSection: .mypoint)
    snapshot.appendItems(todayBenefitSectionItem, toSection: .todayBenefit)
    snapshot.appendItems(otherBenefitSectionItems, toSection: .otherBenefits)
    dataSource.apply(snapshot)
```

## 🍎 실무에서는 FlowLayout이 더 많이 쓰인다는데 왜?

- compositional layout이 더 다양하게 표현할 수 있는데 왜 FlowLayout?

## 🍎 fractionWidth/Height, estimated 복기
- collection view layout을 구성하는 layout()메서드 내부를 보자
```swift
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
```
- fractionalWidth와 fractionalHeight는 item의 경우, 자신이 속한 group을 기준으로 비율을 맞춘다.
- 즉, item 사이즈를 정할때 fractionalWidth(1)의 의미는 group을 기준으로 item 사이즈를 그룹과 같게 하겠다는 의미.
- .estimated(60)은 최소 60point를 보장하겠다는 의미.

## 🍎 interItemSpacing/interGroupSpacing 차이점

- **group.interItemSpacing = .fixed(spacing)**
    - interItemSpacing은 아이템간 간격
- **section.interGroupSpacing = spacing**
    - interGroupSpacing은 그룹간 간격
- 왜 둘은 넣는 값이 다른가?
- 먼저 interItemSpacing의 타입은 NSCollectionLayoutSpacing이다. 
- NSCollectionLayoutSpacing의 Discussion을 보면 아래와 같이 설명되어있다.
    - You can express spacing using fixed or flexible spacing. Use fixed spacing to provide an exact amount of space. For example, the following code creates exactly 200 points of space between the items in the group.
    ```swift
    group.interItemSpacing = .fixed(200.0)
    ```
    - Use flexible spacing to provide a minimum amount of space that can grow as more space becomes available. For example, the following code creates at least 200 points of space between the items in the group. As more space becomes available, items are respaced evenly in the additional space.
    ```swift
    group.interItemSpacing = .flexible(200.0)
    ```
- **즉, NSCollectionLayoutSpacing 타입은 .fixed() 또는 .flexible()로 설정 해주어야 한다.**
- **interGroupSpacing은 CGFloat 타입이라 바로 값을 넣어줘도 된다.**

## 🍎 Section과 Section 사이에 공간을 주고 싶다면 아래와 같이 사용하자
```swift
section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 16, bottom: 0, trailing: 16)
```

## 🍎 TodayBenefitCell에서 "클릭하기" 버튼의 ContentInSet 적용 전, 후 알아보기.


|         ContentInSet 수정 전         |         ContentInSet 수정 후         |
|:------------------------------------:|:------------------------------------:|
| ![](https://i.imgur.com/fogpFO8.png) | ![](https://i.imgur.com/dsPBtvX.png) |
| ![](https://i.imgur.com/SeYaee3.png) | ![](https://i.imgur.com/8LkTnsb.png) |

- ContentInSet의 좌,우로 값을 수정해 버튼의 좌,우에 공간이 들어간것을 볼 수 있다.

## 🍎 TodayBenefitCell에서 layer.maskToBounds란 무엇인가?
- 링크 추가 예정.

## 🍎 TodayBenefitCell에서 ContentView에 alphaComponent란 무엇인가?
- 투명도 조절을 하는 메서드
- TodayBenefitCell.swift내 awakeFromNib() 메서드는 아래와 같다.
```swift
override func awakeFromNib() {
    super.awakeFromNib()
        
    // cellContentView.backgroundColor = .opaqueSeparator -> 기존 방식
    cellContentView.backgroundColor = .systemGray.withAlphaComponent(0.3)
    cellContentView.layer.cornerRadius = 10
        
    todayBenefitButton.layer.masksToBounds = true
    todayBenefitButton.layer.cornerRadius = 10
}
```
- backgroundColor 프로퍼티를 정해주는 코드에서 systemGray.withAlphaComponent(number)는 해당 색상의 투명도를 조절하는 메서드이다.
