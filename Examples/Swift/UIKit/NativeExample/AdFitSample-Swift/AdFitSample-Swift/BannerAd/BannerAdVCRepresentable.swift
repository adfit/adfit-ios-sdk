//
//  BannerAdVCRepresentable.swift
//  AdFitSample-Swift
//
//  Created by KAKAO on 2020/05/16.
//  Copyright © 2020 KAKAO. All rights reserved.
//

import UIKit
import SwiftUI

struct BannerAdVCRepresentable : UIViewControllerRepresentable {
    
    typealias UIViewControllerType = BannerAdViewController
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<BannerAdVCRepresentable>) -> BannerAdViewController {
        return BannerAdViewController()
    }
    
    func updateUIViewController(_ uiViewController: BannerAdViewController, context: UIViewControllerRepresentableContext<BannerAdVCRepresentable>) {
    }
}
