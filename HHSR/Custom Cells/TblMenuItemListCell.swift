//
//  SearchStoreListTblCell.swift
//  Richmond Sentinel
//
//  Created by Intelli on 2019-01-21.
//  Copyright © 2019 Intelli. All rights reserved.
//

import UIKit

class TblMenuItemListCell: UITableViewCell {

    @IBOutlet weak var lblChineseName: UILabel!
    @IBOutlet weak var imgItemImage: UIImageView!
    @IBOutlet weak var lblItemName: UILabel!
    @IBOutlet weak var txt_comment: UITextField!
    @IBOutlet weak var vw_seperator: UILabel!
    @IBOutlet weak var vw_container: UIView!
    @IBOutlet weak var lbl_quantity: UILabel!
    @IBOutlet weak var btn_plus: UIButton!
    @IBOutlet weak var btn_minus: UIButton!
    @IBOutlet weak var cns_Container_height: NSLayoutConstraint!
    @IBOutlet weak var vw_main_Container: UIView!
    @IBOutlet weak var cns_main_Container_top: NSLayoutConstraint!
    @IBOutlet weak var cns_main_Container_bottom: NSLayoutConstraint!
    @IBOutlet weak var cns_stack_inner_width: NSLayoutConstraint!
    @IBOutlet weak var cns_vwSeperateor_height: NSLayoutConstraint!
    @IBOutlet weak var cns_img_width: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //self.vw_seperator.backgroundColor = UIColor.gray
//self.imgItemImage.layer.cornerRadius = 10
        //self.imgItemImage.layer.borderColor = UIColor.gray.cgColor
        //self.imgItemImage.layer.borderWidth = 1
            //.ColorCodes.NewsSeperator
        // Initialization code
        
        if(UIDevice.current.userInterfaceIdiom == .pad)
        {
            self.cns_Container_height.constant =  38.0
            self.cns_stack_inner_width.constant = 32.0
            self.vw_container.layer.cornerRadius = 18.0
            self.cns_img_width.constant = (UIScreen.main.bounds.size.width * 35.0) / 160.0
        }
        else
        {
            self.cns_Container_height.constant = 28.0
            self.cns_img_width.constant = (UIScreen.main.bounds.size.width * 41.0) / 160.0
        }
        
        if(AppDelegate.sharedDelegate().UserRole == "kitchen")
        {
            //self.cns_stack_inner_width.constant = 0
            self.btn_plus.isHidden = true
            self.btn_minus.isHidden = true
            self.vw_container.backgroundColor = .clear
        }
                
//        self.vw_container.layer.cornerRadius = 3
//        self.vw_container.layer.borderColor = UIColor.gray.cgColor
//        self.vw_container.layer.borderWidth = 1
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
