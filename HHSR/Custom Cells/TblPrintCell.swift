//
//  TblRoomSelectionCell.swift
//  DiningApp
//
//  Created by Intelli on 2022-10-31.
//

import UIKit

class TblPrintCell: UITableViewCell {
    
    @IBOutlet weak var lblItem: UILabel!
    @IBOutlet weak var lblOption: UILabel!
    @IBOutlet weak var vwDashedLine: UIView!
    @IBOutlet weak var cns_lblItem_Left: NSLayoutConstraint!
    @IBOutlet weak var cns_catTop: NSLayoutConstraint!
    @IBOutlet weak var cns_itemBottom: NSLayoutConstraint!
    @IBOutlet weak var cns_itemTop: NSLayoutConstraint!
    @IBOutlet weak var lblQuantity: UILabel!
    @IBOutlet weak var cns_lblQuantity_Left: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
