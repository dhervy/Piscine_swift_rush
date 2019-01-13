//
//  ResponseTableViewCell.swift
//  rush
//
//  Created by Duane HERVY on 1/13/19.
//  Copyright © 2019 Duane HERVY. All rights reserved.
//

import UIKit

class ResponseTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var responseLabel: UILabel!
    
    var response: Response? {
        didSet {
            if let res = response {
                nameLabel?.text = res.name
                dateLabel?.text = res.date
                responseLabel?.text = res.response
            }
        }
    }
}
