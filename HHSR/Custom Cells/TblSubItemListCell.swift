//
//  TblSubItemListCell.swift
//  Richmond Sentinel
//
//  Created by Intelli on 2019-01-21.
//  Copyright © 2019 Intelli. All rights reserved.
//

import UIKit

protocol HeplerDelegate {
    func EditDict(menuItem: clsMenuItems)
}

class TblSubItemListCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    
    @IBOutlet weak var lblItemName: UILabel!
    @IBOutlet weak var vw_container: UIView!
    @IBOutlet weak var lbl_quantity: UILabel!
    @IBOutlet weak var btn_plus: UIButton!
    @IBOutlet weak var btn_minus: UIButton!
    @IBOutlet weak var cns_Container_height: NSLayoutConstraint!
    @IBOutlet weak var vw_main_Container: UIView!
    @IBOutlet weak var cns_main_Container_top: NSLayoutConstraint!
    @IBOutlet weak var cns_main_Container_bottom: NSLayoutConstraint!
    @IBOutlet weak var cns_labelLeading: NSLayoutConstraint!
    @IBOutlet weak var cns_TitleTop: NSLayoutConstraint!
    @IBOutlet weak var cns_TitleBottom: NSLayoutConstraint!
    @IBOutlet weak var cns_vwSeperateor_height: NSLayoutConstraint!
    @IBOutlet weak var cns_stack_inner_width: NSLayoutConstraint!
    @IBOutlet weak var cns_tbl_height: NSLayoutConstraint!
    @IBOutlet weak var tblOptions: UITableView!
    @IBOutlet weak var lblTitlePref: UILabel!
    @IBOutlet weak var stk_tblContainer: UIStackView!
    @IBOutlet weak var clPrefSelection: UICollectionView!
    @IBOutlet weak var cns_cl_height: NSLayoutConstraint!
    @IBOutlet weak var cns_stk_top: NSLayoutConstraint!
    
    var helperDelegate: HeplerDelegate?
    var model: clsMenuItems?
    var cl_cell_width = 0.0
    var canEdit = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.tblOptions.delegate = self
        self.tblOptions.dataSource = self
        self.clPrefSelection.delegate = self
        self.clPrefSelection.dataSource = self
        self.cl_cell_width = (UIScreen.main.bounds.size.width/2)
        
        self.tblOptions.register(UINib(nibName: "TblItemOptionCell", bundle: nil), forCellReuseIdentifier: "TblItemOptionCell")
        self.clPrefSelection.register(UINib(nibName: "clCellPrefSelection", bundle: nil), forCellWithReuseIdentifier: "clCellPrefSelection")
        self.clPrefSelection.backgroundColor = .white
        
        if(UIDevice.current.userInterfaceIdiom == .pad)
        {
            self.cns_stack_inner_width.constant = 32.0
            self.vw_container.layer.cornerRadius = 18.0
        }
        
        if(AppDelegate.sharedDelegate().UserRole == "kitchen")
        {
            //self.cns_stack_inner_width.constant = 0
            self.btn_plus.isHidden = true
            self.btn_minus.isHidden = true
            self.vw_container.backgroundColor = .clear
        }
        
        self.cns_Container_height.constant = (UIDevice.current.userInterfaceIdiom == .pad) ? 38.0 : 28.0
        //30.0 : 23.0
        
