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
        
        view.addSubview(nativeAdView)
        
        //인스턴스 커스텀
        //nativeAdView.bgViewColor = .yellow //배경 색 지정
        //nativeAdView.bgViewleftMargin = 16 //좌측 여백
        //nativeAdView.bgViewRightMargin = 16 //우측 여백
        //nativeAdView.bgViewTopMargin = 10 //상측 여백
        //nativeAdView.bgViewBottomMargin = 10 //하측 여백
        // 여백값의 커스텀은 뷰의 높이 계산전에 세팅되어야 한다.
        
        let viewWidth = view.frame.width // 실제 뷰의 너비
        let leftRightMargin = nativeAdView.bgViewleftMargin + nativeAdView.bgViewRightMargin // 비즈보드 좌우 마진의 합
        let topBottomMargin = nativeAdView.bgViewTopMargin + nativeAdView.bgViewBottomMargin; // 비즈보드 상하 마진의 합
        let bizBoardWidth = viewWidth - leftRightMargin; // 뷰의 실제 너비에서 좌우 마진값을 빼주면 비즈보드 너비가 나온다.
        let bizBoardRatio = 1029.0 / 222.0; // 비즈보드 이미지의 비율
        let bizBoardHeight = bizBoardWidth / bizBoardRatio; // 비즈보드 너비에서 비율값을 나눠주면 비즈보드 높이를 계산 할 수 있다.
        let viewHeight = bizBoardHeight + topBottomMargin; // 비즈보드 높이에서 상하 마진값을 더해주면 실제 그려줄 뷰의 높이를 알 수 있다.
        
        nativeAdView.frame.size = CGSize(width: viewWidth, height: viewHeight)
        
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
            //인포아이콘 조정은 바인드 전에 이뤄줘야 한다.
            nativeAd.infoIconRightConstant = -20 // 좌로 20 이동
            nativeAd.infoIconTopConstant = 5    // 아래로 5
            nativeAd.bind(nativeAdView)
            nativeAd.delegate = self
            nativeAdView.autoresizingMask = [.flexibleWidth]
        }
    }
}

