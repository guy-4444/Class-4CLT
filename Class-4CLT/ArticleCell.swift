//
//  ArticleCell.swift
//  Class-4CLT
//
//  Created by Guy Macin on 09/05/2021.
//

import UIKit

class ArticleCell: UITableViewCell {

    
    @IBOutlet weak var article_IMG_image: UIImageView!
    @IBOutlet weak var article_LBL_title: UILabel!
    @IBOutlet weak var article_LBL_content: UILabel!
    @IBOutlet weak var article_LBL_date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
