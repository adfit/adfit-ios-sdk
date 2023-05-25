//
//  CellTypeController.swift
//  BizBoardSample
//
//  Created by kyle on 2022/11/22.
//

import Foundation
import AdFitSDK

class CellTypeController: UIViewController, UITableViewDataSource, UITableViewDelegate, AdFitNativeAdLoaderDelegate, AdFitNativeAdDelegate {
    
    private let adCellName = "BizBoardListFeedAdTableViewCell"

    private var isAdHidden = true
    
    let tableView = UITableView(frame: .zero, style: .grouped)
    
    var nativeAd: AdFitNativeAd?
    var nativeAdLoader: AdFitNativeAdLoader?
    
    //광고셀의 높이는 기기에 따라서 항상 고정이 되도록 설정 한다.
    var adViewHeight: CGFloat {
        let deviceWidth = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height) // 디바이스 너비
        
        //비즈보드셀 전역 커스텀 설정
        //BizBoardCell.defaultEdgeInset.left = 16
        //BizBoardCell.defaultEdgeInset.right = 16
        //BizBoardCell.defaultEdgeInset.top = 16
        //BizBoardCell.defaultEdgeInset.bottom = 16
        
        // 뷰타입과 다르게 셀타입에서는 비즈보드 개별 여백 설정이 아닌 기본 여백 설정값을 이용하였다.
        let leftRightMargin = BizBoardCell.defaultEdgeInset.left + BizBoardCell.defaultEdgeInset.right // 비즈보드 좌우 마진의 합
        let topBottomMargin = BizBoardCell.defaultEdgeInset.top + BizBoardCell.defaultEdgeInset.bottom // 비즈보드 상하 마진의 합
        let bizBoardWidth = deviceWidth - leftRightMargin // 뷰의 실제 너비에서 좌우 마진값을 빼주면 비즈보드 너비가 나온다.
        let bizBoardRatio = 1029.0 / 222.0 // 비즈보드 이미지의 비율
        let bizBoardHeight: CGFloat = bizBoardWidth / bizBoardRatio // 비즈보드 너비에서 비율값을 나눠주면 비즈보드 높이를 계산 할 수 있다.
        let cellHeight = bizBoardHeight + topBottomMargin // 비즈보드 높이에서 상하 마진값을 더해주면 실제 그려줄 뷰의 높이를 알 수 있다.
        
        return cellHeight
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        edgesForExtendedLayout = []
        
        tableView.register(BizBoardCell.self, forCellReuseIdentifier: adCellName)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = .clear
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.backgroundColor = .white
        view.addSubview(tableView)
            
        nativeAdLoader = AdFitNativeAdLoader(clientId: "광고단위를 입력 해주세요.")
        nativeAdLoader?.delegate = self
        nativeAdLoader?.loadAd()
    }
            
    // MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isAdHidden ? 0 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: adCellName, for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? BizBoardCell {
            //cell.bgViewleftMargin = 16
            //cell.bgViewRightMargin = 16
            //cell.bgViewTopMargin = 0
            //cell.bgViewBottomMargin = 8
            
            if let nativeAd = nativeAd {
                //인포아이콘 조정은 바인드 전에 이뤄줘야 한다. 
                nativeAd.infoIconRightConstant = -20 // 좌로 20 이동
                nativeAd.infoIconTopConstant = 5    // 아래로 5
                nativeAd.bind(cell)
                nativeAd.delegate = self
            }
        }
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return adViewHeight
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return adViewHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
        
    // MARK: - AdFitNativeAdLoaderDelegate
    func nativeAdLoaderDidReceiveAd(_ nativeAd: AdFitNativeAd) {
        self.nativeAd = nativeAd
        self.isAdHidden = false

        tableView.reloadData()
        
    }
    
    func nativeAdLoaderDidFailToReceiveAd(_ nativeAdLoader: AdFitNativeAdLoader, error: Error) {
        
        self.isAdHidden = true
        
        tableView.reloadData()
        
        print("didFailToReceiveAd, error: \(error) (\(error.localizedDescription))")
    }
    
    // MARK: - AdFitNativeAdDelegate
    func nativeAdDidClickAd(_ nativeAd: AdFitNativeAd) {
        print("didClickAd")
    }
    
}
