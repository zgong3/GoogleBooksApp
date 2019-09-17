//
//  favcell.swift
//  GoogleBookApp
//
//  Created by Consultant on 9/17/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class favcell: UITableViewCell {

    static let identifier = "FavoriteTableCell"
    
    @IBOutlet weak var booktitle: UILabel!
    
    var books: BookModel! {
        didSet {
            booktitle.text = books.title

        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
