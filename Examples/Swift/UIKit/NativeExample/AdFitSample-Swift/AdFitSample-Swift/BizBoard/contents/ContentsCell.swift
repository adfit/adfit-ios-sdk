//
//  ContentsCell.swift
//  AdFitSample-Swift
//
//  Created by KAKAO on 2022/07/01.
//  Copyright © 2022 KAKAO. All rights reserved.
//

import UIKit

class ContentsCell: UITableViewCell {
    
    @IBOutlet weak var descLabel: UILabel?
    @IBOutlet weak var authorLabel: UILabel?
    @IBOutlet weak var dateLabel: UILabel?
    
    var message: Message? {
        didSet(newValue) {
            setNeedsLayout()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    override func layoutSubviews() {
        if let message = message {
            descLabel?.text = message.message
            authorLabel?.text = message.author
            dateLabel?.text = message.date
        }
        
        super.layoutSubviews()
    }
    
}
