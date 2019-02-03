//
//  EntryTableViewCell.swift
//  RxReader
//
//  Created by 玉置 on 2019/02/03.
//  Copyright © 2019 Tamaoki. All rights reserved.
//

import UIKit

class EntryTableViewCell: UITableViewCell {
    
    @IBOutlet weak private var blogTitleLabel: UILabel!
    @IBOutlet weak private var publishedLabel: UILabel!
    var urlString: String?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(entry: Entry) {
        blogTitleLabel.text = entry.title
        publishedLabel.text = entry.published
        urlString = entry.linkUrl
    }
    
}
