# 비즈보드 광고 연동 (비즈보드 템플릿 사용)

비즈보드 광고는 배너 형태의 네이티브 광고 입니다. <br>
웹뷰가 아닌 네이티브 UI를 사용하여 디스플레이 하고 있습니다. <br>
비즈보드를 위한 템플릿은 2가지 타입(UIView / UITableViewCell)으로 제공 중에 있습니다. <br>
따로 뷰를 구성하지 않으셔도, 템플릿을 사용하시면 쉽게 비즈보드 광고를 노출 할 수 있습니다. <br>
`AdFitNativeAdLoader` 및 `AdFitNativeAd` 클래스에 대한 자세한 설명은 네이티브 광고 페이지에 있습니다. 

## <a name="heading2"></a> 1. 비즈보드 템플릿 타입 선택

네이티브 광고를 구성하기 위해서는 `AdFitNativeAdRenderable` 프로토콜을 만족하는 뷰를 직접 구성해야 하지만,
비즈보드 광고를 쉽게 보여주기 위해서, SDK에서 템플릿을 통해 셀타입과 뷰타입의 템플릿을 제공하고 있습니다. <br>
따라서 서비스의 UI에 따라 셀타입과 뷰타입중 알맞은 템플릿을 선택하여 사용하시면 될 것 같습니다. 

### 1) 셀 타입 (UITableViewCell)

```swift
private let adCellName = "BizBoardListFeedAdTableViewCell"

override func viewDidLoad() {
  //...
  tableView.register(BizBoardCell.self, forCellReuseIdentifier: adCellName)
  //...
}
```

### 2) 뷰 타입 (UIView)

```swift
lazy var nativeAdView = BizBoardTemplate()
```

## <a name="heading2"></a> 2. 비즈보드 광고를 노출하기 위한 준비


### 1) 프로토콜 추가

* nativeAdLoader 의 광고 응답을 받기 위해  `AdFitNativeAdLoaderDelegate` 델리게이트의 프로토콜을 추가 합니다. **(필수)** <br>
* 광고 클릭에 대한 응답을 받기 위해 `AdFitNativeAdDelegate` 프로토콜을 추가합니다. (옵션) <br>
클릭에 대한 이벤트가 필요없을 경우 추가 하지 않으셔도 됩니다.


```swift

class BizBoardViewTypeViewController: UIViewController, AdFitNativeAdLoaderDelegate, AdFitNativeAdDelegate {

...

}

```

### 2) 변수 선언

* 셀타입, 뷰타입 모두 공통적으로 `AdFitNativeAd` 타입과, `AdFitNativeAdLoader` 타입의 변수를 선언 합니다. <br>

#### i. 셀타입 (UITableViewCell)

* 셀 타입에서는 `BizBoardCell` 클래스를 UITableView에 register 해주도록 합니다. 

```swift

    //필수 구현
    var nativeAd: AdFitNativeAd?
    var nativeAdLoader: AdFitNativeAdLoader?


    //선택 구현
    private let adCellName = "BizBoardTableViewCell" // 비즈보드 광고셀의 식별자
    private var isAdHidden = true                    // 광고응답이 실패 또는 노애드 상황일때, 숨김 처리를 위해

    override func viewDidLoad() {
        super.viewDidLoad()

        // 셀타입의 비즈보드 템플릿을 등록해 주세요. 
        tableView.register(BizBoardCell.self, forCellReuseIdentifier: adCellName)

    }            

```

#### ii. 뷰타입 (UIView)

* 뷰 타입에서는 `BizBoardTemplate` 타입의 뷰를 선언 하고 생성 해줍니다. 


```swift

    var nativeAdLoader: AdFitNativeAdLoader?
    var nativeAd: AdFitNativeAd?
    lazy var nativeAdView = BizBoardTemplate() 

    // 비즈보드 커스텀 속성(백그라운드 컬러, 여백)을 전역으로 설정하게 될 경우 nativeAdView를 lazy로 선언 해주시고, 
    // BizBoardTemplate 인스턴스 생성전에, 속성을 설정 해주세요. 인스턴스 별로 설정하거나 속성 설정이 필요없는 경우 따로 lazy 처리는 필요 없습니다. 
}

```

## <a name="heading2"></a> 3. nativeAdLoader 의 생성과 호출

* 발급받은 **adUnitId** 와 함께 nativeAdLoader 인스턴스를 생성합니다.
* nativeAdLoader 델리게이트를 설정 합니다. 
* nativeAdLoader 를 호출 합니다. 

