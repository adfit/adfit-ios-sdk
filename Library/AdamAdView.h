//
//  AdamAdView.h
//  AdamPublisher
//  Version 2.3.1
//
//  Copyright 2012 Daum Communications. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdamError.h"

/**
 AdamAdView의 광고 전환효과 스타일.
 */
typedef enum {
    AdamAdViewTransitionStyleNone,              // 광고 전환효과 없음. 기본값.
    AdamAdViewTransitionStyleCurl,              // 기존 광고가 상단으로 말려 올라가며 새 광고가 나타나는 효과.
    AdamAdViewTransitionStyleFlip               // 광고 영역이 반대편으로 뒤집히며 새 광고가 나타나는 효과.
} AdamAdViewTransitionStyle;

@protocol AdamAdViewDelegate;

@interface AdamAdView : UIView <UIGestureRecognizerDelegate>

/**
 AdamAdViewDelegate 프로토콜을 구현한 delegate 객체.
 AdamAdViewDelegate 프로토콜의 모든 메소드는 optional이므로, 해당 메소드들을 사용하지 않는다면 할당하지 않아도 무방하다.
 일단 delegate 객체를 할당한 이후에는 해당 객체가 메모리에서 해제되지 않도록 주의해야 한다.
 delegate 객체가 해제될 때에는 이 속성에 nil 또는 새로운 delegate 객체를 할당해주어야 하며,
 그렇지 않은 경우 애플리케이션의 Crash를 유발할 수 있다.
 */
@property (nonatomic, assign) id <AdamAdViewDelegate> delegate;

/**
 Daum 으로부터 발급받은 client id 문자열.
 필수 속성이며, 정상적인 client id를 할당하지 않는 경우 유효 광고 수신이 불가능하다.
 샘플 코드에서는 TestClientId 문자열을 사용하나, 이것은 테스트 용도로만 사용해야 한다.
 또한 이 값은 적립금을 쌓는 기준이 되기 때문에, 애플리케이션 배포 전에 발급받은 client id를 정확히 입력했는지 반드시 확인해야 한다.
 */
@property (nonatomic, copy) NSString *clientId;

/**
 광고 클릭시 광고 페이지를 modalViewController로 화면에 보여줄 부모 뷰 컨트롤러.
 이 속성을 따로 설정해주지 않더라도 SDK 내부적으로 적절한 뷰 컨트롤러를 탐색하여 사용하도록 처리되어있다.
 따라서 특별한 경우가 아니라면 별도로 뷰 컨트롤러 객체를 할당해주지 않아도 무방하다.
 */
@property (nonatomic, retain) UIViewController *superViewController;

/**
 배너 광고가 새로 수신될 때의 전환 효과.
 게임과 같이 그래픽 퍼포먼스가 중요한 애플리케이션의 경우 기본값인 AdamAdViewTransitionStyleNone을 사용하는 것을 권장한다.
 */
@property (nonatomic, assign) AdamAdViewTransitionStyle transitionStyle;

/**
 현재 광고를 가지고 있는지 여부.
 AdamAdView 객체가 현재 광고를 가지고 있는지 여부를 알 수 있는 속성으로, 기본값은 NO이다.
 단 한번이라도 성공적으로 광고를 수신하여 현재 화면에 보여지고 있다면 YES 값을 가진다.
 */
@property (nonatomic, readonly) BOOL hasAd;

/**
 광고 자동요청을 사용하고 있는지 여부.
 AdamAdView 객체가 현재 광고를 자동으로 요청하고 있는지 여부를 알 수 있는 속성으로, 기본값은 NO이다.
 startAutoRequestAd: 메소드를 호출한 이후에는 YES 값을 가지며, stopAutoRequest 메소드를 호출하면 다시 NO 값을 가지게 된다.
 */
@property (nonatomic, readonly) BOOL usingAutoRequest;

/**
 앱 사용자의 생년월일 정보.
 앱 내부에서 사용자의 생년월일 정보를 가지는 경우, birth 속성에 할당하여 타겟팅 광고를 수신 받을 수 있다.
 다음과 같은 포맷의 문자열만 할당 가능하며, 유효하지 않은 포맷으로 할당한 경우 무시된다.
 - 생년월일 정보를 모두 가진 경우: @"yyyyMMdd"
 - 연도 정보만 가진 경우: @"yyyy----"
 - 생일 정보만 가진 경우: @"----MMdd"
 */
@property (nonatomic, copy) NSString *birth;

/**
 앱 사용자의 성별 정보.
 앱 내부에서 사용자의 성별 정보를 가지는 경우, gender 속성에 할당하여 타겟팅 광고를 수신 받을 수 있다.
 다음과 같은 포맷의 문자열만 할당 가능하며, 유효하지 않은 포맷으로 할당한 경우 무시된다.
 - 남성: @"M"
 - 여성: @"F"
 */
