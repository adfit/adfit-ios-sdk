//
//  ContentView.swift
//  BannerSample
//
//  Created by kakao on 2024/01/18.
//

import SwiftUI
import AdFitSDK

struct ContentView: View {
    @State private var orientation: UIDeviceOrientation = .unknown
    
    var body: some View {
        VStack {
            Text("배너 광고를 노출합니다.")
            
            Spacer()
            
            AdFitBannerPresentableView(
                clientId: "발급받은 광고 단위 ID를 입력해주세요.",
                adUnitSize: "320x50"
            )
            .onDidClickAd { _ in
                print("광고를 클릭했습니다.")
            }
            .onDidReceiveAd { _, error in
                print("광고 응답을 받았습니다.")
                if let error = error {
                    print("광고 응답 에러: \(error)")
                }
            }
            .onSizeThatFits(orientation: $orientation)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
