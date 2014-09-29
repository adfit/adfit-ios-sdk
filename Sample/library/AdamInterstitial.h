//
//  AdamInterstitial.h
//  AdamPublisher
//  Version 2.3.1
//
//  Copyright 2012 Daum Communications. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "AdamError.h"

@protocol AdamInterstitialDelegate;

@interface AdamInterstitial : NSObject

/**
 AdamInterstitialDelegate 프로토콜을 구현한 delegate 객체.
 AdamInterstitialDelegate 프로토콜의 모든 메소드는 optional이므로, 해당 메소드들을 사용하지 않는다면 할당하지 않아도 무방하다.
 일단 delegate 객체를 할당한 이후에는 해당 객체가 메모리에서 해제되지 않도록 주의해야 한다.
 delegate 객체가 해제될 때에는 이 속성에 nil 또는 새로운 delegate 객체를 할당해주어야 하며,
 그렇지 않은 경우 애플리케이션의 Crash를 유발할 수 있다.
 */
@property (nonatomic, assign) id <AdamInterstitialDelegate> delegate;

/**
 Daum 으로부터 발급받은 client id 문자열.
 필수 속성이며, 정상적인 client id를 할당하지 않는 경우 유효 광고 수신이 불가능하다.
 샘플 코드에서는 InterstitialTestClientId 문자열을 사용하나, 이것은 테스트 용도로만 사용해야 한다.
 또한 이 값은 적립금을 쌓는 기준이 되기 때문에, 애플리케이션 배포 전에 발급받은 Client ID를 정확히 입력했는지 반드시 확인해야 한다.
 */
@property (nonatomic, retain) NSString *clientId;

/**
 광고 수신 성공시 광고 페이지를 modalViewController로 화면에 보여줄 부모 뷰 컨트롤러.
 이 속성을 따로 설정해주지 않더라도 SDK 내부적으로 적절한 뷰 컨트롤러를 탐색하여 사용하도록 처리되어있다.
 따라서 특별한 경우가 아니라면 별도로 뷰 컨트롤러 객체를 할당해주지 않아도 무방하다.
 */
@property (nonatomic, retain) UIViewController *superViewController;

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
 AdamInterstitial 클래스의 Singleton 객체인 sharedInterstitial을 리턴한다.
 @return AdamInterstitial 객체
 */
+ (AdamInterstitial *)sharedInterstitial;

/**
 전면형 광고를 요청하고, 요청에 대한 수신이 성공적으로 이루어지면 즉시 화면에 노출시킨다.
 최소 호출 간격은 3분이며, 이전 요청의 성공/실패 여부와 상관없이 3분 이내에는 다시 호출할 수 없다.
 */
- (void)requestAndPresent;

@end

@protocol AdamInterstitialDelegate <NSObject>
@optional
/**
 전면형 광고 수신 성공시 호출되는 메소드.
 @param interstitial 광고 수신 성공 이벤트가 발생한 AdamInterstitial 객체.
 */
- (void)didReceiveInterstitialAd:(AdamInterstitial *)interstitial;

/**
 전면형 광고 수신 실패시 호출되는 메소드.
 광고 수신에 실패한 원인을 알고자 하는 경우, error.localizedDescription 값을 출력해보면 된다.
 @param interstitial 광고 수신 실패 이벤트가 발생한 AdamInterstitial 객체.
 @param error 광고 수신에 실패한 원인이 되는 error 객체.
 */
- (void)didFailToReceiveInterstitialAd:(AdamInterstitial *)interstitial error:(NSError *)error;

/**
 전면형 광고가 보여질 때 호출되는 메소드.
 @param interstitial 전면형 광고 열림 이벤트가 발생한 AdamInterstitial 객체.
 */
- (void)willOpenInterstitialAd:(AdamInterstitial *)interstitial;

/**
 전면형 광고가 보여진 직후 호출되는 메소드.
 @param interstitial 전면형 광고 열림 완료 이벤트가 발생한 AdamInterstitial 객체.
 */
- (void)didOpenInterstitialAd:(AdamInterstitial *)interstitial;

/**
 전면형 광고가 닫힐 때 호출되는 메소드.
 @param interstitial 전면형 광고 닫힘 이벤트가 발생한 AdamInterstitial 객체.
 */
- (void)willCloseInterstitialAd:(AdamInterstitial *)interstitial;

/**
 전명형 광고가 닫힌 직후 호출되는 메소드.
 @param interstitial 전면형 광고 닫힘 완료 이벤트가 발생한 AdamInterstitial 객체.
 */
- (void)didCloseInterstitialAd:(AdamInterstitial *)interstitial;

/**
 전면형 광고 내부의 인터랙션에 의해 애플리케이션이 종료될 때 호출되는 메소드.
 전면형 광고 내부에서 전화 걸기 또는 앱스토어로 이동 기능 등이 실행되는 경우, 애플리케이션이 백그라운드로 들어가게 될 때 호출된다.
 @param interstitial 백그라운드로 전환 이벤트를 발생시킨 AdamInterstitial 객체.
 */
- (void)willResignByInterstitialAd:(AdamInterstitial *)interstitial;

@end