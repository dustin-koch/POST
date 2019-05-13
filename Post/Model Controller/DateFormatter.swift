//
//  DateFormatter.swift
//  Post
//
//  Created by Dustin Koch on 5/13/19.
//  Copyright © 2019 Rabbit Hole Fashion. All rights reserved.
//

import Foundation

extension Date {
    func stringValue() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        
        return formatter.string(from: self)
    }
}
