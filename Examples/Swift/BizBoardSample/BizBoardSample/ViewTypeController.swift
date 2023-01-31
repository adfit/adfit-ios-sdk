//
//  ViewTypeController.swift
//  BizBoardSample
//
//  Created by kyle on 2022/11/22.
//

import Foundation
import AdFitSDK

class ViewTypeController: UIViewController, AdFitNativeAdLoaderDelegate, AdFitNativeAdDelegate {
    
    var nativeAdLoader: AdFitNativeAdLoader?
    var nativeAd: AdFitNativeAd?

    lazy var nativeAdView = BizBoardTemplate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        let topBottomMargin = nativeAdView.bgViewTopMargin + nativeAdView.bgViewBottomMargin // 비즈보드 상하 마진의 합
        let bizBoardWidth = viewWidth - leftRightMargin // 뷰의 실제 너비에서 좌우 마진값을 빼주면 비즈보드 너비가 나온다.
        let bizBoardRatio = 1029.0 / 222.0 // 비즈보드 이미지의 비율
        let bizBoardHeight = bizBoardWidth / bizBoardRatio // 비즈보드 너비에서 비율값을 나눠주면 비즈보드 높이를 계산 할 수 있다.
        let viewHeight = bizBoardHeight + topBottomMargin // 비즈보드 높이에서 상하 마진값을 더해주면 실제 그려줄 뷰의 높이를 알 수 있다.
        
        nativeAdView.frame.size = CGSize(width: viewWidth, height: viewHeight)
        
        nativeAdLoader = AdFitNativeAdLoader(clientId: "광고단위를 입력 해주세요.")
        nativeAdLoader?.delegate = self
        nativeAdLoader?.loadAd()
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        
        nativeAdView.frame.origin = view.safeAreaLayoutGuide.layoutFrame.origin
    }
    
    // MARK: - AdFitNativeAdLoaderDelegate
    func nativeAdLoaderDidReceiveAd(_ nativeAd: AdFitNativeAd) {
        self.nativeAd = nativeAd
        bindAdView(nativeAdView: nativeAdView)
        
        print("didReceiveAd")
    }

    func nativeAdLoaderDidFailToReceiveAd(_ nativeAdLoader: AdFitNativeAdLoader, error: Error) {
        
        nativeAdView.isHidden = true
        
        print("didFailToReceiveAd, error: \(error) (\(error.localizedDescription))")
    }
        
    // MARK: - AdFitNativeAdDelegate
    func nativeAdDidClickAd(_ nativeAd: AdFitNativeAd) {
        print("didClickAd")
    }
    
    private func bindAdView(nativeAdView: UIView) {
        guard let nativeAdView = nativeAdView as? (UIView & AdFitNativeAdRenderable) else {
            return
        }
                
        if let nativeAd = self.nativeAd {
            //인포아이콘 조정은 바인드 전에 이뤄줘야 한다.
            nativeAd.infoIconRightConstant = -20 // 좌로 20 이동
            nativeAd.infoIconTopConstant = 15    // 아래로 15
            nativeAd.bind(nativeAdView)
            nativeAd.delegate = self
            nativeAdView.autoresizingMask = [.flexibleWidth]
        }
    }
    
}
