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
    
    //TODO: Info.plist에 Privacy - Tracking Usage Description 반드시 확인하세요.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bannerAdView = AdFitBannerAdView(clientId: "광고단위를 입력해 주세요.", adUnitSize: "320x50")
        bannerAdView.rootViewController = self
        bannerAdView.delegate = self
        
        bannerAdView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerAdView)
        NSLayoutConstraint.activate([
            bannerAdView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bannerAdView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bannerAdView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bannerAdView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
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

