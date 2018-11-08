# 변경이력

## v3.0.5
* AdFitBannerAdView 클래스의 refreshInterval 속성 제거
* Bug Fix

## v3.0.4
* Xcode 10.0 대응 (Swift 4.2)

## v3.0.3
* 안정성 향상 

## v3.0.2
* Xcode 9.3 대응 (Swift 4.1)

## v3.0.1
* Xcode 9.1 대응 (Swift 4.0.2)
* [strip-frameworks.sh](https://github.com/realm/realm-cocoa/blob/master/scripts/strip-frameworks.sh) 추가

## v3.0.0
* iOS 11 대응
* 배포 포맷 변경: Dynamic Framewok
* BITCODE 지원

## v2.4.0
* iOS 10 대응
* HTTPS 대응
* UDID 개선 
* 추가 Framework 필요
    - Security.framework 
* Bug fix

## v2.3.1가* iOS 8 추가 대응 및 UI 개선
* 전면형 광고 지원
* Bug fix

## v2.3.0
* UDID 암호화 방식 변경
* 기본 배너 이미지 사이즈 변경 :  320 X 50 

## v2.2.2
* iOS 7 추가 대응 및 UI 개선
* Bug Fix

## v2.2.1
* iOS 7 대응
* 추가 Framework 필요  
  - AdSupport.framework

## v2.2.0
* 리치미디어 광고 노출 추가 기능 탑재
* 추가 Framework 필요
  - EventKit.framework
  - EventKitUI.framework
  - AssetsLibrary.framework
* 추가 Linker Flag 필요: -ObjC

## v2.1.0.1
* ASIHTTPRequest, Reachability 라이브러리 사용 시 추가 문제 수정

## v2.1.0
* iOS 6 대응 (armv7s 아키텍처)
* 권장 개발환경 변경
* ASIHTTPRequest, Reachability 라이브러리 링크 에러 문제 수정
* AdamAdView 프로퍼티 추가
  - birth, gender, sdkVersion
* AdamInterstitial 프로퍼티 추가
  - birth, gender, sdkVersion

## v2.0.0
* 리치미디어 광고 노출 기능 탑재
* 전면형 광고 노출을 위한 AdamInterstitial 클래스 / AdamInterstitialDelegate 프로토콜 추가
* AdamAdViewDelegate 프로토콜에 메소드 추가
  - didOpenFullScreenAd:
  - didCloseFullScreenAd:
* 추가 Framework 필요
  - QuartzCore.framework
  - MediaPlayer.framework

## v1.5.0
* SDK 구조 및 API 개선
  - 광고 뷰 클래스 변경: MobileAdView → AdamAdView
  - 광고 뷰에 Singleton 구조 적용
  - 광고 뷰 설정 및 상태 확인은 모두 property를 이용하도록 변경
  - 모든 delegate 메소드는 optional로 변경
  - delegate 객체로 UIViewController 객체를 지정하지 않으면 오류 생기는 문제 수정
  - 광고 자동 요청을 위한 내장 메소드 추가
  - 광고 수신 실패에 대한 에러 타입 세분화
* ARC 기반의 일부 프로젝트에서 Crash 발생하는 현상 수정
* 광고 뷰 Flexible Width 적용

## v1.4.1
* 특정 타입의 광고 노출시 간헐적으로 Crash 발생하는 문제 수정
* 특정 타입의 광고 노출시 Status bar를 이용한 최상단 스크롤 안되는 문제 수정
* 광고 페이지 로드시 콘솔에 에러 로그 출력되는 현상 수정

## v1.4.0
* 다양한 광고 Targeting 기능 추가(위치, 망, 통신사 등)
* 추가 framework 필요
  - CoreLocation.framework
  - CoreTelephony.framework
  
## v1.3.2
* iOS5 대응
* 간헐적으로 발생하는 XML Parsing Error 수정
* 샘플코드에서 불필요 라이브러리 제거 (libxml2.x)
* ANIMATIONTYPE_NONE 추가

## v1.3.1
* 광고 클릭 후 webview가 보여진 상태에서 background/foreground 전환 시 crash 발생하는 문제 수정

## v1.3
* 위치정보 등 수집 항목 제거(location, gender, birthday)
* textcolor, backgroundcolor변경 지원 안함
* 광고 library인 libAdAtDaum.a를 하나로 합침
* MobileAdViewDelegate의 필수적이지 않은 함수들 optional로 수정
  - testDevice
  - didReceiveRefreshAd
  - didFailedReceiveAdWithError:
  - didFailedReceiveRefreshAdWithError:
  - willShowADInFullScreen
  - closedFullScreenAD
  - willResideAd
* didFailedRecieveAdWithError -> didFailedReceiveAdWithError 스펠링 오류 수정

## v1.2
* AD@m 클릭스 광고 지원
* Xcode 4.x 부터는 다음 framework 들을 추가 필요
  - libxml2.2.dylib
  - libxml2.2.7.3.dylib
  
## v1.1b
* 동영상광고에 대한 처리 수정 
* 잠정적 문제가 될 수 있는 메모리 누수부분 수정

## v1.1a
* WebView에서 고정값으로 계산되어 잘못 나타나던 부분에 대한 수정