### 주의 사항
- 한번 사용된(`loadAd` 메서드가 호출된) `AdFitNativeAdLoader` 인스턴스는 다시 광고를 호출할 수 없습니다.<br>
- 새로 비즈보드 광고를 요청하기 위해서는 새로운 `AdFitNativeAdLoader` 인스턴스를 생성하여야 합니다.

### 1) 셀 타입 (UITableViewCell)


```swift

    // 꼭 viewDidLoad()에서 구현 하실 필요는 없습니다. 
    // 서비스앱의 상황에 따라 적당한곳에서 생성 및 호출 하시면 됩니다.

    override func viewDidLoad() {
        super.viewDidLoad()
    
        // 위에서 설명했던것 같이 BizBoardCell을 tableView에 등록 합니다.
        tableView.register(BizBoardCell.self, forCellReuseIdentifier: adCellName)
            
        nativeAdLoader = AdFitNativeAdLoader(clientId: "INPUT YOUR AdUnit ID") // 발급받은 adUnitId를 clientId에 넣고 AdFitNativeAdLoader 를 생성합니다.
        nativeAdLoader?.delegate = self // nativeAdLoader 의 델리게이트를 설정합니다.
        nativeAdLoader?.loadAd() // nativeAdLoader의 loadAd() 메서드를 호출합니다. 해당 메서드는 1회만 유효합니다. 광고를 갱신 하기 위해서는, 로더를 초기화한 후 재생성후 호출 해야 합니다.
    }

```

### 2) 뷰 타입 (UIView)

```swift


// 꼭 viewDidLoad()에서 구현 하실 필요는 없습니다. 
// 서비스앱의 상황에 따라 적당한곳에서 생성 및 호출 하시면 됩니다.

override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(nativeAdView) // 위에서 선언한 nativeAdView를 addSubView 해줍니다.
        
        // nativeAdView의 높이와 너비는 다음과 같이 설정해주세요. 자세한 설명은 3.광고뷰의 높이 가변 처리 부분에서 자세히 다루겠습니다.
        let width = view.frame.width
        let height = (view.frame.width - BizBoardTemplate.defaultEdgeInset.left + BizBoardTemplate.defaultEdgeInset.right) / (1029 / 222) + BizBoardTemplate.defaultEdgeInset.top + BizBoardTemplate.defaultEdgeInset.bottom

        nativeAdView.frame.size = CGSize(width: width, height: height) // nativeAdView의 프레임을 설정 합니다.
                
        nativeAdLoader = AdFitNativeAdLoader(clientId: "INPUT YOUR AdUnit ID") // 발급받은 adUnitId를 clientId에 넣고 AdFitNativeAdLoader 를 생성합니다.
        nativeAdLoader?.delegate = self // nativeAdLoader 의 델리게이트를 설정합니다.
        
        nativeAdLoader?.loadAd() // nativeAdLoader의 loadAd() 메서드를 호출합니다. 해당 메서드는 1회만 유효합니다. 광고를 갱신 하기 위해서는, 로더를 초기화한 후 재생성후 호출 해야 합니다. 

}

```

## <a name="heading2"></a> 4. 광고뷰의 너비 및 높이 설정

* 광고뷰의 너비는 광고뷰가 표시될 뷰의 너비와 같게 설정 합니다. 
* 광고뷰의 높이는 다음과 같이 처리 하도록 합니다. 
* 여백을 따로 커스텀하게 처리하지 않았거나, 전역설정을 통해 처리 하였다면 아래와 같이 설정 해주면 됩니다. 

* (추가적으로 아래의 코드에 대하여 설명한다면 설정한 광고뷰의 너비에서 설정된 좌우 여백을 뺀 후 1029 / 222 비율로 나눠 줍니다. <br>
1029 / 222 의 비율은 비즈보드에 표시되는 원본 이미지의 비율입니다. 고정값으로 사용하시면 됩니다. <br>
이제 계산된 값에 설정된 광고뷰의 상하여백을 더해준 값을 광고뷰의 높이로 설정 하시면 됩니다. 
)

* 인스턴스 별로 여백을 커스텀하게 설정하였다면, <br>
 좌측 여백을 커스텀 하였다면, BizBoardTemplate.defaultEdgeInset.left 대신 설정한 값을 넣어 주면 됩니다. <br>
 우측 여백을 커스텀 하였다면, BizBoardTemplate.defaultEdgeInset.right 대신 설정한 값을 넣어 주면 됩니다. <br>
 상측 여백을 커스텀 하였다면, BizBoardTemplate.defaultEdgeInset.top 대신 설정한 값을 넣어 주면 됩니다. <br>
 하측 여백을 커스텀 하였다면, BizBoardTemplate.defaultEdgeInset.bottom 대신 설정한 값을 넣어 주면 됩니다. <br>

