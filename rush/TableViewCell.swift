//
//  TableViewCell.swift
//  rush
//
//  Created by Duane HERVY on 1/13/19.
//  Copyright © 2019 Duane HERVY. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var topicLabel: UILabel!
    
    var topic: Topic? {
        didSet {
            if let to = topic {
                nameLabel?.text = to.name
                dateLabel?.text = to.date
                topicLabel?.text = to.topic
            }
        }
    }
    
}


