//
//  BizBoardViewTypeViewController.swift
//  AdFitSample-Swift
//
//  Created by KAKAO on 2022/07/01.
//  Copyright © 2022 KAKAO. All rights reserved.
//

import UIKit
import AdFitSDK

class BizBoardViewTypeViewController: UIViewController, AdFitNativeAdLoaderDelegate, AdFitNativeAdDelegate {

    let messageLabel = UILabel(frame: .zero)
    
    var nativeAdLoader: AdFitNativeAdLoader?
    var nativeAd: AdFitNativeAd?

    lazy var nativeAdView = BizBoardTemplate()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .lightGray
        
        // 스태틱 커스텀
        //BizBoardTemplate.backgroundColor = .yellow
        //BizBoardTemplate.defaultEdgeInset = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        
        view.addSubview(nativeAdView)
        
        let width = view.frame.width
        let height = (view.frame.width - BizBoardTemplate.defaultEdgeInset.left + BizBoardTemplate.defaultEdgeInset.right) / (1029 / 222) + BizBoardTemplate.defaultEdgeInset.top + BizBoardTemplate.defaultEdgeInset.bottom

        nativeAdView.frame.size = CGSize(width: width, height: height)
        
        //인스턴스 커스텀
        //nativeAdView.bgViewColor = .yellow
        //nativeAdView.bgViewleftMargin = 56
        //nativeAdView.bgViewRightMargin = 16
        //nativeAdView.bgViewTopMargin = 10
        //nativeAdView.bgViewBottomMargin = 10
        
        nativeAdLoader = AdFitNativeAdLoader(clientId: bizBoardAdUnitId)
        nativeAdLoader?.delegate = self
        
        nativeAdLoader?.loadAd()
        
        messageLabel.frame = view.bounds.divided(atDistance: 50, from: .minYEdge).remainder.insetBy(dx: 10, dy: 0)
        messageLabel.numberOfLines = 3
        view.addSubview(messageLabel)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        nativeAdLoader?.delegate = nil
        nativeAdLoader = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if nativeAdLoader == nil {
            nativeAdLoader = AdFitNativeAdLoader(clientId: bizBoardAdUnitId)
            nativeAdLoader?.delegate = self
            
            nativeAdLoader?.loadAd()
        }
    }
    
    // MARK: - AdFitNativeAdLoaderDelegate
    func nativeAdLoaderDidReceiveAds(_ nativeAds: [AdFitNativeAd]) {
        
        nativeAdView.isHidden = false
        guard let ad = nativeAds.first else {
            return
        }
        self.nativeAd = ad
        bindAdView(nativeAdView: nativeAdView)
        
        let message = "delegate: nativeAdLoaderDidReceiveAds"
        messageLabel.text = message
        print(message)
    }
    
    func nativeAdLoaderDidFailToReceiveAd(_ nativeAdLoader: AdFitNativeAdLoader, error: Error) {
        
        nativeAdView.isHidden = true
        
        let message = "delegate: didFailToReceiveAd \(error) (\(error.localizedDescription))"
        messageLabel.text = message
        print(message)
    }
        
    // MARK: - AdFitNativeAdDelegate
    func nativeAdDidClickAd(_ nativeAd: AdFitNativeAd) {
        let message = "delegate: didClickAd"
        messageLabel.text = message
        print(message)
    }
    
    private func bindAdView(nativeAdView: UIView) {
        guard let nativeAdView = nativeAdView as? (UIView & AdFitNativeAdRenderable) else {
            return
        }
                
        if let nativeAd = self.nativeAd {
            nativeAd.bind(nativeAdView)
            nativeAd.delegate = self
            nativeAdView.autoresizingMask = [.flexibleWidth]
        }
    }
}

