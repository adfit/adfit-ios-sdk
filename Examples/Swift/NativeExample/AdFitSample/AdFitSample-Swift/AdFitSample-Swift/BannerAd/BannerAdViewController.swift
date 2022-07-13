//
//  BannerAdViewController.swift
//  AdFitSample-Swift
//
//  Created by aiden.gil on 05/02/2018.
//  Copyright © 2018 Kakao Corp. All rights reserved.
//

import UIKit
import AdFitSDK

class BannerAdViewController: UIViewController, AdFitBannerAdViewDelegate {

    let messageLabel = UILabel(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        edgesForExtendedLayout = []
        
        let bannerAdView = AdFitBannerAdView(clientId: "INPUT YOUR AdUnit ID", adUnitSize: "320x50")
        bannerAdView.frame = view.bounds.divided(atDistance: 50, from: .minYEdge).slice
        bannerAdView.autoresizingMask = [.flexibleWidth]
        bannerAdView.delegate = self
        bannerAdView.backgroundColor = .white
        view.addSubview(bannerAdView)
        bannerAdView.loadAd()
        
        messageLabel.frame = view.bounds.divided(atDistance: 50, from: .minYEdge).slice.offsetBy(dx: 0, dy: 50).insetBy(dx: 10, dy: 0)
        messageLabel.numberOfLines = 2
        view.addSubview(messageLabel)
    }
    
    // MARK: - AdFitBannerAdViewDelegate
    func adViewDidReceiveAd(_ bannerAdView: AdFitBannerAdView) {
        let message = "delegate: adViewDidReceiveAd"
        messageLabel.text = message
        print(message)
    }
    
    func adViewDidFailToReceiveAd(_ bannerAdView: AdFitBannerAdView, error: Error) {
        let message = "delegate: adViewDidFailToReceiveAd, error: \(error.localizedDescription)"
        messageLabel.text = message
        print(message)
    }
    
    func adViewDidClickAd(_ bannerAdView: AdFitBannerAdView) {
        let message = "delegate: adViewDidClickAd"
        messageLabel.text = message
        print(message)
    }

}
