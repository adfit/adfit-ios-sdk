//
//  ViewController.swift
//  BannerExample
//
//  Created by KAKAO on 2017. 10. 26..
//  Copyright © 2017년 Kakao Corp. All rights reserved.
//

import UIKit
import AdFitSDK
import AppTrackingTransparency

class ViewController: UIViewController, AdFitBannerAdViewDelegate {

    var bannerAdView: AdFitBannerAdView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bannerAdView = AdFitBannerAdView(clientId: "Input Yout Client ID", adUnitSize: "320x50")
        bannerAdView.rootViewController = self
        bannerAdView.delegate = self
        bannerAdView.frame = view.bounds.divided(atDistance: 50, from: .maxYEdge).slice
        bannerAdView.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        view.addSubview(bannerAdView)
        loadAd()
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
    
    private func loadAd() {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { [weak self] status in
                self?.bannerAdView.loadAd()
            }
        } else {
            self.bannerAdView.loadAd()
        }
    }
}

