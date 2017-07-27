# AdFit iOS SDK Guide

이 가이드는 iOS Application 에 모바일 광고를 노출하기 위한 광고 데이터요청과 처리 방법을 설명합니다.

사이트/앱 운영정책에 어긋나는 경우 적립금 지급이 거절 될 수 있으니 유의하시기 바랍니다.

* 문의 고객센터 [https://cs.daum.net/question/1440.html](https://cs.daum.net/question/1440.html)
* 사이트/앱 운영 정책 [http://adfit.biz.daum.net/html/use.html](http://adfit.biz.daum.net/html/use.html )

이 문서는 Kakao 신디케이션 제휴 당사자에 한해 제공되는 자료로 가이드 라인을 포함한 모든 자료의 지적재산권은 주식회사 카카오가 보유합니다.

Copyright © Kakao Corp. All Rights Reserved.

---

## AdFit 광고 삽입 방법


### 개발환경

* IDE: Xcode 5.0 이상 권장
* Base SDK: iOS 7.0 이상
* iOS Deployment Target: iOS 4.3 이상


### AdFit SDK 구성

* libAdamPublisher.a : AdFit 광고 라이브러리 파일
* AdamAdView.h : 라이브러리 사용을 위해 필요한 광고 뷰 클래스 헤더
* AdamError.h: 라이브러리에서 공통으로 사용되는 Error 클래스 헤더
* AdamAdWrapperView.h : 인터페이스 빌더에서 사용하기 위한 Wrapper 클래스 헤더
* AdamAdWrapperView.m : 인터페이스 빌더에서 사용하기 위한 Wrapper 클래스 소스
* Sample : AdFit SDK를 적용한 샘플 프로젝트


### * iOS9 [ATS(App Transport Security)](https://developer.apple.com/library/prerelease/ios/technotes/App-Transport-Security-Technote/) 처리

애플은 iOS9에서 ATS(App Transport Security)라는 기능을 제공합니다. 기기에서 ATS 활성화 시 암호화된 HTTPS 방식만 허용됩니다.<br>
HTTPS 방식을 적용하지 않을 경우 애플 보안 기준을 충족하지 않는다는 이유로 광고가 차단될 수 있습니다.

현재 AdFit과 연동된 모든 광고플랫폼에서 HTTPS가 지원되는 것이 아니므로 아래의 사항을 앱의 Info.plist 파일에 적용하여 주시기 바랍니다. 

```
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>
```

#### 1 단계 : 광고단위ID(Client ID) 발급받기 및 SDK 다운로드
실제 광고를 수신하고, 수익 창출을 위해서는 http://adfit.biz.daum.net에서 매체 등록 후 광고단위ID(Client ID)를 발급받아야 한다. 아래 URL을 통해 애플리케이션을 등록할 수 있다.
[http://adfit.biz.daum.net](http://adfit.biz.daum.net)

애플리케이션 등록 후 SDK를 다운로드 받는다.

#### 2 단계 : 라이브러리 import
다운로드 받은 SDK에서 library에 해당하는 폴더를 Xcode의 프로젝트 내에 복사한다.  
만약 인터페이스 빌더를 이용해 광고 뷰를 적용할 것이 아니라면 AdamAdWrapperView.h, AdamAdWrapperView.m 파일은 제외하여도 된다.

다음과 같은 framework가 없다면 추가로 포함시킨다.  
2.2 버전 부터는 EventKit.framework, EventKitUI.framework, AssetsLibrary.framework이 추가적으로 필요하다. 또한, QuartzCore.framework은 더이상 사용하지 않으므로 제거해도 무방하다.

    - AdSupport.framework
    - AssetsLibrary.framework
    - CFNetwork.framework
    - CoreGraphics.framework
    - CoreLocation.framework
    - CoreTelephony.framework
    - EventKit.framework
    - EventKitUI.framework
    - Foundation.framework
    - MediaPlayer.framework
    - MobileCoreServices.framework
    - UIKit.framework
    - Security.framework
    - SystemConfiguration.framework
    
    
    - libz.1.2.5.dylib 

![](http://i1.daumcdn.net/svc/original/U03/adam/5417D48B021D670001)

#### 3 단계 : Build Settings
2.2 버전 부터는 정상적으로 SDK를 사용하기 위해 Build Settings > Linking > Other Linker Flags 항목에 –ObjC 플래그를 추가해주어야 한다.

![](http://i1.daumcdn.net/svc/original/U03/adam/5417D4C80233F30002)

#### 4 단계 : 광고 뷰 삽입 및 호출

##### a. 프로그램적인 삽입 방법
* code 작성을 통해 광고 뷰를 붙이는 방법은 다음의 순서를 따른다.
    - AdamAdView.h 파일 import 하기
    - 광고 뷰 생성하기
    - 광고 뷰 객체에 광고단위ID 세팅하기
    - 화면에 광고 뷰 붙이기


AdamAdView 클래스는 Singleton으로 구현되어있어, 하나의 애플리케이션에서 한개의 객체만 사용이 가능하다. 그렇기 때문에 애플리케이션 내의 여러 화면에서 광고를 보여주고자 하는 경우 가장 좋은 방법은 뷰 컨트롤러의 viewWillApper: 또는 viewDidAppear: 메소드 내부에서 광고 뷰를 붙이는 것이다. 만약 하나의 화면에서만 광고를 보여주고자 한다면, viewDidLoad 메소드 내부에서 광고 뷰를 붙여도 무방하다.

``` objectivec
//  ViewController.m

#import "ViewController.h"
#import "AdamAdView.h"

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // AdamAdView 객체를 가져온다.
    AdamAdView *adView = [AdamAdView sharedAdView];

    if (![adView.superview isEqual:self.view]) {
           // adView가 self.view에 붙어있는 상태가 아니라면,
           // adView에 필요한 속성을 설정한 후 self.view에 붙인다.
           adView.frame = CGRectMake(0.0, 0.0, 320.0, 50.0);
           adView.clientId = @"{광고단위ID}";
           [self.view addSubview:adView];

           if (!adView.usingAutoRequest) {
               // adView가 광고 자동요청 기능을 사용하는 상태가 아니라면,
               // 60초 간격으로 광고 자동요청을 시작한다.
               [adView startAutoRequestAd:60.0];
           }
    }
}
``` 

##### b. 인터페이스 빌더를 이용한 삽입 방법
* 인터페이스 빌더를 이용해 광고 뷰를 붙이는 방법은 다음의 순서를 따른다.  
이 때에는 반드시 AdamAdWrappperView.h, AdamAdWrapperView.m 파일을 프로젝트에 추가해야 한다.
    - AdamAdWrapperView.h, AdamAdWrapperView.m 파일 import 하기
    - AdamAdWrapperView.m 파일에서 광고 뷰 설정하기
    - 광고 뷰를 붙일 xib 파일에 새로운 뷰 추가하기
    - 새로 추가한 뷰의 클래스를 AdamAdWrapperView로 지정하기

AdamAdWrapperView.m 파일을 열면 displayAdView라는 메소드가 구현되어있다.  
이 메소드는 AdamAdWrapperView 객체가 화면에 보여질 때마다 호출되는데, 이 내부에 광고 뷰를 생성하여 붙이는 코드가 작성되어있다. 기 작성된 코드에서 clientId 속성만 자신의 실제 광고단위ID를 넣어주면 된다. 그 외의 속성에 대한 설정은 문서 뒷부분의 레퍼런스를 참고하여 추가하도록 한다.

``` objectivec
//  AdamAdWrapperView.m

#import "AdamAdWrapperView.h"
#import "AdamAdView.h"

@implementation ViewController

- (void)displayAdView
{
    AdamAdView *adView = [AdamAdView sharedAdView];

    if (![adView.superview isEqual:self]) {
           adView.frame = self.bounds;
           adView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
           adView.clientId = @"{광고단위ID}";
           [self addSubview:adView];

           if (!adView.usingAutoRequest) {
               [adView startAutoRequestAd:60.0];
           }
    }
}

- (void)didMoveToWindow {
    [super didMoveToWindow];
    
    if (self.window) {
           [self displayAdView];
    }
}
``` 

그 다음에는 광고 뷰를 붙일 뷰 컨트롤러의 xib 파일을 열고, View 요소를 추가한다.  
뷰의 크기는 width: 320px, height: 50px로 설정하면 되고, 애플리케이션의 가로 모드 지원 여부를 고려하여 Autoresizing 항목을 적절히 설정한다.

![](http://i1.daumcdn.net/svc/original/U03/adam/5417D599047D7E0001)


마지막으로, 추가한 View 요소의 class를 지정한다. 화면 우측의 Identity inspector 창을 열고, class 입력창에 AdamAdWrapperView라고 입력해준다.

![](http://i1.daumcdn.net/svc/original/U03/adam/5417D5B004133C0001)


### Class Reference

#### AdamAdView
--- 

광고 뷰 자체를 가리키는 클래스로, 사용자는 헤더에 선언된 메소드 및 프로퍼티들을 이용해 광고 요청을 실행하고 광고 뷰의 동작을 설정할 수 있다.  
AdamAdView 클래스의 객체를 생성하기 위해서는 아래에서 설명하는 sahredAdView 메소드만을 사용해야 하고, alloc 메소드는 사용할 수 없다. 또한 AdamAdView 클래스를 상속받는 서브클래스를 생성하여 사용하는 것도 불가능하다.


#####*광고 뷰 생성 메소드*

###### sharedAdView

```
+ (AdamAdView *)sharedAdView
```

AdamAdView 클래스의 Singleton 객체인 sharedAdView를 리턴한다.  

AdamAdView 클래스는 Singleton으로 구현되었으므로, 하나의 앱에서는 하나의 AdamAdView 객체만을 사용할 수 있다.

_Return_  
&nbsp;&nbsp;&nbsp;AdamAdView 객체


#####*광고 요청 / 요청 중단 메소드*
###### requestAd

```
- (void)requestAd
```

광고를 1회 요청한다.  

기존과 같이 타이머를 이용해 직접 광고를 요청하고자 할 때 사용할 수 있다. 최소 호출 가능한 시간 간격은 12초이고, 그 이내에 다시 광고 요청을 할 경우 새로운 광고가 수신되지 않는다.


###### startAutoRequestAd:

```
- (void)startAutoRequestAd:(NSTimeInterval)interval
```

주어진 interval에 따라 자동으로 광고를 요청한다.

Interval 인자로는 12.0 이상의 값만 넘길 수 있으며, 그보다 작은 값을 사용하는 경우 최소 허용값인 12.0으로 고정되어 동작한다.  
광고 효과의 극대화를 위해서는 일반적으로 60초를 사용하는 것을 권장한다.  
startAutoRequestAd: 메소드를 호출한 이후에는 stopAutoRequestAd 메소드를 호출해야만 자동요청을 중지할 수 있다.  
또한 광고 자동요청을 사용하고 있는 동안에는 reqeustAd, startAutoRequestAd: 메소드를 호출하여도 새로운 광고가 수신되지 않는다.

_Parameter_  
&nbsp;&nbsp;&nbsp;Interval      광고를 자동으로 요청할 시간 간격.

###### stopAutoRequest

```
- (void)stopAutoRequestAd
```

광고 자동요청을 중지한다.


#####*Properties*

###### delegate

```
@property (nonatomic, assign) id <AdamAdViewDelegate> delegate
```

AdamAdViewDelegate 프로토콜을 구현한 delegate 객체.

AdamAdViewDelegate 프로토콜의 모든 메소드는 optional이므로, 해당 메소드들을 사용하지 않는다면 할당하지 않아도 무방하다.  
일단  delegate 객체를 할당한 이후에는 해당 객체가 메모리에서 해제되지 않도록 주의해야 한다.  
delegate 객체가 해제될 때에는 이 속성에 nil 또는 새로운 delegate 객체를 할당해주어야 하며, 그렇지 않은 경우 애플리케이션의 Crash를 유발할 수 있다.



###### clientId

```
@property (nonatomic, copy) NSString *clientId
```

AdFit 으로부터 발급받은 광고단위ID 문자열.

필수 속성이며, 정상적인 광고단위ID를 할당하지 않는 경우 유효 광고 수신이 불가능하다.  
또한 이 값은 적립금을 쌓는 기준이 되기 때문에, 애플리케이션 배포 전에 발급받은 광고단위ID를 정확히 입력했는지 반드시 확인해야 한다.

###### superViewController

```
@property (nonatomic, retain) UIViewController *superViewController
```

광고 클릭시 광고 페이지를 modalViewController로 화면에 보여줄 부모 뷰 컨트롤러.

이 속성을 따로 설정해주지 않더라도 SDK 내부적으로 적절한 뷰 컨트롤러를 탐색하여 사용하도록 처리되어있다.  
따라서 특별한 경우가 아니라면 별도로 뷰 컨트롤러 객체를 할당해주지 않아도 무방하다.

###### transitionStyle

```
@property (nonatomic, assign) AdamAdViewTransitionStyle transitionStyle
```

배너 광고가 새로 수신될 때의 전환 효과.

게임과 같이 그래픽 퍼포먼스가 중요한 애플리케이션의 경우 기본값인AdamAdViewTransitionStyleNone을 사용하는 것을 권장한다.

###### hasAd

```
@propery (nonatomic, readonly) BOOL hasAd
```

현재 광고를 가지고 있는지 여부.

AdamAdView 객체가 현재 광고를 가지고 있는지 여부를 알 수 있는 속성으로, 기본값은 NO이다.  
단 한번이라도 성공적으로 광고를 수신하여 현재 화면에 보여지고 있다면 YES 값을 가진다.

###### usingAutoRequest

```
@property (nonatomic, readonly) BOOL usingAutoRequest
```

광고 자동요청을 사용하고 있는지 여부.

AdamAdView 객체가 현재 광고를 자동으로 요청하고 있는지 여부를 알 수 있는 속성으로, 기본값은 NO이다.  
startAutoRequest: 메소드를 호출한 이후에는 YES 값을 가지며, stopAutoRequest 메소드를 호출하면 다시 NO 값을 가지게 된다.

###### birth

```
@property (nonatomic, copy) NSString *birth
```

앱 사용자의 생년월일 정보.

앱 내부에서 사용자의 생년월일 정보를 가지는 경우, birth 속성에 할당하여 타겟팅 광고를 수신 받을 수 있다.   
다음과 같은 포맷의 문자열만 할당 가능하며, 유효하지 않은 포맷으로 할당한 경우 무시된다.  
생년월일 정보를 모두 가진 경우: @”yyyyMMdd”  
연도 정보만 가진 경우: @”yyyy----”  
생일 정보만 가진 경우: @”----MMdd”

###### gender

```
@property (nonatomic, copy) NSString *gender
```

앱 사용자의 성별 정보.

앱 내부에서 사용자의 성별 정보를 가지는 경우, gender 속성에 할당하여 타겟팅 광고를 수신 받을 수 있다.   
다음과 같은 포맷의 문자열만 할당 가능하며, 유효하지 않은 포맷으로 할당한 경우 무시된다.  
남성: @”M”  
여성: @”F”





###### sdkVersion

```
@property (nonatomic, readonly) NSString *sdkVersion
```

SDK 버전 정보.

현재 사용 중인 AdFit SDK의 버전 문자열을 가진다.







#####*Constants*

###### AdamAdViewTransitionStyle

```
//광고 전환효과 스타일.
typedef enum {
        AdamAdViewTransitionStyleNone,
        AdamAdViewTransitionStyleCurl,
        AdamAdViewTransitionStyleFlip
} AdamAdViewTransitionStyle;
```

AdamAdViewTransitionStyleNone: 광고 전환효과 없음. 기본값.  
AdamAdViewTransitionStyleCurl: 광고 영역이 상단으로 말려 올라가며 새 광고가 나타나는 효과.  
AdamAdViewTransitionStyleFlip: 광고 영역이 반대편으로 뒤집히며 새 광고가 나타나는 효과.



#### AdamAdViewDelegate
--- 

광고 뷰의 동작과 관련하여 발생하는 이벤트가 전달되는 delegate 메소드들이 선언되어있다.  
모든 메소드들은 optional이므로, 이 메소드들을 사용하지 않는 경우 AdamAdViewDelegate 프로토콜을 따로 구현해야 할 필요는 없다.


#####*광고 수신 / 실패 관련 delegate 메소드*

###### didReceiveAd:

```
- (void)didReceiveAd:(AdamAdView *)adView
```

광고 수신 성공시 호출되는 메소드.

_Parameter_

&nbsp;&nbsp;&nbsp;adView        광고 수신 성공 이벤트가 발생한 AdamAdView 객체.



###### didFailToReceiveAd:error:

```
- (void)didFailToReceiveAd:(AdamAdView *)adView error:(NSError *)error
```

광고 수신 실패시 호출되는 메소드.

error.domain 값이 AdamErrorDomain이라면, error.code 값을 가지고 AdamErrorType 열거형에 정의된 에러 코드로부터 실패 원인을 알아낼 수 있다.  
상세한 에러 메시지를 보고자 한다면 error.localizedDescription 값을 출력해보면 된다.

_Parameter_

&nbsp;&nbsp;&nbsp;adView        광고 수신 실패 이벤트가 발생한 AdamAdView 객체.  
&nbsp;&nbsp;&nbsp;error     광고 수신에 실패한 원인이 되는 error 객체.




#####*광고 클릭 액션 관련 delegate 메소드*

###### willOpenFullScreenAd:

```
- (void)willOpenFullScreenAd:(AdamAdView *)adView
```

전제화면 광고가 보여질 때 호출되는 메소드.

배너 광고를 터치하여 광고 페이지가 전체화면에 보여질 때 호출된다.

_Parameter_

&nbsp;&nbsp;&nbsp;adView        광고 페이지 열림 이벤트가 발생한 AdamAdView 객체.

###### didOpenFullScreenAd:

```
- (void)didOpenFullScreenAd:(AdamAdView *)adView
```

전제화면 광고가 보여진 직후 호출되는 메소드.

배너 광고를 터치하여 광고 페이지가 전체화면에 보여진 직후 호출된다.

_Parameter_

&nbsp;&nbsp;&nbsp;adView        광고 페이지 열림 완료 이벤트가 발생한 AdamAdView 객체.

###### willCloseFullScreenAd:


```
- (void)willCloseFullScreenAd:(AdamAdView *)adView
```

전제화면 광고가 닫힐 때 호출되는 메소드.

전체화면으로 보여지고 있는 광고 페이지가 닫힐 때 호출된다.

_Parameter_

&nbsp;&nbsp;&nbsp;adView        광고 페이지 닫힘 이벤트가 발생한 AdamAdView 객체.




###### didCloseFullScreenAd:


```
- (void)didCloseFullScreenAd:(AdamAdView *)adView
```

전제화면 광고가 닫힌 직후 호출되는 메소드.

전체화면으로 보여지고 있는 광고 페이지가 닫히고 난 직후 호출된다.

_Parameter_

&nbsp;&nbsp;&nbsp;adView        광고 페이지 닫힘 완료 이벤트가 발생한 AdamAdView 객체.

###### willResignByAd:


```
- (void)willResignByAd:(AdamAdView *)adView
```

광고 터치로 인해 애플리케이션이 종료될 때 호출되는 메소드.

배너 광고를 터치하여 전화 걸기 또는 앱스토어로 이동하는 경우, 애플리케이션이 백그라운드로 들어가게 될 때 호출된다.

_Parameter_

&nbsp;&nbsp;&nbsp;adView        백그라운드로 전환 이벤트를 발생시킨 AdamAdView 객체.



#### AdamError
--- 

#####*Constants*

###### AdamErrorType  
광고 수신 실패에 대한 에러코드.

```
typedef enum {
        AdamErrorTypeUnknown,
        AdamErrorTypeNoFillAd,
        AdamErrorTypeNoClientId,
        AdamErrorTypeTooSmallAdView,
        AdamErrorTypeInvisibleAdView,
        AdamErrorTypeAlreadyUsingAutoRequest,
        AdamErrorTypeTooShortRequestInterval,
        AdamErrorTypePreviousRequestNotFinished,
        AdamErrorTypeOpenedAdExists
} AdamErrorType;
```  
- AdamErrorTypeUnknown: 원인을 알 수 없는 에러.  
- AdamErrorTypeNoFillAd: 현재 노출 가능한 광고가 없음.  
- AdamErrorTypeNoClientId: 광고단위ID가 설정되지 않았음.  
- AdamErrorTypeTooSmallAdView: 광고 뷰의 크기가 기준보다 작음.  
- AdamErrorTypeInvisibleAdView: 광고 뷰가 화면에 보여지지 않고 있음.  
- AdamErrorTypeAlreadyUsingAutoRequest: 이미 광고 자동요청 기능을 사용하고 있는 상태임.  
- AdamErrorTypeTooShortRequestInterval: 허용되는 최소 호출 간격보다 짧은 시간 내에 광고를 재요청 했음.  
- AdamErrorTypePreviousRequestNotFinished: 이전 광고 요청에 대한 처리가 아직 완료되지 않았음.  
- AdamErrorTypeOpenedAdExists: 배너가 확장되어 열려있는 상태임.


## 추가 정보(FAQ)

### 광고 수신 실패 원인에 따른 처리 방법
AdamAdView 객체에서 광고 수신 실패시에는 AdamAdViewDelegate 프로토콜의 didFailToReceiveAd:error: 메소드가 호출된다.  
이 메소드로부터 전달받은 error 객체를 가지고 광고 수신 실패의 원인을 파악할 수 있으며, 각각의 에러 타입에 대한 처리는 다음과 같이 한다.


#### Q1. No Fill Ad 
- **domain**: AdamErrorDomain
- **code**: AdamErrorTypeNoFillAd
- **원인**:  
광고를 정상적으로 요청하였으나, 광고 서버에서 보내줄 수 있는 유효 광고가 없을 경우 발생한다. 또는 유효하지 않은 광고단위ID를 설정한 경우에도 발생한다.
- **처리 방법**:  
일정 시간 이후 다시 호출해본다.


#### Q2. No Client Id 
- **domain**: AdamErrorDomain
- **code**: AdamErrorTypeNoClientId
- **원인**:  
AdamAdView 객체의 clientId 속성을 지정하지 않고 광고를 호출한 경우 발생한다.
- **처리 방법**:  
AdamAdView 객체의 clientId 속성에 발급받은 광고단위ID 문자열을 정확하게 할당한다.

#### Q3. Too Small Ad View (AdamAdView)
- **domain**: AdamErrorDomain
- **code**: AdamErrorTypeTooSmallAdView
- **원인**:  
광고 뷰가 기준 사이즈보다 작은 상태에서 광고를 호출한 경우 발생한다.
- **처리 방법**:  
광고 뷰의 기준 사이즈는 320px * 50px 이다. 광고 뷰의 width는 320px 이상, height는  50px 이상으로 지정한다.

#### Q4. Invisible Ad View (AdamAdView)
- **domain**: AdamErrorDomain
- **code**: AdamErrorTypeInvisibleAdView
- **원인**:  
광고 뷰가 화면에 보여지지 않는 상태에서 광고를 호출한 경우 발생한다. 부모 뷰에 붙어있지 않은 경우, modalViewController에 의해 가려진 경우 등이 해당된다.
- **처리 방법**:  
광고 뷰가 화면에 정상적으로 디스플레이 되고 있는지 확인한다.

#### Q5. Already Using Auto Request (AdamAdView)
- **domain**: AdamErrorDomain
- **code**: AdamErrorTypeAlreadyUsingAutoRequest
- **원인**:  
광고 뷰가 Auto Request 기능을 사용하고 있는 상태에서 별도로 광고 요청을 한 경우 (requestAd, startAutoRequestAd: 메소드 호출) 발생한다.
- **처리 방법**:  
startAutoRequestAd: 메소드를 호출하여 광고를 자동으로 요청하고 있을 때에는 해당 기능에 전적으로 광고 요청을 맡기고, 별도로 광고를 요청하지 않는다.


#### Q6. Too Short Request Interval 
- **domain**: AdamErrorDomain
- **code**: AdamErrorTypeTooShortRequestInterval
- **원인**:  
AdamAdView객체는 광고 요청 후 12초 이내에 광고를 재요청 하는 경우 발생한다.
- **처리방법**:  
AdamAdView에서 타이머를 이용해 requestAd 메소드를 직접 호출하는 경우, 타이머의 interval을 적절한 값으로 조정한다. 또는 startAutoRequest: 메소드를 사용하여 광고를 자동 요청하도록 한다.  

#### Q7. Previous Request Not Finished 
- **domain**: AdamErrorDomain
- **code**: AdamErrorTypePreviousRequestNotFinished
- **원인**:  
이전 광고 요청에 대한 처리가 완료되지 않은 상태에서 광고를 재요청 하는 경우 발생한다. 네트워크 상태가 매우 좋지 않은 경우 발생할 수 있다.
- **처리방법**:  
이 에러는 네트워크 상태가 좋지 않은 경우 일시적으로 발생 가능한 에러이므로, 별도로 처리를 해줄 필요는 없다. 해당 에러가 자주 발생한다면 광고 요청 interval을 다소 길게 조정하도록 한다. 
