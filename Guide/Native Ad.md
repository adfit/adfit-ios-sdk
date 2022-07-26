# 네이티브 광고 연동
Native Ad는 앱 / 플랫폼 고유의 UI를 사용자에게 제공되도록 광고 애셋을 포함하고 있는 광고 형태입니다.
## <a name="heading2"></a> 1. 광고 요청
- 네이티브 광고의 요청은 `AdFitNativeAdLoader` 클래스를 통해 이루어 집니다.<br>
- 광고 요청 후 성공적으로 응답을 받으면, 구현된`AdFitNativeAdLoaderDelegate` 프로토콜을 통해 광고 애셋을 포함한 `AdFitNativeAd`객체를 제공합니다.<br>
- `AdFitNativeAd` 통해서 구현한 뷰와 바인딩 하여 네이티브 광고를 표시합니다.<br>

### 주의 사항
- 한번 사용된(`loadAd` 메서드가 호출된) `AdFitNativeAdLoader` 객체는 다시 광고를 호출할 수 없습니다.<br>
- 새로 네이티브 광고를 요청하기 위해서는 새로운 `AdFitNativeAdLoader` 객체를 생성하여야 합니다.

<h5 class="tab-title" data-tab-name="native-request">Swift</h5>

```swift
import UIKit
import AdFit

class MyViewController: UIViewController, AdFitNativeAdDelegate {
    
    let adLoader = AdFitNativeAdLoader(clientId: "Input Your ClientId")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adLoader.delegate = self
        adLoader.loadAd()
    }

    // MARK: - AdFitNativeAdLoaderDelegate
    func nativeAdLoaderDidReceiveAd(_ nativeAds: AdFitNativeAd) {
        let nativeAdView = MyNativeAdView(frame: view.bounds.divided(atDistance: 300, from: .minYEdge).slice)
        nativeAd.bind(nativeAdView)
        nativeAd.delegate = self
        view.addSubview(nativeAdView)
    }
}
```

<h5 class="tab-title" data-tab-name="native-request">Objective-C</h5>

```objc
#import "MyViewController.h"
#import "MyNativeAdView.h"
#import "AdFit-Swift.h"

@interface MyViewController() <AdFitNativeAdDelegate>

@property (nonatomic, strong) AdFitNativeAdLoader *adLoader;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.adLoader = [[AdFitNativeAdLoader alloc] initWithClientId:@"Input Your ClientId"];
    self.adLoader.delegate = self;
    [self.adLoader loadAd];
}

#pragma mark - AdFitNativeAdLoaderDelegate
- (void)nativeAdLoaderDidReceiveAd:(AdFitNativeAd *)nativeAd {
    MyNativeAdView *nativeAdView = [[MyNativeAdView alloc] initWithFrame:CGRectMake(0.f, 0.f, 300.f, 200.f)];
    [nativeAd bind:nativeAdView];
    [self.view addSubview:nativeAdView];        
}
@end
```
## <a name="heading1"></a> 2. 광고 뷰 구현하기
- 네이티브 광고의 UI는 서비스의 컨텐츠와 잘 어울리도록 구성되어야 하므로, 뷰 클래스를 개별 앱에서 직접 구현하셔야 합니다.
- 네이티브 광고의 뷰 클래스는 `UIView` 클래스를 상속받도록 하고, `AdFitNativeAdRenderable` 프로토콜을 추가로 구현해주세요.

### 1) 네이티브 광고 뷰 구성
다음은 피드 형태로 네이티브 광고 뷰를 구성한 예입니다.

<img src="https://t1.daumcdn.net/adfit_sdk/document-assets/ios/native-ad-components2.png" width="640" style="border:1px solid #aaa">

| 번호 | 설명                     | UI 클래스                | AdFitNativeAdRenderable |
|-----|-------------------------|------------------------|-------------------------|
| 1   | 제목                     | UILabel                | adTitleLabel()          |
| 2   | 행동유도버튼               | UIButton               | adCallToActionButton()  |
| 3   | 프로필명                  | UILabel                | adProfileNameLabel()    |
| 4   | 프로필이미지               | UIImageView             | adProfileIconView()    |
| 5   | 미디어 (이미지, 동영상 등)    | AdFitMediaView         | adMediaView()           |
| 6   | 광고 아이콘                |                        |                         |

