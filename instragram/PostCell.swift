//
//  PostCell.swift
//  instragram
//
//  Created by Felipe De La Torre on 10/19/18.
//  Copyright © 2018 Felipe De La Torre. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postCommentLabel: UILabel!
    var indexPath : IndexPath?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
