//
//  MediaAttachmentListTblCell.swift
//  iTask
//
//  Created by Intelli on 2019-12-09.
//  Copyright © 2019 Intelli. All rights reserved.
//

import UIKit

class MediaAttachmentListTblCell: UICollectionViewCell {

    @IBOutlet weak var imgMedia: UIImageView!
    @IBOutlet weak var imgVideoIcon: UIImageView!
    @IBOutlet weak var btn_remove: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.imgMedia.layer.cornerRadius = 5
        self.imgMedia.layer.borderWidth = 1
        self.imgMedia.layer.borderColor = UIColor.ColorCodes.txtaddTaskColor.cgColor
        // Initialization code
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
}
