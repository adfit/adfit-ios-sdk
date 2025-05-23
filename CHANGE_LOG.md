# 변경이력

## v3.19.7
* 메모리 접근 동기화 개선으로 멀티스레드 환경에서 발생하던 간헐적 크래시 이슈 해결
                    
## v3.19.6
* iOS 15.0 minimum target 대응
* 중복요청에 대한 에러 수집
* xcode 16.3 대응
                    
## v3.18.6
* 버그 수정 및 코드 안정화
                    
## v3.18.3
* 버그 수정 및 코드 안정화
                    
## v3.17.2
* 버그 수정 및 코드 안정화
                    
## v3.15.4
* 버그 수정 및 코드 안정화
                    
## v3.15.2
* 버그 수정 및 코드 안정화
                    
## v3.14.20
* 버그 수정 및 코드 안정화
                    
## v3.14.19
* 버그 수정 및 코드 안정화
                    
## v3.14.18
* 버그 수정 및 코드 안정화
                    
## v3.14.17
* 버그 수정 및 코드 안정화
                    
## v3.14.15
* 버그 수정 및 코드 안정화
                    
## v3.14.13
* 버그 수정 및 코드 안정화
                    
## v3.14.12
* 버그 수정 및 코드 안정화
                    
## v3.14.7
* First Party API 사용 사유 명시
                    
## v3.14.7
* First Party API 사용 사유 명시
                    
## v3.14.2
* 버그 수정 및 코드 안정화

## v3.14.5
* 버그 수정및 코드 안정화

## v3.13.11
* 광고 클릭시 랜딩 되지 않는 케이스가 있어 수정

## v3.12.22
* Pod 업데이트시 라이센스 warning 수정

## v3.12.21
* 버그 수정및 코드 안정화

## v3.12.19
* Cocoapod 을 통해 제공되던 프레임워크 형태를 xcframework로 변경 

## v3.12.18
* 최소 지원 버전 13.0으로 상향

## v3.12.7
* 네이티브 광고 인포아이콘 위치 커스텀 조정

## v3.12.6
* 네이티브 광고 바디 에셋 추가

## v3.12.5
* 네이티브 광고 지원
* 네이티브 광고 비즈보드 템플릿 지원

## v3.11.5
* xcode13 스테이터스바 이상 현상 수정

## v3.11.1
* 버그 수정및 코드 안정화  

## v3.8.5
* 버그 수정및 코드 안정화

## v3.7.0
* 인앱브라우저 UI 및 기능 개선
* 버그 수정및 코드 안정화
* 최소 지원 버전 iOS 12.0으로 상향

## v3.6.2
* Xcode 12.2 대응 (Swift 5.3.1)

## v3.5.3
* Xcode 12.0 대응 (Swift 5.3)
* iOS14 IDFA 식별자값 관련 대응

## v3.4.2
* AdFitBannerAdView 인스턴스를 사이즈 없이 생성할 경우 크래쉬 나는 현상 수정 

## v3.4.1
* 3.4.0 버전의 임포트 이슈 수정 

## v3.4.0
* 네이티브 광고 베타 버전 (정식으로 공개 후 사용가능)
* 최소 지원 버전 11.0으로 상향

## v3.0.11
* 버그 수정및 코드 안정화 

## v3.0.10
* Xcode 11.4 대응 (Swift 5.2)

## v3.0.9
* Xcode 11.2 대응 (Swift 5.1.2)
* 광고 클릭시 랜딩 브라우저의 modalPresentationStyle을 
`.fullscreen`으로 변경

## v3.0.8
* Xcode 11.0 대응 (Swift 5.1)

## v3.0.7
* Xcode 10.2 대응 (Swift 5.0)

## v3.0.6
* 안정성 향상 
* Bug Fix 

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
