//
//  BizBoardViewTypeVCRepresentable.swift
//  AdFitSample-Swift
//
//  Created by KAKAO on 2022/07/01.
//  Copyright © 2022 KAKAO. All rights reserved.
//

import UIKit
import SwiftUI

struct BizBoardViewTypeVCRepresentable : UIViewControllerRepresentable {
    
    typealias UIViewControllerType = BizBoardViewTypeViewController
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<BizBoardViewTypeVCRepresentable>) -> BizBoardViewTypeViewController {
        return BizBoardViewTypeViewController()
    }
    
    func updateUIViewController(_ uiViewController: BizBoardViewTypeViewController, context: UIViewControllerRepresentableContext<BizBoardViewTypeVCRepresentable>) {
    }
}
