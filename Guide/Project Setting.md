# 프로젝트 설정

## 1. iOS 9 ATS(App Transport Security) 처리
iOS 9부터 [ATS(App Transport Security)](https://developer.apple.com/library/prerelease/ios/technotes/App-Transport-Security-Technote/) 기능이 기본적으로 활성화 되어 있으며, 암호화된 HTTPS 방식의 통신만 허용됩니다.<br>
AdFit SDK는 ATS 활성화 상태에서도 정상적으로 동작하도록 구현되어 있으나, 광고를 통해 노출되는 광고주 페이지는 HTTPS 방식을 지원하지 않을 수도 있습니다.<br>
따라서 아래의 사항을 앱 프로젝트의 Info.plist 파일에 적용하여 주시기 바랍니다. 

```
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>
```

## 2. Objective-C 프로젝트
AdFit SDK는 Swift 4 기반으로 개발되었습니다. Objective-C 기반의 프로젝트에서 AdFit SDK를 사용하기 위해서는 Swift Standard 라이브러리들을 Embed 시켜주어야 합니다.<br>
앱 프로젝트의 빌드 세팅에서 `Always Embed Swift Standard Libraries` 항목을 `Yes`로 설정해주세요.