//
//  ComicBookTableViewCell.swift
//  MarvelApp
//
//  Created by Bartłomiej Smektała on 09/01/2020.
//  Copyright © 2020 Bartłomiej Smektała. All rights reserved.
//

import UIKit
import SDWebImage

class ComicBookTableViewCell: UITableViewCell {
    @IBOutlet weak var comicThumbnail: UIImageView!
    @IBOutlet weak var comicTitle: UILabel!
    @IBOutlet weak var comicDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    func setupCell(model: ComicBookModel) {
        if let path = model.thumbnail?.path, let type = model.thumbnail?.type {
            self.comicThumbnail.sd_setImage(with: URL(string: "\(path).\(type)")) { (image, error, cacheType, url) in }
        } else {
            self.comicThumbnail.image = UIImage(named: "placeholder")
        }
        
        if let title = model.title {
            self.comicTitle.text = title
        } else {
            self.comicTitle.text = ""
        }
        
        if let description = model.comicDescription {
            self.comicDescription.text = description
        } else {
            self.comicDescription.text = ""
        }
    }

}
