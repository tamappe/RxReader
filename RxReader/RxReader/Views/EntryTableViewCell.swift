//
//  EntryTableViewCell.swift
//  RxReader
//
//  Created by 玉置 on 2019/02/03.
//  Copyright © 2019 Tamaoki. All rights reserved.
//

import UIKit
import Nuke

class EntryTableViewCell: UITableViewCell {
    
    @IBOutlet weak private var blogTitleLabel: UILabel!
    @IBOutlet weak private var siteTitleLabel: UILabel!
    @IBOutlet weak private var thumbnailImageView: UIImageView!

    var urlString: String?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        backgroundColor = UIColor.white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(entry: Entry, row: Int) {
        blogTitleLabel.text = entry.title
        siteTitleLabel.text = entry.blogTitle
        urlString = entry.linkUrl

        guard let url = URL(string: entry.imageUrl ?? "") else { return }
        Nuke.loadImage(with: url, into: thumbnailImageView)
    }
    
}