//        self.vw_container.layer.cornerRadius = 3
//        self.vw_container.layer.borderColor = UIColor.gray.cgColor
//        self.vw_container.layer.borderWidth = 1
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(withModel model: clsMenuItems, canEdit : Bool) {
        self.model = model
        self.canEdit = canEdit
        self.lblTitlePref.isHidden = (model.isExpanded == 1 && model.Preferences.count > 0) ? false : true
        self.clPrefSelection.isHidden = self.lblTitlePref.isHidden
        self.tblOptions.isHidden = (model.isExpanded == 1 && model.ItemOptions.count > 0) ? false : true
        self.cns_tbl_height.constant = CGFloat(self.model!.ItemOptions.count) * ((UIDevice.current.userInterfaceIdiom == .pad) ? 40.0 : 35.0)
        if(self.model!.Preferences.count > 0)
        {
            print("pref count is \(model.Preferences.count) and calculated vl is \(Int(self.model!.Preferences.count/2))")
            let val = Int(self.model!.Preferences.count/2)
            var cnt = val
            if ((self.model!.Preferences.count%2) == 0)
            {
            }
            else
            {
                cnt = val + 1
            }
            self.cns_cl_height.constant = (CGFloat(cnt) * 30.0) + (CGFloat(cnt-1) * 10.0)
        }
        else
        {
            self.cns_cl_height.constant = 0
        }
    
        self.clPrefSelection.reloadData()
        
        self.cns_stk_top.constant = (self.tblOptions.isHidden && self.clPrefSelection.isHidden) ? 0 : ((self.tblOptions.isHidden) ? 17 : 8)
        
        self.tblOptions.reloadData()
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 35.0
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model?.ItemOptions.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TblItemOptionCell", for: indexPath) as! TblItemOptionCell
        cell.selectionStyle = .none
        cell.lbltext.text = self.model?.ItemOptions[indexPath.row].Name
        
        if(AppDelegate.sharedDelegate().UserRole == "kitchen")
        {
            cell.btnRadio.isHidden = true
            cell.lblquantity.text = "\(self.model?.ItemOptions[indexPath.row].ItemQuantity ?? 0)"
        }
        else
        {
            cell.btnRadio.tag = indexPath.row
            cell.btnRadio.isSelected = (self.model?.ItemOptions[indexPath.row].IsSelected == 0) ? false : true
            cell.btnRadio.addTarget(self, action: #selector(ChangeSelection), for: .touchUpInside)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(AppDelegate.sharedDelegate().UserRole == "kitchen")
        {
        }
        else if(self.canEdit)
        {
            self.model?.ItemOptions.forEach({ $0.IsSelected = 0 })
            self.model?.ItemOptions[indexPath.row].IsSelected = 1
            self.helperDelegate?.EditDict(menuItem: self.model!)
            self.tblOptions.reloadData()
        }
    }
    
    @objc func ChangeSelection(_ sender: Any)
    {
        if(self.canEdit)
        {
            let btn = sender as! UIButton
            self.model?.ItemOptions.forEach({ $0.IsSelected = 0 })
            self.model?.ItemOptions[btn.tag].IsSelected = 1
            self.helperDelegate?.EditDict(menuItem: self.model!)
            self.tblOptions.reloadData()
        }
    }
        
    @objc func ChangePrefSelection(_ sender: Any)
    {
        if(self.canEdit)
        {
            let btn = sender as! UIButton
            self.model?.Preferences[btn.tag].IsSelected = (self.model?.Preferences[btn.tag].IsSelected == 0) ? 1 : 0
            self.helperDelegate?.EditDict(menuItem: self.model!)
            self.clPrefSelection.reloadItems(at: [IndexPath(row: btn.tag, section: 0)])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(self.canEdit)
        {
            self.model?.Preferences[indexPath.row].IsSelected = (self.model?.Preferences[indexPath.row].IsSelected == 0) ? 1 : 0
            self.helperDelegate?.EditDict(menuItem: self.model!)
            self.clPrefSelection.reloadItems(at: [IndexPath(row: indexPath.row, section: 0)])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        print("in items for section \(self.model?.Preferences.count ?? 0)")
        return self.model?.Preferences.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "clCellPrefSelection",for:indexPath) as! clCellPrefSelection
        cell.lblTitle.text = self.model?.Preferences[indexPath.row].Name
        cell.btnCheckBox.tag = indexPath.row
        cell.btnCheckBox.isSelected = (self.model?.Preferences[indexPath.row].IsSelected == 0) ? false : true
        cell.btnCheckBox.addTarget(self, action: #selector(ChangePrefSelection), for: .touchUpInside)
        if(indexPath.row%2 == 1)
        {
            cell.cns_chk_left.constant = 0
        }
        else
        {
            cell.cns_chk_left.constant = 20
        }
        print("in cell item")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print("hgt and wd")
        return CGSize(width:  self.cl_cell_width, height: 30)
    }
    
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        print("spacing")
//        return 50.0
//    }
    
}
