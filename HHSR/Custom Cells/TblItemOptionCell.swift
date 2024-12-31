//
//  TblRoomSelectionCell.swift
//  DiningApp
//
//  Created by Intelli on 2022-10-31.
//

import UIKit

class TblItemOptionCell: UITableViewCell {
    
    @IBOutlet weak var lbltext : UILabel!
    @IBOutlet weak var lblquantity: UILabel!
    @IBOutlet weak var btnRadio: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
