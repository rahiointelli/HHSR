//
//  TblRoomSelectionCell.swift
//  DiningApp
//
//  Created by Intelli on 2022-10-31.
//

import UIKit

class TblFormTxtFieldCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtData: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
