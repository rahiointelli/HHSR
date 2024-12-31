//
//  TblRoomSelectionCell.swift
//  DiningApp
//
//  Created by Intelli on 2022-10-31.
//

import UIKit

class TblReportForChargesCell: UITableViewCell {
    
    @IBOutlet weak var lblRoomAndResident : UILabel!
    //@IBOutlet weak var lblOrderDate: UILabel!
    @IBOutlet weak var lblChargedFor: UILabel!
    @IBOutlet weak var vwDashedLine: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
