//
//  ComicBookTableViewCell.swift
//  MarvelApp
//
//  Created by Bartłomiej Smektała on 09/01/2020.
//  Copyright © 2020 Bartłomiej Smektała. All rights reserved.
//

import UIKit

class ComicBookTableViewCell: UITableViewCell {
    
    @IBOutlet weak var comicThumbnail: UIImageView!
    @IBOutlet weak var comicTitle: UILabel!
    @IBOutlet weak var comicDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    func setupCell(model: ComicBookModel) {
        
    }

}