```
    let width = view.frame.width
    let height = (view.frame.width - BizBoardTemplate.defaultEdgeInset.left + BizBoardTemplate.defaultEdgeInset.right) / (1029 / 222) + BizBoardTemplate.defaultEdgeInset.top + BizBoardTemplate.defaultEdgeInset.bottom

```

### 1) 셀 타입 (UITableViewCell)
* 광고셀 높이를 미리 지정한 여백에 따라 계산해 놓습니다.
** 너비를 구하는 방법은 예제에서는 광고뷰의 슈퍼뷰의 너비 또는 디바이스의 너비를 사용하고 있지만 자유롭게 설정하시면 됩니다.
** 너비값을 토대로 너비값에 좌우 여백을 빼줍니다. 
** 위에서 계산된 값을 1029/222의 비율로 나눠 줍니다. 
** 1029/222 는 비즈보드 이미지의 원본 비율입니다. 
** 계산된 값에 상하여백을 더해준 값이 광고셀의 높이 입니다. 

* `tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath)` 에서 광고셀 높이 설정
* `func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath)` 에서 광고셀 높이 설정
* 예제에서는 isAdHidden 값의 false 일때 (광고가 숨김처리 되지 않았을때)
* 0번째 로우일때 (광고 셀을 리스트의 0번째 로우로 처리 했을때) 로 가정하여 
* 이 때 광고셀의 높이를 반환하도록 처리 하였습니다. 

```swift

//광고셀의 높이는 기기에 따라서 항상 고정이 되도록 설정 한다.
var adViewHeight: CGFloat {
    let deviceWidth = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
        
    // 여백을 인스턴스별로도 설정 가능하지만, 여기서는 스태틱 값을 사용해서 표시해주므로,
    // 전체 뷰 높이와 너비는 변하지 않을 수 있다.
        
    // 좌우여백을 제외한 실제 width
    let rWidth = (deviceWidth - (BizBoardCell.defaultEdgeInset.left + BizBoardCell.defaultEdgeInset.right))
        
    // 비율로 계산된 실제 height
    let rHeight = rWidth / (1029 / 222)
        
    // 상하여백을 포함한 셀 높이
    let cellHeight = rHeight + (BizBoardCell.defaultEdgeInset.top + BizBoardCell.defaultEdgeInset.bottom)
    //let cellWidth = (deviceWidth - (BizBoardTemplate.edgeInset.left + BizBoardTemplate.edgeInset.right)) / (1029 / 222) + BizBoardTemplate.edgeInset.top + BizBoardTemplate.edgeInset.bottom
        
    return cellHeight//cellWidth + 8
}


// MARK: - UITableViewDelegate
func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if isAdHidden == false, indexPath.row == 0 {
        return adViewHeight
    } 
}
    
func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    if isAdHidden == false, indexPath.row == 0 {
        return adViewHeight
    } 
}


```

### 2) 뷰 타입 (UIView)
* 예제에서는 `viewDidLoad`에서 구현을 하였지만, 라이프사이클의 시작포인트에 적당히 작성하시면 될 것 같습니다.
* 뷰의 높이를 계산한 후 `nativeAdView` 의 프레임 사이즈를 설정 합니다. 


```swift

override func viewDidLoad() {
    super.viewDidLoad()

    ...

    let width = view.frame.width
    let height = (view.frame.width - BizBoardTemplate.defaultEdgeInset.left + BizBoardTemplate.defaultEdgeInset.right) / (1029 / 222) + BizBoardTemplate.defaultEdgeInset.top + BizBoardTemplate.defaultEdgeInset.bottom

    nativeAdView.frame.size = CGSize(width: width, height: height)

}

```

## <a name="heading2"></a> 5. 광고 응답 성공시 처리 (바인딩)

### 1) 셀 타입 (UITableViewCell)
* 셀타입에서는 광고 응답이 성공하면 `nativeAd` 변수에 받아온 광고를 할당 합니다.
* 광고 응답 성공시 `isAdHidden` 를 false로 설정합니다. <br>
해당 속성은 광고 응답 실패시 광고를 숨김 처리하기 위한 방법으로 제안드리는 내용입니다. <br>
sdk에서 지원하고 있는 변수 타입이 아닌 서비스에서 직접 구현하셔야 하는 변수 입니다. <br>
광고셀을 숨기기 위한 적절한 방법을 자유롭게 사용하시면 됩니다. 
* 해당속성은 `tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)` <br>
 `tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)` <br>
 등 테이블뷰의 데이타소스 설정에 사용됩니다. 
