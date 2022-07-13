//
//  BizBoardCellTypeVCRepresentable.swift
//  AdFitSample-Swift
//
//  Created by KAKAO on 2022/07/01.
//  Copyright © 2022 KAKAO. All rights reserved.
//

import UIKit
import SwiftUI

struct BizBoardCellTypeVCRepresentable : UIViewControllerRepresentable {
    
    typealias UIViewControllerType = BizBoardCellTypeViewController
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<BizBoardCellTypeVCRepresentable>) -> BizBoardCellTypeViewController {
        return BizBoardCellTypeViewController()
    }
    
    func updateUIViewController(_ uiViewController: BizBoardCellTypeViewController, context: UIViewControllerRepresentableContext<BizBoardCellTypeVCRepresentable>) {
    }
}
