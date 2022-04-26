# 배너 광고 연동

## <a name="heading1"></a> 1. 광고 요청하기

<h5 class="tab-title" data-tab-name="banner-load">Swift</h5>
``` swift
import UIKit
import AdFit

class MyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let bannerAdView = AdFitBannerAdView(clientId: "Input Your ClientId", adUnitSize: "320x50")
        bannerAdView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 50)
        bannerAdView.rootViewController = self
        view.addSubView(bannerAdView)
        bannerAdView.loadAd()
    }

}
```

<h5 class="tab-title" data-tab-name="banner-load">Objective-C</h5>
``` objc
#import "MyViewController.h"
#import <AdFit/AdFit-Swift.h>

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AdFitBannerAdView *bannerAdView = [[AdFitBannerAdView alloc] initWithClientId:@"Input Your ClientId" 
                                                                       adUnitSize:@"320x50"];
    bannerAdView.frame = CGRectMake(0.f, 0.f, self.view.bounds.size.width, 50.f);
    bannerAdView.rootViewController = self;
    [self.view addSubView:bannerAdView];
    [bannerAdView loadAd];
}

@end
``` 

## <a name="heading2"></a> 2. 배너 속성 설정
### 1) rootViewController
배너 광고 클릭시, AdFit SDK에 포함된 웹뷰 컨트롤러가 modal 방식으로 나타나며 광고주 페이지가 노출됩니다.<br>
이 때 AdFit SDK는 내부적으로 적절한 뷰 컨트롤러를 탐색한 후, 탐색된 뷰 컨트롤러를 통해 광고주 페이지를 노출시킵니다.<br>
광고주 페이지를 노출시킬 뷰 컨트롤러를 직접 지정하고자 하는 경우, 해당 뷰 컨트롤러 객체를 `rootViewController` 프로퍼티에 할당해주세요.

### 2) delegate
배너 광고로부터 발생하는 특정 이벤트를 감지하기 위해, `delegate` 프로퍼티를 활용할 수 있습니다.<br>
`AdFitBannerAdViewDelegate` 프로토콜을 구현한 클래스의 객체를 `delegate` 프로퍼티에 할당해주면 됩니다.<br>
자세한 사항은 [**3. delegate 메서드 구현**](#heading3) 항목을 참고해주세요.

## <a name="heading3"></a> 3. delegate 메서드 구현
- `AdFitBannerAdViewDelegate` 프로토콜을 구현함으로써 광고로부터 발생하는 특정 이벤트를 감지할 수 있습니다.<br>
광고를 정상적으로 받은 경우, 광고를 받지 못한 경우, 광고가 클릭된 경우에 대한 delegate 메서드를 제공합니다.

<h5 class="tab-title" data-tab-name="banner-delegate">Swift</h5>
``` swift
func adViewDidReceiveAd(_ bannerAdView: AdFitBannerAdView) {
    print("didReceiveAd")
}
    
func adViewDidFailToReceiveAd(_ bannerAdView: AdFitBannerAdView, error: Error) {
    print("didFailToReceiveAd - error :\(error.localizedDescription)")
}
    
func adViewDidClickAd(_ bannerAdView: AdFitBannerAdView) {
    print("didClickAd")
}
```

<h5 class="tab-title" data-tab-name="banner-delegate">Objective-C</h5>
``` objc
- (void)adViewDidReceiveAd:(AdFitBannerAdView *)bannerAdView {
    NSLog(@"didReceiveAd");
}

- (void)adViewDidFailToReceiveAd:(AdFitBannerAdView *)bannerAdView error:(NSError *)error {
    NSLog(@"didFailToReceiveAd - error = %@", [error localizedDescription]);
}

- (void)adViewDidClickAd:(AdFitBannerAdView *)bannerAdView {
    NSLog(@"didClickAd");
}
``` 

## <a name="heading4"></a> 4. 에러 코드
광고 수신에 실패한 경우, `adViewDidFailToReceiveAd` delegate 메서드를 통해 에러 객체를 전달받을 수 있습니다.<br>
각각의 에러에 대한 설명은 아래 표를 참고해주세요.

|   코드  |               메시지                   |                    설명                               |
|:------:|--------------------------------------|------------------------------------------------------|
|  1     | clientId property is nil             | AdFitBannerAdView 객체에 clientId가 세팅되지 않은 경우.     |
|  2     | no ad to show                        | 노출 가능한 광고가 없는 경우. 잠시 후 다시 광고 요청을 시도해주세요. |
|  3     | invalid ad received                  | 유효하지 않은 광고를 받은 경우. AdFit에 문의해주세요.            |
|  4     | failed to render ad                  | AdFitBannerAdView 객체의 사이즈가 기준 사이즈보다 작은 경우.    |
|  5     | attempted to load ad too frequently  | 과도하게 짧은 시간 간격(30초 이내)으로 광고를 재요청한 경우.       |
|  6     | HTTP failed                          | HTTP 에러. 계속해서 반복 발생하는 경우 AdFit에 문의해주세요.      |
