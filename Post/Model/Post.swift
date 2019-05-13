//
//  Post.swift
//  Post
//
//  Created by Dustin Koch on 5/13/19.
//  Copyright © 2019 Rabbit Hole Fashion. All rights reserved.
//

import Foundation


class Post: Codable {
    
    let text: String
    let timestamp: TimeInterval
    let username: String
    
    init(text: String, timestamp: TimeInterval = Date().timeIntervalSince1970, username: String){
        self.text = text
        self.timestamp = timestamp
        self.username = username
    }
}//END OF CLASS
