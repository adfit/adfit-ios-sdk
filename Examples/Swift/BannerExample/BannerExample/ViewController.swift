//
//  ViewController.swift
//  BannerExample
//
//  Created by KAKAO on 2017. 10. 26..
//  Copyright © 2017년 Kakao Corp. All rights reserved.
//

import UIKit
import AdFitSDK

class ViewController: UIViewController, AdFitBannerAdViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bannerAdView = AdFitBannerAdView(clientId: "Input Yout Client ID", adUnitSize: "320x50")
        bannerAdView.refreshInterval = 30
        bannerAdView.rootViewController = self
        bannerAdView.delegate = self
        bannerAdView.frame = view.bounds.divided(atDistance: 50, from: .maxYEdge).slice
        bannerAdView.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        view.addSubview(bannerAdView)
        bannerAdView.loadAd()
    }
    
    //Mark - AdFitBannerAdViewDelegate
    func adViewDidReceiveAd(_ bannerAdView: AdFitBannerAdView) {
        print("didReceiveAd")
    }
    
    func adViewDidFailToReceiveAd(_ bannerAdView: AdFitBannerAdView, error: Error) {
        print("didFailToReceive - error :\(error.localizedDescription)" )
    }
    
    func adViewDidClickAd(_ bannerAdView: AdFitBannerAdView) {
        print("didClickAd")
    }
}