* 광고를 받아온 후 테이블뷰를 리로드 해줍니다. 
* `tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)` 메서드 내에서 광고셀의 `bind()` 메서드 및 `nativeAd` 변수의 delegate를 설정 합니다.  


```swift
    // MARK: - AdFitNativeAdLoaderDelegate
    func nativeAdLoaderDidReceiveAds(_ nativeAds: [AdFitNativeAd]) {
        guard let ad = nativeAds.first else {
            return
        }
        self.nativeAd = ad
        self.isAdHidden = false

        tableView.reloadData()
        
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? BizBoardCell {
            if let nativeAd = nativeAd {
                nativeAd.bind(cell)
                nativeAd.delegate = self
            }
        }
    }


```


### 2) 뷰 타입 (UIView)
* 뷰타입에서는 광고 응답이 성공하면 `nativeAd` 변수에 받아온 광고를 할당 합니다.
* `nativeAdView` 의 isHidden 속성을 false로 설정하여 뷰가 보여질 수 있도록 합니다. 
* `bindAdView()` 메서드를 호출합니다. 
* `bindAdView()` 함수는 커스텀하게 구현한 함수로 `bindAdView()`메서드 내부의 내용을 직접 호출하셔도 됩니다. 
* `nativeAd` 의 `bind(nativeAdView)` 를 호출 합니다. 내부의 파라미터에는 `nativeAdView`를 넣어 줍니다.
* `nativeAd` 의 delegate를 설정 합니다. (클릭 후 이벤트 처리가 필요없으면 설정 하지 않으셔도 됩니다.)


```swift
    // MARK: - AdFitNativeAdLoaderDelegate
    func nativeAdLoaderDidReceiveAds(_ nativeAds: [AdFitNativeAd]) {
        guard let ad = nativeAds.first else {
            return
        }
        self.nativeAd = ad
        nativeAdView.isHidden = false
        
        bindAdView(nativeAdView: nativeAdView)
        
        let message = "delegate: nativeAdLoaderDidReceiveAds"
        messageLabel.text = message
        print(message)
    }

    private func bindAdView(nativeAdView: UIView) {
        guard let nativeAdView = nativeAdView as? (UIView & AdFitNativeAdRenderable) else {
            return
        }
                
        if let nativeAd = self.nativeAd {
            nativeAd.bind(nativeAdView)
            nativeAd.delegate = self
            nativeAdView.autoresizingMask = [.flexibleWidth]
        }
    }

```


## <a name="heading2"></a> 6. 광고 응답 실패시 처리

### 1) 셀 타입 (UITableViewCell)
* 광고 응답 실패시 `isAdHidden` 를 true로 설정합니다. <br>
해당 속성은 광고 응답 실패시 광고를 숨김 처리하기 위한 방법으로 제안드리는 내용입니다. <br>
sdk에서 지원하고 있는 변수 타입이 아닌 서비스에서 직접 구현하셔야 하는 변수 입니다. <br>
광고셀을 숨기기 위한 적절한 방법을 자유롭게 사용하시면 됩니다. 


```swift

func nativeAdLoaderDidFailToReceiveAd(_ nativeAdLoader: AdFitNativeAdLoader, error: Error) {
        
    self.isAdHidden = true
        
    tableView.reloadData()
        
    print("didFailToReceiveAd, error: \(error) (\(error.localizedDescription))")
}

```

### 2) 뷰 타입 (UIView)
* 광고 응답 실패시 `nativeAdView` 의 isHidden 속성을 false로 설정하여 뷰가 숨겨질 수 있도록 합니다. <br>

```swift

func nativeAdLoaderDidFailToReceiveAd(_ nativeAdLoader: AdFitNativeAdLoader, error: Error) {
        
    nativeAdView.isHidden = true
        
    let message = "delegate: didFailToReceiveAd \(error) (\(error.localizedDescription))"
    messageLabel.text = message
    print(message)
}


```

## <a name="heading2"></a> 7. 비즈보드 광고의 갱신 시점
* `AdFitNativeAdLoader` 와 `AdFitNativeAd` 인스턴스는 한번 광고를 요청한 후 뷰의 라이프사이클 동안 유지됩니다. 
* 서비스의 UI 와 UX 에 따라 비즈보드 갱신의 시점이 달라질 수 있을텐데, <br>
보통은 뷰의 전환이 일어날때 마다 갱신 해주는것이 매출 측면에서 유리 합니다. 
*  아래 예제에서는 뷰가 사라질때 `AdFitNativeAdLoader` 를 초기화 해주고, <br>
뷰가 다시 보이게 될때 로더가 없다면 생성해 주고, 델리게이트를 다시 설정하고, `loadAd()` 메서드를 호출 해주도록 합시다. 


