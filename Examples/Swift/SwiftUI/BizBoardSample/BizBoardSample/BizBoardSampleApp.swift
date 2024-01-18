//
//  BizBoardSampleApp.swift
//  BizBoardSample
//
//  Created by kakao on 2024/01/18.
//

import SwiftUI
import AppTrackingTransparency

@main
struct BizBoardSampleApp: App {
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onChange(of: scenePhase, perform: { value in
                    if value == .active {
                        requestTrackingAuthorization()
                    }
                })
        }
    }
    
    // TODO: Info.plist에 Privacy - Tracking Usage Description 입력해주세요.
    private func requestTrackingAuthorization() {
        Task {
            _ = await ATTrackingManager.requestTrackingAuthorization()
            print("ATT 요청이 완료되었습니다.")
        }
    }
}
