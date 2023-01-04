//
//  NativeAdVCRepresentable.swift
//  AdFitSample-Swift
//
//  Created by KAKAO on 2020/05/16.
//  Copyright © 2020 KAKAO. All rights reserved.
//

import UIKit
import SwiftUI

struct NativeAdVCRepresentable : UIViewControllerRepresentable {
    
    typealias UIViewControllerType = NativeAdViewController
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<NativeAdVCRepresentable>) -> NativeAdViewController {
        return NativeAdViewController()
    }
    
    func updateUIViewController(_ uiViewController: NativeAdViewController, context: UIViewControllerRepresentableContext<NativeAdVCRepresentable>) {
    }
}
