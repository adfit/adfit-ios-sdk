//
//  ContentView.swift
//  AdFitSample-Swift
//
//  Created by KAKAO on 2020/05/15.
//  Copyright © 2020 KAKAO. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
             Text("AdFit Sample")
                .tabItem {
                    Image(systemName: "1.circle")
                    Text("Home")
                }
             NativeAdVCRepresentable()
                .tabItem {
                    Image(systemName: "2.circle")
                    Text("네이티브 광고")
                }
             BannerAdVCRepresentable()
                .tabItem {
                    Image(systemName: "3.circle")
                    Text("배너 광고")
                }
            BizBoardViewTypeVCRepresentable()
               .tabItem {
                   Image(systemName: "4.circle")
                   Text("비즈보드 뷰타입")
               }
            BizBoardCellTypeVCRepresentable()
               .tabItem {
                   Image(systemName: "5.circle")
                   Text("비즈보드 셀타입")
               }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
