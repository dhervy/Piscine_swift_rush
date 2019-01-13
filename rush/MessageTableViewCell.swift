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
    
    var message: Message? {
        didSet {
            if let mes = message {
                nameLabel?.text = mes.name
                dateLabel?.text = mes.date
                messageLabel?.text = mes.message
            }
        }
    }

}
