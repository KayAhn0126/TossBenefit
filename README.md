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
- 일단 현재 Hashable이 쓰여있는 자리에는 프로토콜타입이 아닌 구현체가 들어가야한다. Hashable보다 더 큰 범위의 AnyHashable(구조체)를 사용했다.
```swift
    typealias Item = AnyHashable
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
```
