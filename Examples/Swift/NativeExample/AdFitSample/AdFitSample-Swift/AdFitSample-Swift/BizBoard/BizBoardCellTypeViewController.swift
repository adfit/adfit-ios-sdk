//
//  BizBoardCellTypeViewController.swift
//  AdFitSample-Swift
//
//  Created by KAKAO on 2022/07/01.
//  Copyright © 2022 KAKAO. All rights reserved.
//

import UIKit
import AdFitSDK

class BizBoardCellTypeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AdFitNativeAdLoaderDelegate, AdFitNativeAdDelegate {
    
    private let contentCellName = "ContentsCell"
    private let adCellName = "BizBoardTableViewCell"

    private var isAdHidden = true
    
    let tableView = UITableView(frame: .zero, style: .grouped)
    var messages = [Message]()
    
    var nativeAd: AdFitNativeAd?
    var nativeAdLoader: AdFitNativeAdLoader?
    
    //광고셀의 높이는 기기에 따라서 항상 고정이 되도록 설정 한다.
    var adViewHeight: CGFloat {
        let deviceWidth = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
        
        //비즈보드셀 전역 커스텀 설정
        //BizBoardCell.defaultEdgeInset.left = 16
        //BizBoardCell.defaultEdgeInset.right = 16
        //BizBoardCell.defaultEdgeInset.top = 16
        //BizBoardCell.defaultEdgeInset.bottom = 16
        //BizBoardCell.defaultBackgroundColor = .yellow
        
        // 뷰타입과 다르게 셀타입에서는 비즈보드 개별 여백 설정이 아닌 기본 여백 설정값을 이용하였다.
        let leftRightMargin = BizBoardCell.defaultEdgeInset.left + BizBoardCell.defaultEdgeInset.right; // 비즈보드 좌우 마진의 합
        let topBottomMargin = BizBoardCell.defaultEdgeInset.top + BizBoardCell.defaultEdgeInset.bottom; // 비즈보드 상하 마진의 합
        let bizBoardWidth = deviceWidth - leftRightMargin; // 뷰의 실제 너비에서 좌우 마진값을 빼주면 비즈보드 너비가 나온다.
        let bizBoardRatio = 1029.0 / 222.0; // 비즈보드 이미지의 비율
        let bizBoardHeight: CGFloat = bizBoardWidth / bizBoardRatio; // 비즈보드 너비에서 비율값을 나눠주면 비즈보드 높이를 계산 할 수 있다.
        let cellHeight = bizBoardHeight + topBottomMargin; // 비즈보드 높이에서 상하 마진값을 더해주면 실제 그려줄 뷰의 높이를 알 수 있다.
        
        return cellHeight
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        edgesForExtendedLayout = []
        
        tableView.register(UINib(nibName: contentCellName, bundle: nil), forCellReuseIdentifier: contentCellName)
        tableView.register(BizBoardCell.self, forCellReuseIdentifier: adCellName)
        
        //BizBoardCell.defaultBackgroundColor = .yellow
        //BizBoardCell.defaultEdgeInset = UIEdgeInsets(top: 30, left: 20, bottom: 50, right: 20)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = .clear
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.backgroundColor = .white
        view.addSubview(tableView)
        
        DispatchQueue.global().async { [weak self] in
            let json = Contents.messagesData
            if let messages = (json["articles"] as? [[String: String]])?.compactMap({ Message(data: $0) }) {
                DispatchQueue.main.async {
                    self?.messages += messages
                    self?.tableView.reloadData()
                }
            }
        }
    
        nativeAdLoader = AdFitNativeAdLoader(clientId: bizBoardAdUnitId)
        nativeAdLoader?.delegate = self
        nativeAdLoader?.loadAd()
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
        
    func merge(source: [Any], nativeAd: AdFitNativeAd?) -> [Any] {
        var merged = source
        if let ad = nativeAd {
            merged.insert(ad, at: 0)
        }
        return merged
    }
    
    func getModels() -> [Any] {
        return merge(source: messages, nativeAd: nativeAd)
    }
    
    func getNibName(indexPath: IndexPath) -> String {
        if indexPath.row == 0, isAdHidden == false {
            return adCellName
        } else {
            return contentCellName
        }
    }
    
    func getMessage(indexPath: IndexPath) -> Message? {
        return getModels()[indexPath.item] as? Message
    }
    
    func getNativeAd(indexPath: IndexPath) -> AdFitNativeAd? {
        return getModels()[indexPath.item] as? AdFitNativeAd
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        DispatchQueue.main.async { [weak self] in
            self?.tableView.beginUpdates()
            self?.tableView.endUpdates()
        }
    }
    
    func executeRowAction(indexPath: IndexPath) {
        //let article = getMessage(indexPath: indexPath)!
       // let controller = WebViewController(url: article.linkUrl)
       // navigationController?.pushViewController(controller, animated: true)
    }
    
    // MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = messages.count
        if isAdHidden == false {
            count = count + 1
        }
        return count//getModels().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let nibName = getNibName(indexPath: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: nibName, for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? ContentsCell {
            if isAdHidden == false, nativeAd == nil {
                cell.message = getMessage(indexPath: IndexPath(row: indexPath.row - 1, section: 0))
            } else {
                cell.message = getMessage(indexPath: indexPath)
            }
        }
        if let cell = cell as? BizBoardCell {
            //cell.bgViewColor = .yellow
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
        if isAdHidden == false, indexPath.row == 0 {
            return adViewHeight
        } else {
            return 68
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if isAdHidden == false, indexPath.row == 0 {
            return adViewHeight
        } else {
            return 68
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isAdHidden == false, indexPath.row == 0 { // 광고 셀은 클릭시 디셀렉트 액션
            tableView.deselectRow(at: indexPath, animated: false)
        } else {
            executeRowAction(indexPath: indexPath)// 컨텐츠 셀은 클릭시 클릭액션 수행
        }
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        if isAdHidden == false, indexPath.row == 0 { // 광고 셀은 하이라이트 효과를 주지 않는다.
            return false
        } else {
            return true
        }
    }
    
    // MARK: - AdFitNativeAdLoaderDelegate
    func nativeAdLoaderDidReceiveAds(_ nativeAds: [AdFitNativeAd]) {
        guard let ad = nativeAds.first else {
            return
        }
        self.nativeAd = ad
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