```swift

override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
        
    nativeAdLoader?.delegate = nil
    nativeAdLoader = nil
}
    
override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
        
    if nativeAdLoader == nil {
        nativeAdLoader = AdFitNativeAdLoader(clientId: "DAN-1hux82hxke720")
        nativeAdLoader?.delegate = self
            
        nativeAdLoader?.loadAd()
    }
}

```

## <a name="heading2"></a> 8. 비즈보드 템플릿 커스텀 속성
* 각 설정의 우선순위는 다음과 같습니다. 
* 인스턴스별 설정 > 전역 설정 > 기본 설정
* 설정하지 않으면 기본 설정으로 동작합니다.

### 1) 백그라운드뷰 컬러 설정
* 기본 설정의 값은 다음과 같습니다. 
* #f3f3f3
 


#### i. 클래스 설정(전역설정)
* `BizBoardTemplate` 및 `BizBoardCell` 생성전에 설정 해주세요. 
* 생성 후에는 적용되지 않습니다.
* 앱내에 생성된 모든 `BizBoardTemplate` 및 `BizBoardCell` 의 인스턴스에 영향을 줍니다. 

```swift

//셀타입
BizBoardCell.backgroundColor = .yellow

//뷰타입
BizBoardTemplate.backgroundColor = .yellow

```

#### ii. 인스턴스별 설정

```swift

//셀타입
func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    ...
    if let cell = cell as? BizBoardCell {
        cell.bgViewColor = .yellow
    }
}

//뷰타입
override func viewDidLoad() {
    super.viewDidLoad()

    ...
        
    //인스턴스 커스텀
    nativeAdView.bgViewColor = .yellow
        
    ...

}

```

### 2) 백그라운드뷰 여백 설정
* 기본 설정의 값은 다음과 같습니다. 
* UIEdgeInsets(top: 0, left: 16, bottom: 8, right: 16)

#### i. 클래스 설정(전역설정)
* `BizBoardTemplate` 및 `BizBoardCell` 생성전에 설정 해주세요. 
* 생성 후에는 적용되지 않습니다.
* 앱내에 생성된 모든 `BizBoardTemplate` 및 `BizBoardCell` 의 인스턴스에 영향을 줍니다. 

```swift

//셀타입
BizBoardCell.defaultEdgeInset = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)

//뷰타입
BizBoardTemplate.defaultEdgeInset = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)

```

#### ii. 인스턴스별 설정

```swift

//셀타입
func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    ...
    if let cell = cell as? BizBoardCell {
        cell.bgViewleftMargin = 16
        cell.bgViewRightMargin = 16
        cell.bgViewTopMargin = 0
        cell.bgViewBottomMargin = 8
    }
}

//뷰타입
override func viewDidLoad() {
    super.viewDidLoad()

    ...
        
    //인스턴스 커스텀
    nativeAdView.bgViewleftMargin = 56
    nativeAdView.bgViewRightMargin = 16
    nativeAdView.bgViewTopMargin = 10
    nativeAdView.bgViewBottomMargin = 10
        
    ...

}

```

## <a name="heading2"></a> 9. 에러 코드

광고 수신에 실패한 경우, `nativeAdLoaderDidFailToReceiveAd` delegate 메서드를 통해 에러 객체를 전달받을 수 있습니다.<br>
각각의 에러에 대한 설명은 아래 표를 참고해주세요.

|   코드  |               메시지                   |                    설명                               |
|:------:|--------------------------------------|------------------------------------------------------|
|  1     | clientId property is nil             | 배너광고만 해당 됩니다. 비즈보드 광고는 해당 없습니다.            |
|  2     | no ad to show                        | 노출 가능한 광고가 없는 경우. 잠시 후 다시 광고 요청을 시도해주세요. |
|  3     | invalid ad received                  | 유효하지 않은 광고를 받은 경우. AdFit에 문의해주세요.            |
|  5     | attempted to load ad too frequently  | 과도하게 짧은 시간 간격으로 광고를 재요청한 경우.                 |
|  6     | HTTP failed                          | HTTP 에러. 계속해서 반복 발생하는 경우 AdFit에 문의해주세요.      | 