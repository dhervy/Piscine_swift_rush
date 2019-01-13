//
//  ResponseTableViewCell.swift
//  rush
//
//  Created by Duane HERVY on 1/13/19.
//  Copyright © 2019 Duane HERVY. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    var message: Message? {
        didSet {
            if let mes = message {
                nameLabel?.text = mes.name
                dateLabel?.text = mes.date
                messageLabel?.text = mes.message
            }
        }
    }
    
    var countResponse: Int? {
        didSet {
            if let count = countResponse {
                if count > 0 {
                    countLabel?.text = String(count)
                } else {
                    countLabel?.text = "0"
                    countLabel?.isHidden = true
                }
            }
        }
    }
}
