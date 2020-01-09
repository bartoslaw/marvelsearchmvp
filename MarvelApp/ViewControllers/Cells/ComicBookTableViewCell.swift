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
        guard
            let path = model.thumbnail?.path,
            let type = model.thumbnail?.type,
            let title = model.title,
            let description = model.comicDescription
        else { return }
        
        self.comicThumbnail.sd_setImage(with: URL(string: "\(path).\(type)"), completed: nil)
        self.comicTitle.text = title
        self.comicDescription.text = description
    }

}
