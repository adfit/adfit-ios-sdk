//
//  ContentView.swift
//  BannerSample
//
//  Created by kakao on 5/27/24.
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
                clientId: "광고단위를 입력해 주세요.",
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
