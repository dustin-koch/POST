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
    let timestamp: String
    let username: String
    
    init(text: String, timestamp: String, username: String){
        self.text = text
        self.timestamp = timestamp
        self.username = username
    }
}//END OF CLASS
