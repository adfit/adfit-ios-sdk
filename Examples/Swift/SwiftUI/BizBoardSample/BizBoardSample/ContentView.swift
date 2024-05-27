//
//  ContentView.swift
//  BizBoardSample
//
//  Created by kakao on 5/27/24.
//

import SwiftUI
import AdFitSDK

struct ContentView: View {
    @State var refresh: Bool = false
    
    var body: some View {
        VStack {
            Text("비즈보드 광고를 노출합니다.")
            
            Spacer()
            
            BizBoardTemplatePresentableView(
                clientId: "광고단위를 입력해 주세요.",
                refresh: $refresh
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
            .onAppear {
                refresh = false
            }
            .onDisappear {
                refresh = true
            }
        }
    }
}

#Preview {
    ContentView()
}