- AdFit의 네이티브 광고는 위의 6가지 요소로 구성됩니다.
- 개별 요소들은 위 표에서 대응되는 UI 클래스를 통해 표시되도록 구현해주세요.
- 사용자가 광고임을 명확히 인지할 수 있도록 "광고", "AD", "Sponsored" 등의 텍스트를 별도로 표시해주셔야 합니다.
- `5. 미디어` 요소의 경우 SDK에 포함된 `AdFitMediaView` 클래스를 사용하여 표시합니다.<br>
   인터페이스 빌더를 사용하시는 경우, 빈 View를 배치한 후 클래스를 `AdFitMediaView` 로 지정하시면 됩니다.
  - `AdFitMediaView` 클래스에는 `videoRenderer()` 메서드가 구현되어 있습니다.<br>
 네이티브 광고의 미디어 타입이 비디오인 경우, 해당 메서드를 호출하여 `AdFitVideoRenderer` 객체에 접근할 수 있습니다.<br>
 해당 객체를 사용하면 네이티브 광고에 표시된 비디오의 제어(`play` / `pause` / `mute` / `unmute`)가 가능합니다.

### 2) AdFitNativeAdRenderable 프로토콜
- 네이티브 광고 뷰의 구현을 마친 후에는, `AdFitNativeAdRenderable` 프로토콜에 정의된 메서드를 추가로 구현해야 합니다.
- 뷰 클래스가 `AdFitNativeAdRenderable` 프로토콜을 따르도록 구현되어야 네이티브 광고 수신 후 정상적으로 바인딩이 이루어질 수 있습니다.

다음은 뷰 클래스에 `AdFitNativeAdRenderable` 프로토콜을 구현한 예입니다.

<h5 class="tab-title" data-tab-name="native-renderable">Swift</h5>

```swift
import UIKit
import AdFit

class MyNativeAdView: UIView, AdFitNativeAdRenderable {

    @IBOutlet weak var titleLabel: UILabel?   
    @IBOutlet weak var callToActionButton: UIButton?
    @IBOutlet weak var profileImageView: UIImageView?
    @IBOutlet weak var profileNameLabel: UILabel?
    @IBOutlet weak var mediaView: AdFitMediaView?
    
    // MARK: - AdFitNativeAdRenderable
    func adTitleLabel() -> UILabel? {
        return titleLabel
    }
    
    func adCallToActionButton() -> UIButton? {
        return callToActionButton
    }
    
    func adProfileNameLabel() -> UILabel? {
        return profileNameLabel
    }
    
    func adProfileIconView() -> UIImageView? {
        return profileImageView
    }
    
    func adMediaView() -> AdFitMediaView? {
        return mediaView
    }
    
}
```

<h5 class="tab-title" data-tab-name="native-renderable">Objective-C</h5>

```objc
#import "MyNativeAdView.h"
#import "AdFit-Swift.h"

@interface MyNativeAdView () <AdFitNativeAdRenderable>

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UIButton *callToActionButton;
@property (nonatomic, weak) IBOutlet UILabel *profileNameLabel;
@property (nonatomic, weak) IBOutlet UIImageView *profileIconView;
@property (nonatomic, weak) IBOutlet AdFitMediaView *mediaView;

@end

@implementation MyNativeAdView

#pragma mark - AdFitNativeAdRenderable
- (UILabel *)adTitleLabel {
    return self.titleLabel;
}

- (UIButton *)adCallToActionButton {
    return self.callToActionButton;
}

- (UILabel *)adProfileNameLabel {
    return self.profileNameLabel;
}

- (UIImageView *)adProfileIconView {
    return self.profileIconView;
}

- (AdFitMediaView *)adMediaView {
    return self.mediaView;
}

@end
```

