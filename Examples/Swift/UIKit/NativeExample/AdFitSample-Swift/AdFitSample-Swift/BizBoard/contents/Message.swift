//
//  Message.swift
//  AdFitSample-Swift
//
//  Created by KAKAO on 2022/07/01.
//  Copyright © 2022 KAKAO. All rights reserved.
//

import Foundation

struct Message {
    
    let author: String
    let date: String
    let message: String
    
    init?(data: [String: String]) {
        guard let author = data["author"] else {
            return nil
        }
                
        guard let date = data["date"] else {
            return nil
        }
        
        guard let message = data["message"] else {
            return nil
        }
        
        self.author = author
        self.date = date
        self.message = message
    }
    
}