@property (nonatomic, copy) NSString *gender;

/**
 SDK 버전 정보.
 현재 사용 중인 Ad@m SDK의 버전 문자열을 가진다.
 */
@property (nonatomic, readonly) NSString *sdkVersion;

/**
 mraid 광고 요청 정보.
 rootview가 아닐경우 mraid포맷을 요청하지 않도록 한다.
 해당 속성에 할당하여 mraid 광고를 선택하여 수신 받을 수 있다.
 - mraid 광고: @"y"
 - 일반 광고: @"n"
 */
@property (nonatomic, copy) NSString *mraid;

/**
 AdamAdView 클래스의 Singlton 객체인 sharedAdView를 리턴한다.
 AdamAcView 클래스는 Singleton으로 구현되었으므로, 하나의 앱에서는 하나의 AdamAdView 객체만을 사용할 수 있다.
 @return AdamAdView 객체
 */
+ (AdamAdView *)sharedAdView;

/**
 광고를 1회 요청한다.
 기존과 같이 타이머를 이용해 직접 광고를 요청하고자 할 때 사용할 수 있다.
 최소 호출 가능한 시간 간격은 12초이고, 그 이내에 다시 광고 요청을 할 경우 새로운 광고가 수신되지 않는다.
 */
- (void)requestAd;

/**
 주어진 interval에 따라 자동으로 광고를 요청한다.
 interval 인자로는 12.0 이상의 값만 넘길 수 있으며, 그보다 작은 값을 사용하는 경우 최소 허용값인 12.0으로 고정되어 동작한다.
 광고 효과의 극대화를 위해서는 일반적으로 60초를 사용하는 것을 권장한다.
 startAutoRequestAd: 메소드를 호출한 이후에는 stopAutoRequestAd 메소드를 호출해야만 자동요청을 중지할 수 있다.
 또한 광고 자동요청을 사용하고 있는 동안에는 requestAd, startAutoRequestAd: 메소드를 호출하여도 새로운 광고가 수신되지 않는다.
 @param interval 광고를 자동으로 요청할 시간 간격.
 */
- (void)startAutoRequestAd:(NSTimeInterval)interval;

/**
 광고 자동요청을 중지한다.
 */
- (void)stopAutoRequestAd;

@end



@protocol AdamAdViewDelegate <NSObject>
@optional
/**
 광고 수신 성공시 호출되는 메소드.
 @param adView 광고 수신 성공 이벤트가 발생한 AdamAdView 객체.
 */
- (void)didReceiveAd:(AdamAdView *)adView;

/**
 광고 수신 실패시 호출되는 메소드.
 광고 수신에 실패한 원인을 알고자 하는 경우, error.localizedDescription 값을 출력해보면 된다.
 @param adView 광고 수신 실패 이벤트가 발생한 AdamAdView 객체.
 @param error 광고 수신에 실패한 원인이 되는 error 객체.
 */
- (void)didFailToReceiveAd:(AdamAdView *)adView error:(NSError *)error;

/**
 전체화면 광고가 보여질 때 호출되는 메소드.
 배너 광고를 터치하여 광고 페이지가 전체화면에 보여질 때 호출된다.
 @param adView 광고 페이지 열림 이벤트가 발생한 AdamAdView 객체.
 */
- (void)willOpenFullScreenAd:(AdamAdView *)adView;

/**
 전체화면 광고가 보여진 직후 호출되는 메소드.
 배너 광고를 터치하여 광고 페이지가 전체화면에 보여진 직후 호출된다.
 @param adView 광고 페이지 열림 완료 이벤트가 발생한 AdamAdView 객체.
 */
- (void)didOpenFullScreenAd:(AdamAdView *)adView;

/**
 전체화면 광고가 닫힐 때 호출되는 메소드.
 전체화면으로 보여지고 있는 광고 페이지가 닫힐 때 호출된다.
 @param adView 광고 페이지 닫힘 이벤트가 발생한 AdamAdView 객체.
 */
- (void)willCloseFullScreenAd:(AdamAdView *)adView;

/**
 전체화면 광고가 닫힌 직후 호출되는 메소드.
 전체화면으로 보여지고 있는 광고 페이지가 닫히고 난 직후 호출된다.
 @param adView 광고 페이지 닫힘 완료 이벤트가 발생한 AdamAdView 객체.
 */
- (void)didCloseFullScreenAd:(AdamAdView *)adView;

/**
 광고 터치로 인해 애플리케이션이 종료될 때 호출되는 메소드.
 배너 광고를 터치하여 전화 걸기 또는 앱스토어로 이동하는 경우, 애플리케이션이 백그라운드로 들어가게 될 때 호출된다.
 @param adView 백그라운드로 전환 이벤트를 발생시킨 AdamAdView 객체.
 */
- (void)willResignByAd:(AdamAdView *)adView;

@end
