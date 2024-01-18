//
//  ContentView.swift
//  BizBoardSample
//
//  Created by kakao on 2024/01/18.
//

import SwiftUI
import AdFitSDK

struct ContentView: View {
    var body: some View {
        VStack {
            Text("비즈보드 광고를 노출합니다.")
            
            Spacer()
            
            BizBoardTemplatePresentableView(
                clientId: "발급받은 광고 단위 ID를 입력해주세요."
            )
            .onDidReceiveAd { _ in
                print("광고 응답을 받았습니다.")
            }
            .onDidFailToReceiveAd { error in
                print("광고 응답에서 에러가 발생했습니다. error: \(error)")
            }
            .onDidClickAd { _ in
                print("광고를 클릭했습니다.")
            }
            .onSizeThatFits()
        }
    }
}

#Preview {
    ContentView()
}
