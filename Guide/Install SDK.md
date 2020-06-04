# SDK 설치하기 
## 1. Cocoapods 사용하여 설치
#### 1) 프로젝트의 Podfile 에 pod 추가

```ruby
pod 'AdFitSDK'
```
	
#### 2) 터미널에서 pod install 명령을 실행

## 2. 수동 설치
* AdFitSDK를 [다운로드](https://github.com/adfit/adfit-ios-sdk/archive/master.zip) 받습니다.
* `AdFit.framework` 을 앱 프로젝트의 `General > Embeded Binaries` 항목으로 끌어서 놓습니다.

#### 1) 앱스토어에 앱 업로드 시 **Unsupported Architectures** 에러 발생하는 경우 
AdFit SDK는 개발 편의를 위해 시뮬레이터용 / 실기기용 바이너리가 하나로 합쳐진 fat binary 형태로 제공됩니다.<br>
따라서 AdFit SDK를 수동으로 설치한 경우, 앱스토어에 앱을 업로드 할 때 `Unsupported Architectures` 에러가 발생할 수 있습니다.<br>
이러한 경우 다음의 안내를 따라주세요.

* Xcode에서 앱 프로젝트를 선택하고, `Build Phases` 탭으로 이동합니다.
* 메인 영역 좌측 상단의 `+` 버튼을 클릭 후 `New Run Script Phase` 항목을 선택합니다.
* 추가된 `Run Script` 항목의 입력 폼에 다음 코드를 복사해서 붙여넣습니다.
* `Run Script` 항목은 `Embed Frameworks` 항목 보다 아래에 위치해 있어야 합니다. 항목의 순서는 Drag&Drop 을 통해 변경할 수 있습니다. 
* `Run Script`의 세부 옵션 중 `Run script only when installing` 을 체크할 경우 아카이브 시에만 스크립트가 수행 됩니다. 해당 스크립트는
아카이브시에만 수행되면 되므로 평상시에 Build 시간을 줄일 수 있습니다.

```
bash "${BUILT_PRODUCTS_DIR}/${FRAMEWORKS_FOLDER_PATH}/AdFit.framework/strip-frameworks.sh"
```