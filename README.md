# 중요 공지 사항
> 2025년 배포되는 SDK부터 CocoaPods의 지원을 중단 합니다.

> 2025년 이후 iOS 최소 지원 버전을 15.0 으로 상향 예정입니다.


# AdFit iOS SDK

> AdFit SDK 3.18.6 버전부터, iOS 최소 지원 버전이 15.0으로 상향되었습니다.

> AdFit SDK 3.14.7 버전부터, iOS 최소 지원 버전이 14.0으로 상향되었습니다.

> AdFit SDK 3.14.7 버전부터 Swift 5.9(xcode 15)를 지원하며, xcode 15를 이용하시길 바랍니다.

> AdFit SDK 3.12.19 버전부터 Cocoapod 으로 제공되는 프레임워크 형태가 xcframework로 변경되었습니다.  

> AdFit SDK 3.12.18 버전부터 iOS 최소 지원 버전이 13.0으로 상향 되었습니다. 13.0 미만의 iOS 버전을
지원해야 한다면 3.12.7 버전 사용을 부탁드립니다. 

> AdFit SDK 3.11.1 버전부터 swift5.5(xcode 13)를 지원하며, xcode13을 이용하시길 바랍니다. 

> 이 가이드는 iOS Application 에 모바일 광고를 노출하기 위한 광고 데이터요청과 처리 방법을 설명합니다.<br>
사이트/앱 운영정책에 어긋나는 경우 적립금 지급이 거절 될 수 있으니 유의하시기 바랍니다.

> SPM 을 지원 합니다. 레포지토리 주소는 다음과 같습니다.<br> (https://github.com/adfit/adfit-spm.git)

## 지원
* SDK 연동 가이드 [Guide](http://adfit.github.io/adfit-ios-sdk/documentation/adfitsdk)
* 문의 고객센터 [https://cs.kakao.com/helps?service=160&locale=ko](https://cs.kakao.com/helps?service=160&locale=ko)
* 사이트/앱 운영 정책 [https://adfit.kakao.com/web/html/use_kakao.html](https://adfit.kakao.com/web/html/use_kakao.html )

## First Party API 사용 사유 명시
* 애플 공식 문서 [https://developer.apple.com/kr/news/?id=z6fu1dcu&mibextid=S66gvF](https://developer.apple.com/kr/news/?id=z6fu1dcu&mibextid=S66gvF)

## iOS14 개인정보 보호 정책 안내사항
* 12월 8일 이후에 신규, 업데이트 되는 앱들은 해당 사항을 모두 기재해야 합니다. ([App Store Connect에서 사용할 수 있는 앱 개인정보 보호에 관한 질문](https://developer.apple.com/kr/news/?id=vlj9jty9))
* [AdFit 개인정보 보호정책 안내사항](https://github.com/adfit/adfit-ios-sdk/wiki/iOS14-%EA%B0%9C%EC%9D%B8%EC%A0%95%EB%B3%B4-%EB%B3%B4%ED%98%B8-%EB%B0%8F-%EB%8D%B0%EC%9D%B4%ED%84%B0-%EC%82%AC%EC%9A%A9-%EC%A0%95%EC%B1%85-%EC%97%85%EB%8D%B0%EC%9D%B4%ED%8A%B8%EC%97%90-%EB%94%B0%EB%A5%B8-%EB%A7%A4%EC%B2%B4-%EC%95%88%EB%82%B4%EC%82%AC%ED%95%AD) 필독을 권합니다.

이 문서는 Kakao 신디케이션 제휴 당사자에 한해 제공되는 자료로 가이드 라인을 포함한 모든 자료의 지적재산권은 주식회사 카카오가 보유합니다.

Copyright © Kakao Corp. All Rights Reserved.

## License

This software is licensed under the [Apache 2 license](LICENSE), quoted below.

Copyright 2023 Kakao Corp. <http://www.kakaocorp.com>

Licensed under the Apache License, Version 2.0 (the "License"); you may not
use this project except in compliance with the License. You may obtain a copy
of the License at http://www.apache.org/licenses/LICENSE-2.0.

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
License for the specific language governing permissions and limitations under
the License.
