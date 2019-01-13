//
//  MessageModel.swift
//  rush
//
//  Created by Duane HERVY on 1/13/19.
//  Copyright © 2019 Duane HERVY. All rights reserved.
//

import Foundation

struct Message {
    var name: String
    var date: String
    var message: String
    var id: Int
    var authorId: Int
    var replies: [NSDictionary]
}