## <a name="heading3"></a> 3. 네이티브 광고 로더  속성

### 1) rootViewController
네이티브 광고 클릭시, AdFit SDK에 포함된 웹뷰 컨트롤러가 modal 방식으로 나타나며 광고주 페이지가 노출됩니다.<br>
이 때 AdFit SDK는 내부적으로 적절한 뷰 컨트롤러를 탐색한 후, 탐색된 뷰 컨트롤러를 통해 광고주 페이지를 노출시킵니다.<br>
광고주 페이지를 노출시킬 뷰 컨트롤러를 직접 지정하고자 하는 경우, 해당 뷰 컨트롤러 객체를 `rootViewController` 프로퍼티에 할당해주세요.<br>

### 2) desiredMediaWidth
네이티브 광고 뷰에서 미디어 요소가 그려지길 원하는 영역의 가로 길이입니다.<br>
이 속성을 지정하면, 광고 요청시 해당 길이에 맞게 최적화 된 사이즈의 미디어 요소를 받을 수 있습니다.<br>
기본값은 현재 기기가 세로 모드일 때의 가로 해상도입니다.<br>
### 3) delegate
네이티브 로더로 부터 발생하는 특정 이벤트를 감지하기 위해, delegate 프로퍼티를 활용할 수 있습니다.<br>
`AdFitNativeAdLoaderDelegate` 프로토콜을 구현한 클래스의 객체를 `delegate` 프로퍼티에 할당해주면 됩니다.<br>
자세한 사항은 [**6. delegate 메서드 구현**](#heading5) 항목을 참고해주세요.
## <a name="heading3"></a> 4. 네이티브 광고 속성
### 1) mediaAspectRatio
네이티브 광고에 포함된 미디어 요소의 `가로 / 세로` 비율입니다.<br>
네이티브 광고가 로드되기 전에는 0 값을 가지며, 로드된 이후 실제 미디어 요소의 비율로 변경됩니다.<br>
자세한 사항은 [**5. 네이티브 광고 뷰의 너비 / 높이 최적화**](#heading4) 항목을 참고해주세요.

### 2) mediaType
네이티브 광고에 포함된 미디어 요소의 타입을 가리킵니다.<br>
`.image` / `.video` 두가지 타입 중 하나를 가질 수 있습니다.<br>

### 3) delegate
네이티브 광고로 부터 발생하는 특정 이벤트를 감지하기 위해, delegate 프로퍼티를 활용할 수 있습니다.<br>
`AdFitNativeAdDelegate` 프로토콜을 구현한 클래스의 객체를 `delegate` 프로퍼티에 할당해주면 됩니다.<br>
자세한 사항은 [**6. delegate 메서드 구현**](#heading5) 항목을 참고해주세요.
## <a name="heading4"></a> 5. 네이티브 광고 뷰의 너비 / 높이 최적화
- 네이티브 광고의 미디어 요소는 각기 다른 비율의 이미지 또는 비디오가 수신될 수 있습니다.
- 현재, 이미지 타입인 경우 1.91:1, 비디오 타입인 경우 16:9 비율의 미디어가 다운로드 됩니다.
- 이처럼 각기 다른 비율의 미디어에 대해서 광고 뷰의 사이즈를 최적화 할 수 있도록, `mediaAspectRatio` 속성을 제공합니다.
- 만약 미디어 요소의 비율에 따라 사이즈가 적절하게 조정되도록 구현하지 않은 경우, 미디어 요소는 `scaleAspectFit` 로직에 따라 그려집니다.<br>

다음은 광고 수신 후 `mediaAspectRatio` 속성을 사용하의 광고 뷰의 사이즈를 조정하는 예제입니다.

<h5 class="tab-title" data-tab-name="native-sizing">Swift</h5>

```swift
func nativeAdLoaderDidReceiveAd(_ nativeAd: AdFitNativeAd) {
    let nativeAdView = MyNativeAdView(frame: view.bounds.divided(atDistance: 300, from: .minYEdge).slice)
    let mediaWidth = nativeAdView.frame.width
    let mediaHeight = mediaWidth / nativeAd.mediaAspectRatio
    // mediaWidth, mediaHeight 값을 사용해 광고 뷰 전체의 사이즈를 조정하도록 구현
    nativeAd.bind(nativeAdView)
    view.addSubview(nativeAdView)
}
```

<h5 class="tab-title" data-tab-name="native-sizing">Objective-C</h5>

```objc
- (void)nativeAdLoaderDidReceiveAd:(AdFitNativeAd *)nativeAd {
    MyNativeAdView *nativeAdView = [[MyNativeAdView alloc] initWithFrame:CGRectMake(0.f, 0.f, 300.f, 200.f)];
    CGFloat mediaWidth = nativeAdView.frame.size.width;
    CGFloat mediaHeight = mediaWidth / nativeAd.mediaAspectRatio
    // mediaWidth, mediaHeight 값을 사용해 광고 뷰 전체의 사이즈를 조정하도록 구현
    [nativeAd bind:nativeAdView];
    [self.view addSubview:nativeAdView];
}
```


## <a name="heading5"></a> 6. delegate 메서드 구현
### 1) AdFitNativeAdLoaderDelegate
- `AdFitNativeAdLoaderDelegate` 프로토콜을 구현함으로써 광고 요청 결과 (광고를 정상적으로 받은 경우 / 광고를 받지 못한 경우)를 확인할 수 있는 delegate 메서드를 제공합니다.<br>
  
### 2) AdFitNativeAdDelegate
- `AdFitNativeAdDelegate` 프로토콜을 구현하면, 광고 클릭시 `nativeAdDidClickAd(_:)` 메서드가 호출됩니다.

<h5 class="tab-title" data-tab-name="native-delegate">Swift</h5>

```swift
func nativeAdLoaderDidReceiveAd(_ nativeAd: AdFitNativeAd) {
    print("didReceiveAd")
}
    
func nativeAdLoaderDidFailToReceiveAd(_ nativeAdLoader: AdFitNativeAdLoader, error: Error) {
    print("didFailToReceiveAd - error: \(error.localizedDescription)")
}

func nativeAdDidClickAd(_ nativeAd: AdFitNativeAd) {
    print("didClickAd")
}

```

<h5 class="tab-title" data-tab-name="native-delegate">Objective-C</h5>

```objc
- (void)nativeAdLoaderDidReceiveAd:(AdFitNativeAd *)nativeAd {
	NSLog(@"didReceiveAd");
}

- (void)nativeAdLoaderDidFailToReceiveAd:(AdFitNativeAdLoader *)nativeAdLoader error:(NSError *)error {
	NSLog(@"didFailToReceiveAd - error: %@", error.localizedDescription);
}

- (void)nativeAdDidClickAd:(AdFitNativeAd *)nativeAd {
	NSLog(@"didClickAd");
}

```


## <a name="heading6"></a> 6. 에러 코드
광고 수신에 실패한 경우, `nativeAdLoaderDidFailToReceiveAd` delegate 메서드를 통해 에러 객체를 전달받을 수 있습니다.<br>
각각의 에러에 대한 설명은 아래 표를 참고해주세요.

|   코드  |               메시지                   |                    설명                               |
|:------:|--------------------------------------|------------------------------------------------------|
|  1     | clientId property is nil             | AdFitBannerAdView 객체에 clientId가 세팅되지 않은 경우.     |
|  2     | no ad to show                        | 노출 가능한 광고가 없는 경우. 잠시 후 다시 광고 요청을 시도해주세요. |
|  3     | invalid ad received                  | 유효하지 않은 광고를 받은 경우. AdFit에 문의해주세요.            |
|  5     | attempted to load ad too frequently  | 과도하게 짧은 시간 간격으로 광고를 재요청한 경우.                 |
|  6     | HTTP failed                          | HTTP 에러. 계속해서 반복 발생하는 경우 AdFit에 문의해주세요.      |
