//
//  NativeAdViewController.swift
//  AdFitSample-Swift
//
//  Created by aiden.gil on 05/02/2018.
//  Copyright © 2018 Kakao Corp. All rights reserved.
//

import UIKit
import AdFitSDK

class NativeAdViewController: UIViewController, AdFitNativeAdDelegate, AdFitNativeAdLoaderDelegate {

    var nativeAd: AdFitNativeAd?
    var nativeAdLoader: AdFitNativeAdLoader?
    var nativeAdView: MyNativeAdView?
    let messageLabel = UILabel(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        edgesForExtendedLayout = []
        
        nativeAdLoader = AdFitNativeAdLoader(clientId: "광고단위를 입력 해주세요.")
        nativeAdLoader?.delegate = self
        nativeAdLoader?.infoIconPosition = .topRight
        nativeAdLoader?.loadAd()
        
        messageLabel.numberOfLines = 2
        view.addSubview(messageLabel)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if let nativeAdView = nativeAdView, let mediaAspectRatio = nativeAd?.mediaAspectRatio, mediaAspectRatio > 0 {
            let screenMinWidth = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
            let mediaHeight = screenMinWidth / mediaAspectRatio
            nativeAdView.frame = view.bounds.divided(atDistance: mediaHeight + 130 , from: .minYEdge).slice
            messageLabel.frame = view.bounds.divided(atDistance: 50, from: .minYEdge).slice
                .offsetBy(dx: 0, dy: nativeAdView.frame.height)
                .insetBy(dx: 10, dy: 0)
        } else {
            messageLabel.frame = view.bounds.divided(atDistance: 50, from: .minYEdge).slice
                .insetBy(dx: 10, dy: 0)
        }
    }
    
    // MARK: - AdFitNativeAdDelegate
    func nativeAdLoaderDidReceiveAd(_ nativeAd: AdFitNativeAd) {
        if let nativeAdView = Bundle.main.loadNibNamed("MyNativeAdView", owner: nil, options: nil)?.first as? MyNativeAdView {
            self.nativeAd = nativeAd
            nativeAdView.backgroundColor = .white
            nativeAd.bind(nativeAdView)
            view.addSubview(nativeAdView)
//            if nativeAd.callToAction != nil {
//                nativeAdView.actionButton?.isHidden = true
//            }
            self.nativeAdView = nativeAdView
        }
        
        let message = "delegate: nativeAdDidReceiveAd"
        messageLabel.text = message
        print(message)
    }

    func nativeAdLoaderDidFailToReceiveAd(_ nativeAdLoader: AdFitNativeAdLoader, error: Error) {
        let message = "delegate: nativeAdLoaderDidFailToReceiveAd, error: \(error.localizedDescription)"
        messageLabel.text = message
        print(message)
    }
    
    func nativeAdDidClickAd(_ nativeAd: AdFitNativeAd) {
        let message = "delegate: nativeAdDidClickAd"
        messageLabel.text = message
        print(message)
    }

}
