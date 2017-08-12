//
//  itemCell.swift
//  DreamListerBetter
//
//  Created by Bhawna Verma on 21/05/1939 Saka.
//  Copyright © 1939 Saka Bhawna Verma. All rights reserved.
//

import UIKit

class itemCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var Price: UILabel!
    @IBOutlet weak var Details: UILabel!
    @IBOutlet weak var thumb: UIImageView!

    func configurecell(item :Item ) {
        title.text = item.title
        Price.text = "\(item.price)"
        Details.text = item.details
        thumb.image = item.toimage?.image as?UIImage
    }
}
