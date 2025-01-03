//
//  GuestOrderVC.swift
//  DiningApp
//
//  Created by Intelli on 2022-10-31.
//

import UIKit
import SDWebImage
import SwiftyJSON

class GuestOrderVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate, HeplerDelegate {

    @IBOutlet weak var lblRoomName : UILabel!
    @IBOutlet weak var lblSelectedDate: UILabel!
    @IBOutlet weak var tblItemList: UITableView!
    @IBOutlet weak var Mealsegment: UIStackView!
    @IBOutlet weak var btnBrk: UIButton!
    @IBOutlet weak var btnLunch: UIButton!
    @IBOutlet weak var btnDinner: UIButton!
    @IBOutlet weak var act_indicator: UIActivityIndicatorView!
    @IBOutlet weak var btnDoubleOccupancy: UIButton!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var vw_submitDivider: UIView!
    @IBOutlet weak var cns_btnSubmitWidth: NSLayoutConstraint!
    @IBOutlet weak var cns_btnBackWidth: NSLayoutConstraint!
    @IBOutlet weak var cns_btnBackRight: NSLayoutConstraint!
    @IBOutlet weak var lblGuideline: UILabel!
    @IBOutlet weak var cns_lblGuideline_top: NSLayoutConstraint!
    @IBOutlet weak var lblNoMenu: UILabel!
    @IBOutlet weak var lbl_quantity: UILabel!
    @IBOutlet weak var btn_plus: UIButton!
    @IBOutlet weak var btn_minus: UIButton!
    @IBOutlet weak var cns_Container_height: NSLayoutConstraint!
    @IBOutlet weak var vw_container: UIView!
    @IBOutlet weak var cns_stack_inner_width: NSLayoutConstraint!
    @IBOutlet weak var vw_clearBG: UIView!
    @IBOutlet weak var vw_header: UIView!
    @IBOutlet weak var btnCloseImage: UIButton!
    @IBOutlet weak var imgGallery: UIImageView!
    @IBOutlet weak var btnTray: UIButton!
    @IBOutlet weak var vw_tray: UIView!
    @IBOutlet weak var lblTraySrvTitle: UILabel!
    @IBOutlet weak var lblNoOfGuestTitle: UILabel!
    @IBOutlet weak var cns_stkSrvVwHight: NSLayoutConstraint!
    @IBOutlet weak var cns_chkSrvBoxWidth: NSLayoutConstraint!
    @IBOutlet weak var cns_stkViewTop: NSLayoutConstraint!
    @IBOutlet weak var cns_stkViewBottom: NSLayoutConstraint!
    
    var selectedRoomName : String = ""
    var selectedRoomID : Int = 0
    var selectedDate = Date()
    let CYear = Calendar.current.component(.year, from: Date())
    var formatter = DateFormatter()
    var arItemList : [clsCategoryItems] = []
    var arrBreakfastItems : [clsCategoryItems] = []
    var arrLunchItems : [clsCategoryItems] = []
    var arrDinnerItems : [clsCategoryItems] = []
    var currentSelectedIndex = 0
    var dictItems: [Dictionary<String, AnyObject>] = []
    var Occupancy : Int = 0
    var canEditBrk : Bool = true
    var canEditLunch : Bool = true
    var canEditDinner : Bool = true
    var lastMenuDate : Date = Date()
    var canIncNoOfGuest = true
    var canDescNoOfGuest = true
    var OccupancyToCompare : Int = 0
    var IsTrayForBrk = 0
    var IsTrayForLunch = 0
    var IsTrayForDinner = 0
    
    func heightChanged() {
        
        self.tblItemList.performBatchUpdates(nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.Occupancy = 0
        self.lblGuideline.textColor = UIColor.ColorCodes.homeSelectedCategory
        self.selectedRoomName = "\(self.selectedRoomName) \("guest".localizeString(string: AppDelegate.sharedDelegate().LanguagePrefCode))"
        self.btn_minus.setTitleColor(UIColor.lightGray, for: .normal)
        self.btn_plus.setTitleColor(UIColor.lightGray, for: .normal)
                
        if(UIDevice.current.userInterfaceIdiom == .pad)
        {
            self.cns_Container_height.constant =  38.0
            self.cns_stack_inner_width.constant = 32.0
            self.vw_container.layer.cornerRadius = 18.0
        }
        else
        {
            self.cns_Container_height.constant = 28.0
        }
        
//        if(AppDelegate.sharedDelegate().UserRole == "admin" || AppDelegate.sharedDelegate().UserRole == "concierge")
//        {
            self.cns_btnBackWidth.constant = 22
            self.cns_btnBackRight.constant = 13
//        }
        
        
        let img = (AppDelegate.sharedDelegate().UserRole == "kitchen") ? UIImage(named: "btn_report") : ((AppDelegate.sharedDelegate().LanguagePref == 0) ? UIImage(named: "btn_submit") : UIImage(named: "btn_submit_cn"))
        self.btnSubmit.setBackgroundImage(img, for: .normal)
                    
        self.lblRoomName.text = (AppDelegate.sharedDelegate().UserRole == "kitchen") ? "Kitchen" : "# \(self.selectedRoomName)"
        //self.btnDoubleOccupancy.isHidden = (self.Occupancy == 2) ? false : true
        // Do any additional setup after loading the view.
        
        let frame = CGRect(x: 0, y: 48.5, width: UIScreen.main.bounds.size.width/3, height: 1.5)
        let BrkborderBottom = UIView(frame: frame)
        BrkborderBottom.backgroundColor = UIColor.ColorCodes.homeUnselectedCategory
        BrkborderBottom.tag = 1111
        let LunchborderBottom = UIView(frame: frame)
        LunchborderBottom.backgroundColor = UIColor.ColorCodes.homeUnselectedCategory
        LunchborderBottom.tag = 1111
        let DnrborderBottom = UIView(frame: frame)
        DnrborderBottom.backgroundColor = UIColor.ColorCodes.homeUnselectedCategory
        DnrborderBottom.tag = 1111
        self.btnBrk.addSubview(BrkborderBottom)
        self.btnLunch.addSubview(LunchborderBottom)
        self.btnDinner.addSubview(DnrborderBottom)
        
        self.btnBrk.setTitle("brk".localizeString(string: AppDelegate.sharedDelegate().LanguagePrefCode), for: .normal)
        self.btnLunch.setTitle("lunch".localizeString(string: AppDelegate.sharedDelegate().LanguagePrefCode), for: .normal)
        self.btnDinner.setTitle("dnr".localizeString(string: AppDelegate.sharedDelegate().LanguagePrefCode), for: .normal)
        self.lblTraySrvTitle.text = "trayService".localizeString(string: AppDelegate.sharedDelegate().LanguagePrefCode)
        self.lblNoOfGuestTitle.text = "noOfGuests".localizeString(string: AppDelegate.sharedDelegate().LanguagePrefCode)
               
        if(UIDevice.current.userInterfaceIdiom == .pad)
        {
            self.cns_chkSrvBoxWidth.constant = 30
            self.cns_btnSubmitWidth.constant = (UIScreen.main.bounds.size.width * 20.0) / 59.0
        }
        else
        {
            self.cns_chkSrvBoxWidth.constant = 25
            self.cns_btnSubmitWidth.constant = (UIScreen.main.bounds.size.width * 30.0) / 59.0
        }
        
        if #available(iOS 15.0, *) {
            self.tblItemList.sectionHeaderTopPadding = 0.0
        }
       // self.tblItemList.contentInsetAdjustmentBehavior = .never
        self.tblItemList.register(UINib(nibName: "TblMenuItemListCell", bundle: nil), forCellReuseIdentifier: "TblMenuItemListCell")
        self.tblItemList.register(UINib(nibName: "TblAddItemCell", bundle: nil), forCellReuseIdentifier: "TblAddItemCell")
        self.tblItemList.register(UINib(nibName: "TblSubItemListCell", bundle: nil), forCellReuseIdentifier: "TblSubItemListCell")
        
        self.compareSelectedDate()
        
        self.setSelectedDateLabel()
        self.CallOrderListService()
    }

    
    func setSelectedDateLabel()
    {
        let mnth = self.selectedDate.toString(dateFormat: "MMMM")
        let cl_mnth = mnth.localizeString(string: AppDelegate.sharedDelegate().LanguagePrefCode)
        
        if(Calendar.current.isDateInToday(self.selectedDate))
        {
            let td = "today".localizeString(string: AppDelegate.sharedDelegate().LanguagePrefCode)
            self.lblSelectedDate.text = "\(td) \(cl_mnth) \(self.selectedDate.toString(dateFormat: "d, yyyy"))"
        }
        else
        {
            self.lblSelectedDate.text = "\(cl_mnth) \(self.selectedDate.toString(dateFormat: "d, yyyy"))"
        }
    }
    
    @IBAction func btnBack_Clicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
   
    func compareSelectedDate()
    {
        if(Calendar.current.isDate(Date(), inSameDayAs:self.selectedDate))
        {
            print("both dates are same")
            self.canEditDinner = true
            self.canEditBrk = false
            self.canEditLunch = false
            let hours = (Calendar.current.component(.hour, from: Date()))
            if(hours < 10)
            {
               self.currentSelectedIndex = 0
//               self.cns_lblGuideline_top.constant = 25
//               self.lblGuideline.text = (self.arrBreakfastItems.count == 0) ? "" : AppDelegate.sharedDelegate().guidelineText
               self.canEditBrk = true
               self.canEditLunch = true
            }
            else if(hours < 15)
            {
                self.currentSelectedIndex = 1
//                self.cns_lblGuideline_top.constant = 25
//                self.lblGuideline.text = (self.arrBreakfastItems.count == 0) ? "" : AppDelegate.sharedDelegate().guidelineText
                self.canEditLunch = true
            }
            else
            {
                self.currentSelectedIndex = 2
//                self.cns_lblGuideline_top.constant = 0
//                self.lblGuideline.text = ""
            }
        }
        else if Date().compare(self.selectedDate) == ComparisonResult.orderedDescending
        {
            self.currentSelectedIndex = 0
//            self.cns_lblGuideline_top.constant = 25
//            self.lblGuideline.text = AppDelegate.sharedDelegate().guidelineText
            NSLog("date1 after date2");
            self.canEditBrk = false //false
            self.canEditLunch = false //false
            self.canEditDinner = false //false
            self.canIncNoOfGuest = false
            self.canDescNoOfGuest = false
        }
        else if Date().compare(self.selectedDate) == ComparisonResult.orderedAscending
        {
            self.currentSelectedIndex = 0
//            self.cns_lblGuideline_top.constant = 25
//            self.lblGuideline.text = AppDelegate.sharedDelegate().guidelineText
            NSLog("date1 before date2");
            self.canEditBrk = true
            self.canEditLunch = true
            self.canEditDinner = true
        }
    }
    
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 200.0
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
            //(indexPath.section == self.arItemList.count) ? 236.0
    }  
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.arItemList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.arItemList[section].CatItems.count)
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let menuItems = (self.arItemList[indexPath.section].CatItems)
        if(menuItems[indexPath.row].ItemType == ItemType.SubCat)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TblAddItemCell", for: indexPath) as! TblAddItemCell
            cell.selectionStyle = .none
            let tl = (menuItems[indexPath.row]).ChineseName!
            cell.lbltext.text = (AppDelegate.sharedDelegate().LanguagePref == 0) ? (menuItems[indexPath.row]).ItemName! : ((tl.count == 0) ? (menuItems[indexPath.row]).ItemName! : tl)
            return cell
        }
        else if(menuItems[indexPath.row].ItemType == ItemType.SubCatItem || menuItems[indexPath.row].ItemImage.count == 0)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TblSubItemListCell", for: indexPath) as! TblSubItemListCell
            cell.selectionStyle = .none
            
            let tl = (menuItems[indexPath.row]).ChineseName!
            
            cell.lblItemName.text = (AppDelegate.sharedDelegate().LanguagePref == 0) ? (menuItems[indexPath.row]).ItemName : ((tl.count == 0) ? (menuItems[indexPath.row]).ItemName! : tl)
            
            var canEdit = false
            
            if((self.currentSelectedIndex == 0 && self.canEditBrk) || (self.currentSelectedIndex == 1 && self.canEditLunch) || (self.currentSelectedIndex == 2 && self.canEditDinner))
            {
                if(menuItems[indexPath.row].ItemQuantity == 0)
                {
                    cell.btn_minus.setTitleColor(UIColor.lightGray, for: .normal)
                }
                else
                {
                    cell.btn_minus.setTitleColor(UIColor.black, for: .normal)
                }
                
                //|| self.arItemList[indexPath.section].NoOfItemsSelected == self.Occupancy
                if(menuItems[indexPath.row].ItemQuantity == self.Occupancy)
                {
                    cell.btn_plus.setTitleColor(UIColor.lightGray, for: .normal)
                }
                else
                {
                    cell.btn_plus.setTitleColor(UIColor.black, for: .normal)
                }
                
                canEdit = true
            }
            else
            {
                cell.btn_minus.setTitleColor(UIColor.lightGray, for: .normal)
                cell.btn_plus.setTitleColor(UIColor.lightGray, for: .normal)
            }
            
            if(menuItems[indexPath.row].ItemType == ItemType.SubCatItem)
            {
                cell.cns_labelLeading.constant = 30
                cell.cns_TitleTop.constant = 10
                cell.cns_TitleBottom.constant = 10
                cell.cns_vwSeperateor_height.constant = 0
                
                cell.configure(withModel: menuItems[indexPath.row], canEdit: canEdit)
            }
            else
            {
                cell.cns_labelLeading.constant = 15
                cell.cns_TitleTop.constant = 20
                cell.cns_TitleBottom.constant = 20
                if(indexPath.row == menuItems.count - 1)
                {
                    cell.cns_vwSeperateor_height.constant = 0
                }
                else
                {
                    cell.cns_vwSeperateor_height.constant = 1
                }
                
                cell.configure(withModel: menuItems[indexPath.row], canEdit: canEdit)
                cell.helperDelegate = self
            }
                       
            cell.lbl_quantity.text = "\(menuItems[indexPath.row].ItemQuantity!)"
            cell.btn_plus.tag = (indexPath.section * 1000) + indexPath.row
            cell.btn_minus.tag = cell.btn_plus.tag
            cell.btn_plus.addTarget(self, action: #selector(AddQuantity), for: .touchUpInside)
            cell.btn_minus.addTarget(self, action: #selector(MinusQuantity), for: .touchUpInside)
            
            if(AppDelegate.sharedDelegate().UserRole == "kitchen")
            {
                DispatchQueue.main.asyncAfter(deadline: .now() +  0.05) {
                    cell.lbl_quantity.font = UIFont(name: "Helvetica-Bold", size: ((UIDevice.current.userInterfaceIdiom == .pad) ? 28.0 : 22.0))
                }
            }

            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TblMenuItemListCell", for: indexPath) as! TblMenuItemListCell
            cell.selectionStyle = .none
            
            let tl = (menuItems[indexPath.row]).ChineseName!
                                    
            if(indexPath.row == menuItems.count - 1)
            {
                cell.cns_vwSeperateor_height.constant = 0
            }
            else
            {
                cell.cns_vwSeperateor_height.constant = 1
            }
            
            cell.lblItemName.text = (AppDelegate.sharedDelegate().LanguagePref == 0) ? (menuItems[indexPath.row]).ItemName! : ((tl.count == 0) ? (menuItems[indexPath.row]).ItemName! : tl)
            if(menuItems[indexPath.row].ItemImage.count > 0)
            {
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.imgClicked(_:)))
                cell.imgItemImage.isUserInteractionEnabled = true
                cell.imgItemImage.addGestureRecognizer(tapGesture)
                cell.imgItemImage.tag = (indexPath.section * 1000) + indexPath.row
                cell.imgItemImage.sd_setImage(with: URL(string: menuItems[indexPath.row].ItemImage.ChangeSpacetoPer20())!, placeholderImage: UIImage(named: ""), options: .refreshCached, completed: nil)
               // print("img view is \(cell.imgItemImage)")
            }
            
            if((self.currentSelectedIndex == 0 && self.canEditBrk) || (self.currentSelectedIndex == 1 && self.canEditLunch) || (self.currentSelectedIndex == 2 && self.canEditDinner))
            {
                if(menuItems[indexPath.row].ItemQuantity == 0)
                {
                    cell.btn_minus.setTitleColor(UIColor.lightGray, for: .normal)
                }
                else
                {
                    cell.btn_minus.setTitleColor(UIColor.black, for: .normal)
                }
                
                //|| self.arItemList[indexPath.section].NoOfItemsSelected == self.Occupancy
                if(menuItems[indexPath.row].ItemQuantity == self.Occupancy)
                {
                    cell.btn_plus.setTitleColor(UIColor.lightGray, for: .normal)
                }
                else
                {
                    cell.btn_plus.setTitleColor(UIColor.black, for: .normal)
                }
            }
            else
            {
                cell.btn_minus.setTitleColor(UIColor.lightGray, for: .normal)
                cell.btn_plus.setTitleColor(UIColor.lightGray, for: .normal)
            }
                
            
            cell.lbl_quantity.text = "\(menuItems[indexPath.row].ItemQuantity!)"
            cell.btn_plus.tag = (indexPath.section * 1000) + indexPath.row
            cell.btn_minus.tag = cell.btn_plus.tag
            cell.btn_plus.addTarget(self, action: #selector(AddQuantity), for: .touchUpInside)
            cell.btn_minus.addTarget(self, action: #selector(MinusQuantity), for: .touchUpInside)
            
            
            if(AppDelegate.sharedDelegate().UserRole == "kitchen")
            {
                DispatchQueue.main.asyncAfter(deadline: .now() +  0.05) {
                    cell.lbl_quantity.font = UIFont(name: "Helvetica-Bold", size: ((UIDevice.current.userInterfaceIdiom == .pad) ? 28.0 : 22.0))
                }
            }
            
            return cell
        }
    }
    
    @objc func imgClicked(_ sender: UITapGestureRecognizer)
    {
        let img = sender.view as! UIImageView
        let sec = img.tag/1000
        let rw = img.tag%1000
        
        let menuItems = (self.arItemList[sec].CatItems)
        
        let dt = NSData(contentsOf: URL(string: menuItems[rw].ItemImage.ChangeSpacetoPer20())!)
        self.imgGallery.image =  UIImage(data: dt! as Data)
  
        self.btnCloseImage.isHidden = false
        self.vw_clearBG.isHidden = false
        self.vw_header.isUserInteractionEnabled = false
        
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseIn, animations: {
            //self.imgGallery.isHidden = false
            self.imgGallery.alpha = 1.0
        })
        
//        let FullImgVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FullmageVC") as! FullmageVC
//        self.navigationController?.pushViewController(FullImgVC, animated: false)
    }
    
    func getNoOfLines(txt : String, lbl : UILabel) -> Int
    {
        let rect = CGSize(width: lbl.bounds.width, height: CGFloat.greatestFiniteMagnitude)
           let labelSize = txt.boundingRect(with: rect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: lbl.font as Any], context: nil)
           return Int(ceil(CGFloat(labelSize.height) / lbl.font.lineHeight))
    }
    
    func setUpMealCategoryArray(selectedIndex : Int)
    {
        self.currentSelectedIndex = selectedIndex
        //self.CallOrderListService()
        if(selectedIndex == 0)
        {
            self.lblNoMenu.text = "Breakfast Menu is not available."
            self.lblNoMenu.isHidden = (self.arrBreakfastItems.count == 0) ? false : true
            self.tblItemList.isHidden = (self.arrBreakfastItems.count == 0) ? true : false
            //self.vw_tray.isHidden = (self.arrBreakfastItems.count == 0) ? true : false
            self.cns_lblGuideline_top.constant = 25
            self.lblGuideline.text = (self.arrBreakfastItems.count == 0) ? "" : AppDelegate.sharedDelegate().guidelineText
            self.btnBrk.setTitleColor(UIColor.ColorCodes.homeSelectedCategory, for: .normal)
            self.btnLunch.setTitleColor(UIColor.ColorCodes.homeUnselectedCategory, for: .normal)
            self.btnDinner.setTitleColor(UIColor.ColorCodes.homeUnselectedCategory, for: .normal)
            self.arItemList = self.arrBreakfastItems
            self.btnTray.isSelected = (self.IsTrayForBrk == 1) ? true : false
            
            self.btnBrk.subviews.forEach({ if($0.tag == 1111) {$0.backgroundColor = UIColor.ColorCodes.homeSelectedCategory } })
            self.btnLunch.subviews.forEach({ if($0.tag == 1111) {$0.backgroundColor = UIColor.ColorCodes.homeUnselectedCategory} })
            self.btnDinner.subviews.forEach({ if($0.tag == 1111) {$0.backgroundColor = UIColor.ColorCodes.homeUnselectedCategory} })
            
            self.btnSubmit.isEnabled = (AppDelegate.sharedDelegate().UserRole == "kitchen") ? true : (self.canEditBrk == true)
        }
        else if(selectedIndex == 1)
        {
            self.lblNoMenu.text = "Lunch Menu is not available."
            self.lblNoMenu.isHidden = (self.arrLunchItems.count == 0) ? false : true
            self.tblItemList.isHidden = (self.arrLunchItems.count == 0) ? true : false
            //self.vw_tray.isHidden = (self.arrLunchItems.count == 0) ? true : false
            self.cns_lblGuideline_top.constant = 25
            self.lblGuideline.text = (self.arrLunchItems.count == 0) ? "" :AppDelegate.sharedDelegate().guidelineText
            self.btnBrk.setTitleColor(UIColor.ColorCodes.homeUnselectedCategory, for: .normal)
            self.btnLunch.setTitleColor(UIColor.ColorCodes.homeSelectedCategory, for: .normal)
            self.btnDinner.setTitleColor(UIColor.ColorCodes.homeUnselectedCategory, for: .normal)
            self.arItemList = self.arrLunchItems
            self.btnTray.isSelected = (self.IsTrayForLunch == 1) ? true : false
            
            self.btnBrk.subviews.forEach({ if($0.tag == 1111) {$0.backgroundColor = UIColor.ColorCodes.homeUnselectedCategory} })
            self.btnLunch.subviews.forEach({ if($0.tag == 1111) {$0.backgroundColor = UIColor.ColorCodes.homeSelectedCategory} })
            self.btnDinner.subviews.forEach({ if($0.tag == 1111) {$0.backgroundColor = UIColor.ColorCodes.homeUnselectedCategory} })
            
            self.btnSubmit.isEnabled = (AppDelegate.sharedDelegate().UserRole == "kitchen") ? true : (self.canEditLunch == true)
        }
        else
        {
            self.lblNoMenu.text = "Dinner Menu is not available."
            self.lblNoMenu.isHidden = (self.arrDinnerItems.count == 0) ? false : true
            self.tblItemList.isHidden = (self.arrDinnerItems.count == 0) ? true : false
            //self.vw_tray.isHidden = (self.arrDinnerItems.count == 0) ? true : false
            self.cns_lblGuideline_top.constant = 0
            self.lblGuideline.text = ""
            self.btnBrk.setTitleColor(UIColor.ColorCodes.homeUnselectedCategory, for: .normal)
            self.btnLunch.setTitleColor(UIColor.ColorCodes.homeUnselectedCategory, for: .normal)
            self.btnDinner.setTitleColor(UIColor.ColorCodes.homeSelectedCategory, for: .normal)
            self.arItemList = self.arrDinnerItems
            self.btnTray.isSelected = (self.IsTrayForDinner == 1) ? true : false
            
            self.btnBrk.subviews.forEach({ if($0.tag == 1111) {$0.backgroundColor = UIColor.ColorCodes.homeUnselectedCategory} })
            self.btnLunch.subviews.forEach({ if($0.tag == 1111) {$0.backgroundColor = UIColor.ColorCodes.homeUnselectedCategory} })
            self.btnDinner.subviews.forEach({ if($0.tag == 1111) {$0.backgroundColor = UIColor.ColorCodes.homeSelectedCategory} })
            
            self.btnSubmit.isEnabled = (AppDelegate.sharedDelegate().UserRole == "kitchen") ? true : (self.canEditDinner == true)
        }
        
        let totalOrders = self.arItemList.map({ $0.NoOfItemsSelected }).reduce(0, +)
        self.vw_tray.isHidden = (totalOrders > 0) ? false : true //&& self.btnSubmit.isEnabled
        if(self.btnSubmit.isEnabled)
        {
            self.vw_tray.isUserInteractionEnabled = true
        }
        else
        {
            self.vw_tray.isUserInteractionEnabled = false
        }
        
        self.cns_stkSrvVwHight.constant = (self.vw_tray.isHidden) ? 0 : 30
        self.cns_stkViewTop.constant = (self.vw_tray.isHidden) ? 0 : 20
        self.cns_stkViewBottom.constant = (self.vw_tray.isHidden) ? 0 : 20
      
        self.tblItemList.reloadData()
        if(self.arItemList.count > 0)
        {
            self.tblItemList.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        }
    }
    
    @IBAction func btnMeal_Clicked(_ sender: Any)
    {
        let btn = sender as! UIButton
        self.setUpMealCategoryArray(selectedIndex: btn.tag)
    }
    
    @objc func AddQuantity(_ sender: Any)
    {
        if((self.currentSelectedIndex == 0 && self.canEditBrk) || (self.currentSelectedIndex == 1 && self.canEditLunch) || (self.currentSelectedIndex == 2 && self.canEditDinner))
        {
            print("in add")
            let btn = sender as! UIButton
            let sec = btn.tag/1000
            let rw = btn.tag%1000
            
            let menuItems = (self.arItemList[sec].CatItems)
            
            if(menuItems[rw].ItemQuantity != self.Occupancy && self.arItemList[sec].NoOfItemsSelected != self.Occupancy)
            {
                print("in add normal")
                self.arItemList[sec].NoOfItemsSelected = self.arItemList[sec].NoOfItemsSelected + 1
                menuItems[rw].ItemQuantity = menuItems[rw].ItemQuantity + 1
                self.arItemList[sec].LatestSelectedIndex = rw
                    
                //self.tblItemList.reloadRows(at: [IndexPath(row: rw, section: sec)], with: .none)
                if(menuItems[rw].ItemType == ItemType.SubCatItem)
                {
                }
                else
                {
                    if(menuItems[rw].ItemOptions.count > 0 && (menuItems[rw].ItemOptions.count == menuItems[rw].ItemOptions.filter({ $0.IsSelected == 0 }).count))
                    {
                        menuItems[rw].ItemOptions[0].IsSelected = 1
                    }
                    menuItems[rw].isExpanded = 1
                    //self.tblItemList.reloadRows(at: [IndexPath(row: rw, section: sec)], with: .automatic)
                }
                self.tblItemList.reloadData()
                self.convertToDict(menuItem: menuItems[rw])
            }
            else if(menuItems[rw].ItemQuantity != self.Occupancy)
            {
                print("in add remove previous")
                for i in 0..<menuItems.count
                {
                    if(menuItems[i].ItemQuantity > 0 && i != rw)
                    {
                        var isremove = true
                        if(self.Occupancy > 1)
                        {
                            if(menuItems[rw].ItemQuantity == 1)
                            {
                                
                            }
                            else if(i != self.arItemList[sec].LatestSelectedIndex)
                            {
                                isremove = false
                            }
//                            if(menuItems[i].ItemQuantity == self.Occupancy ||  menuItems[rw].ItemQuantity == 1)
//                            {
//
//                            }
//                            else if(i == self.arItemList[sec].LatestSelectedIndex)
//                            {
//                                isremove = false
//                            }
                        }
                        //if(self.Occupancy == 1  || (self.Occupancy > 1 && i != self.arItemList[sec].LatestSelectedIndex))
                        if(isremove)
                        {
                            menuItems[i].ItemQuantity = menuItems[i].ItemQuantity  - 1
                            
                            if(menuItems[i].ItemType == ItemType.SubCatItem)
                            {
                            }
                            else
                            {
                                if(menuItems[i].ItemQuantity == 0)
                                {
                                    menuItems[i].isExpanded = 0
                                    menuItems[i].ItemOptions.forEach({ $0.IsSelected = 0 })
                                    menuItems[i].Preferences.forEach({ $0.IsSelected = 0 })
                                }
                               // self.tblItemList.reloadRows(at: [IndexPath(row: i, section: sec)], with: .automatic)
                            }
                            
                            self.convertToDict(menuItem: menuItems[i])
                            print("in add remove previous at index \(i)")
                            //self.tblItemList.reloadRows(at: [IndexPath(row: i, section: sec)], with: .none)
                            //self.tblItemList.reloadData()
                            break
                        }
                    }
                }
             
                menuItems[rw].ItemQuantity = menuItems[rw].ItemQuantity + 1
                self.arItemList[sec].LatestSelectedIndex = rw
                //self.tblItemList.reloadRows(at: [IndexPath(row: rw, section: sec)], with: .none)
                
                if(menuItems[rw].ItemType == ItemType.SubCatItem)
                {
                }
                else
                {
                    if(menuItems[rw].ItemOptions.count > 0 && (menuItems[rw].ItemOptions.count == menuItems[rw].ItemOptions.filter({ $0.IsSelected == 0 }).count))
                    {
                        menuItems[rw].ItemOptions[0].IsSelected = 1
                    }
                    menuItems[rw].isExpanded = 1
                    //self.tblItemList.reloadRows(at: [IndexPath(row: rw, section: sec)], with: .automatic)
                }
                
                self.tblItemList.reloadData()
                self.convertToDict(menuItem: menuItems[rw])
            }
            else
            {
                
            }
        }
        
    }
    
    func EditDict(menuItem: clsMenuItems)
    {
        if(self.dictItems.map({ $0["item_id"] as! Int }).contains(menuItem.ItemId!))
        {
            let idx = self.dictItems.map({ $0["item_id"] as! Int }).firstIndex(of: menuItem.ItemId!)!
            var itm = self.dictItems[idx]
            var itemOption = itm["item_options"]
            var preference = itm["preference"]
            if(menuItem.ItemOptions.count > 0)
            {
                itemOption = (menuItem.ItemOptions.filter({ $0.IsSelected == 1 }).count > 0 ? "\(menuItem.ItemOptions.filter({ $0.IsSelected == 1 }).first!.Id!)" : "") as AnyObject
            }
            if(menuItem.Preferences.count > 0)
            {
                let pr = (menuItem.Preferences.filter({ $0.IsSelected == 1 }).map({ String($0.Id) }))
                preference = (pr.joined(separator: ",")) as AnyObject
            }


            itm["item_options"] = itemOption
            itm["preference"] = preference
            self.dictItems[idx] = itm
        }
        else
        {
            var itemOption = ""
            var preference = ""
            if(menuItem.ItemOptions.count > 0)
            {
                itemOption = (menuItem.ItemOptions.filter({ $0.IsSelected == 1 }).count > 0 ? "\(menuItem.ItemOptions.filter({ $0.IsSelected == 1 }).first!.Id!)" : "")
            }
            if(menuItem.Preferences.count > 0)
            {
                let pr = (menuItem.Preferences.filter({ $0.IsSelected == 1 }).map({ String($0.Id) }))
                preference = pr.joined(separator: ",")
            }
            let dictItem = [
            "item_id" : NSInteger(menuItem.ItemId!),
            "qty" : NSInteger(menuItem.ItemQuantity!),
            "order_id" : NSInteger(menuItem.OrderId),
            "item_options" : itemOption,
            "preference" : preference
            ] as [String : AnyObject]
            self.dictItems.append(dictItem)
        }
    }
    
    func convertToDict(menuItem : clsMenuItems)
    {
        if(self.dictItems.map({ $0["item_id"] as! Int }).contains(menuItem.ItemId!))
        {
            let idx = self.dictItems.map({ $0["item_id"] as! Int }).firstIndex(of: menuItem.ItemId!)!
            var itm = self.dictItems[idx]
            itm["qty"] = NSInteger(menuItem.ItemQuantity!) as AnyObject
            self.dictItems[idx] = itm
        }
        else
        {
            var itemOption = ""
            var preference = ""
            if(menuItem.ItemOptions.count > 0)
            {
                itemOption = (menuItem.ItemOptions.filter({ $0.IsSelected == 1 }).count > 0 ? "\(menuItem.ItemOptions.filter({ $0.IsSelected == 1 }).first!.Id!)" : "")
            }
            if(menuItem.Preferences.count > 0)
            {
                let pr = (menuItem.Preferences.filter({ $0.IsSelected == 1 }).map({ String($0.Id) }))
                preference = pr.joined(separator: ",")
            }
            let dictItem = [
            "item_id" : NSInteger(menuItem.ItemId!),
            "qty" : NSInteger(menuItem.ItemQuantity!),
            "order_id" : NSInteger(menuItem.OrderId),
            "item_options" : itemOption,
            "preference" : preference
            ] as [String : AnyObject]
            self.dictItems.append(dictItem)
        }
        
        let totalOrders = self.arItemList.map({ $0.NoOfItemsSelected }).reduce(0, +)
        self.vw_tray.isHidden = (totalOrders > 0) ? false : true
        self.cns_stkSrvVwHight.constant = (self.vw_tray.isHidden) ? 0 : 30
        self.cns_stkViewTop.constant = (self.vw_tray.isHidden) ? 0 : 20
        self.cns_stkViewBottom.constant = (self.vw_tray.isHidden) ? 0 : 20
        
        if(self.vw_tray.isHidden == true)
        //if(!self.btnTray.isEnabled)
        {
            self.btnTray.isSelected = false
            
            if(self.currentSelectedIndex == 0)
            {
                self.IsTrayForBrk = 0
            }
            else if(self.currentSelectedIndex == 1)
            {
                self.IsTrayForLunch = 0
            }
            else
            {
                self.IsTrayForDinner = 0
            }
        }
    }
    
    @objc func MinusQuantity(_ sender: Any)
    {
        if((self.currentSelectedIndex == 0 && self.canEditBrk) || (self.currentSelectedIndex == 1 && self.canEditLunch) || (self.currentSelectedIndex == 2 && self.canEditDinner))
        {
            print("in minus")
            let btn = sender as! UIButton
            let sec = btn.tag/1000
            let rw = btn.tag%1000
            
            let menuItems = (self.arItemList[sec].CatItems)
            
            if(menuItems[rw].ItemQuantity != 0)
            {
                self.arItemList[sec].NoOfItemsSelected = self.arItemList[sec].NoOfItemsSelected - 1
                menuItems[rw].ItemQuantity = menuItems[rw].ItemQuantity - 1
                //self.tblItemList.reloadRows(at: [IndexPath(row: rw, section: sec)], with: .none)
                if(menuItems[rw].ItemType == ItemType.SubCatItem)
                {
                }
                else
                {
                    if(menuItems[rw].ItemQuantity == 0)
                    {
                        menuItems[rw].isExpanded = 0
                        menuItems[rw].ItemOptions.forEach({ $0.IsSelected = 0 })
                        menuItems[rw].Preferences.forEach({ $0.IsSelected = 0 })
                    }
                    //self.tblItemList.reloadRows(at: [IndexPath(row: rw, section: sec)], with: .automatic)
                }
                
                self.tblItemList.reloadData()
                self.convertToDict(menuItem: menuItems[rw])
            }
        }
    }

    @IBAction func btnSubmit_Clicked(_ sender: Any)
    {
        if(AppDelegate.sharedDelegate().UserRole == "kitchen")
        {
            let reportVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ReportVC") as! ReportVC
            reportVC.lastMenuDate = AppDelegate.sharedDelegate().LastMenuDate
            reportVC.selectedDate = self.selectedDate
            self.navigationController?.pushViewController(reportVC, animated: false)
        }
        else
        {
            var orders_to_change = ""
            if(self.dictItems.count > 0)
            {
                let json: JSON = JSON(self.dictItems)
                print("string converted object is \(json.rawString()!)")
                orders_to_change = json.rawString()!
            }
            
            self.view.isUserInteractionEnabled = false
            self.act_indicator.startAnimating()
            
            let para = ["date" : self.selectedDate.toString(dateFormat: "yyyy-MM-dd"), "room_id" : self.selectedRoomID, "orders_to_change" : orders_to_change, "occupancy" : self.Occupancy, "is_for_guest" : 1, "is_brk_tray_service" : self.IsTrayForBrk, "is_lunch_tray_service" : self.IsTrayForLunch, "is_dinner_tray_service" : self.IsTrayForDinner] as [String : Any]
            
            //update-order
            NetworkUtilities.shared.makePOSTRequest(with: API.baseURL + API.update_item_list_api, parameters: para) { (response) in
                
                
                print("para are \(para)")
                
                if(response.error == nil)
                {
                    self.view.isUserInteractionEnabled = true
                    self.act_indicator.stopAnimating()
                    if(response.result[MainResponseCodeConstant.keyResponseCode].intValue == MainResponseCodeConstant.keyResponseCodeOne)
                    {
                        print(response.result)
                        
                        let items = response.result["item_id"].arrayValue.map({ $0.intValue })
                        let orders = response.result["order_id"].arrayValue.map({ $0.intValue })
                        
                        var indexes : [Int] = []
                        for i in 0..<items.count
                        {
                            let id = items[i]
                            if(self.dictItems.map({ $0["item_id"] as! Int }).contains(id))
                            {
                                let idx = self.dictItems.map({ $0["item_id"] as! Int }).firstIndex(of: id)!
                                var itm = self.dictItems[idx]
                                if(orders[i] == 0)
                                {
                                    indexes.append(i)
                                }
                                itm["order_id"] = orders[i] as AnyObject
                                self.dictItems[idx] = itm
                            }
                        }
                        
                        self.dictItems.remove(at: indexes)
                    }
                    else
                    {
                        self.showMessageAlert(message: response.result[MainResponseCodeConstant.keyResponseText].stringValue)
                    }
                }
                else
                {
                    self.showMessageAlert(message: response.error!.localizedDescription)
                }
            }
        }
    }
        
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 38.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let vw = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 38.0))
        vw.backgroundColor = UIColor.ColorCodes.dinningTblHeaderBgColor
        
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 0, y: 0, width: vw.frame.size.width, height: vw.frame.size.height)
        btn.contentHorizontalAlignment = .center
        btn.titleLabel?.font = (UIDevice.current.userInterfaceIdiom == .pad) ? UIFont(name: "Helvetica-Bold", size: 22.0) : UIFont(name: "Helvetica-Bold", size: 17.0)
        if(AppDelegate.sharedDelegate().LanguagePref == 0)
        {
            btn.setTitle(self.arItemList[section].CatName.uppercased(), for: .normal)
        }
        else
        {
            var tl = self.arItemList[section].ChineseName!
            if(tl.count == 0)
            {
                tl = self.arItemList[section].CatName.uppercased()
            }
            btn.setTitle(tl, for: .normal)
        }
        //print("sub cat count is \(self.arItemList[section].SubCatItems.count)")
        btn.setTitleColor(UIColor.ColorCodes.dinningTblHeaderColor, for: .normal)
        //btn.addTarget(self, action: #selector(redirectToItemSelectionVC), for: .touchUpInside)
        btn.tag = section
        vw.addSubview(btn)
        
        return vw
    }
    
    func CallOrderListService()
    {
        self.view.isUserInteractionEnabled = false
        self.act_indicator.startAnimating()
//API.order_list_api
        //"get-categorywise-data"
        print("input is \(["room_id" : self.selectedRoomID, "date" : self.selectedDate.toString(dateFormat: "yyyy-MM-dd"), "type" : self.currentSelectedIndex + 1])")
        NetworkUtilities.shared.makePOSTRequest(with: API.baseURL + "guest-order-list", parameters: ["room_id" : self.selectedRoomID, "date" : self.selectedDate.toString(dateFormat: "yyyy-MM-dd"), "type" : self.currentSelectedIndex + 1]) { (response) in
            if(response.error == nil)
            {
                self.view.isUserInteractionEnabled = true
                self.act_indicator.stopAnimating()
                if(response.result[MainResponseCodeConstant.keyResponseCode].intValue == MainResponseCodeConstant.keyResponseCodeOne)
                {
                    print(response.result)
                    self.IsTrayForBrk = response.result["is_brk_tray_service"].intValue
                    self.IsTrayForLunch = response.result["is_lunch_tray_service"].intValue
                    self.IsTrayForDinner = response.result["is_dinner_tray_service"].intValue
                    self.arrBreakfastItems.removeAll()
                    self.arrBreakfastItems.append(contentsOf: response.result[MainResponseCodeConstant.keyBrk].arrayValue.compactMap(clsCategoryItems.init))
                    self.arrLunchItems.removeAll()
                    self.arrLunchItems.append(contentsOf: response.result[MainResponseCodeConstant.keyLunch].arrayValue.compactMap(clsCategoryItems.init))
                    self.arrDinnerItems.removeAll()
                    self.arrDinnerItems.append(contentsOf: response.result[MainResponseCodeConstant.keyDinner].arrayValue.compactMap(clsCategoryItems.init))

                    self.arrBreakfastItems.forEach({ $0.NoOfItemsSelected =  $0.CatItems.map({ $0.ItemQuantity }).reduce(0, +)
                        print("brk items \($0.NoOfItemsSelected)")
                    })
                    let totalBrkOrders = self.arrBreakfastItems.map({ $0.NoOfItemsSelected }).reduce(0, +)
                    self.arrLunchItems.forEach({ $0.NoOfItemsSelected =  $0.CatItems.map({ $0.ItemQuantity }).reduce(0, +)
                        print("lunch items \($0.NoOfItemsSelected)")
                    })
                    let totalLunchOrders = self.arrLunchItems.map({ $0.NoOfItemsSelected }).reduce(0, +)
                    self.arrDinnerItems.forEach({ $0.NoOfItemsSelected =  $0.CatItems.map({ $0.ItemQuantity }).reduce(0, +)
                        print("Dinner items \($0.NoOfItemsSelected)")
                    })
                    let totalDinnerOrders = self.arrDinnerItems.map({ $0.NoOfItemsSelected }).reduce(0, +)

                    self.dictItems.removeAll()

                    if(AppDelegate.sharedDelegate().UserRole == "kitchen")
                    {

                    }
                    else
                    {

                        if(totalBrkOrders == 0)
                        {
                        }
                        else
                        {
                            self.arrBreakfastItems.forEach({
                                if($0.NoOfItemsSelected > 0)
                                {
                                    var i = 0
                                    var latestIndex = 0
                                    $0.CatItems.forEach({
                                        if($0.ItemQuantity > 0)
                                        {
                                            latestIndex = i
                                            if($0.ItemOptions.count > 0 || $0.Preferences.count > 0)
                                            {
                                                $0.isExpanded = 1
                                            }
                                        }
                                        i = i + 1
                                    })
                                    if(self.canEditBrk == true)
                                    {
                                        $0.LatestSelectedIndex = latestIndex
                                    }
                                }
                            })
                        }

                        if(totalLunchOrders == 0)
                        {
                        }
                        else
                        {
                            self.arrLunchItems.forEach({
                                if($0.NoOfItemsSelected > 0)
                                {
                                    var i = 0
                                    var latestIndex = 0
                                    $0.CatItems.forEach({
                                        if($0.ItemQuantity > 0)
                                        {
                                            latestIndex = i
                                            if($0.ItemOptions.count > 0 || $0.Preferences.count > 0)
                                            {
                                                $0.isExpanded = 1
                                            }
                                        }
                                        i = i + 1
                                    })
                                    if(self.canEditLunch == true)
                                    {
                                        $0.LatestSelectedIndex = latestIndex
                                    }
                                }
                            })
                        }

                        if(totalDinnerOrders == 0)
                        {
                        }
                        else
                        {
                            self.arrDinnerItems.forEach({
                                if($0.NoOfItemsSelected > 0)
                                {
                                    var i = 0
                                    var latestIndex = 0
                                    $0.CatItems.forEach({
                                        if($0.ItemQuantity > 0)
                                        {
                                            latestIndex = i
                                            if($0.ItemOptions.count > 0 || $0.Preferences.count > 0)
                                            {
                                                $0.isExpanded = 1
                                            }
                                        }
                                        i = i + 1
                                    })
                                    if(self.canEditDinner == true)
                                    {
                                        $0.LatestSelectedIndex = latestIndex
                                    }
                                }
                            })
                        }
                    }

                    self.setUpMealCategoryArray(selectedIndex: self.currentSelectedIndex)
                    self.vw_submitDivider.isHidden = false
                    self.btnSubmit.isHidden = false
                    self.lblGuideline.isHidden = false
                    
                    self.Occupancy = response.result["occupancy"].intValue
                    self.lbl_quantity.text = "\(self.Occupancy)"
                    if(self.Occupancy > 0)
                    {
                        self.btn_minus.setTitleColor(UIColor.black, for: .normal)
                    }
                    if(self.Occupancy < 10)
                    {
                        self.btn_plus.setTitleColor(UIColor.black, for: .normal)
                    }
                    
                    if(Calendar.current.isDate(Date(), inSameDayAs:self.selectedDate))
                    {
                        if(self.canEditBrk == false || self.canEditLunch == false || self.canEditDinner == false)
                        {
                                if(self.Occupancy > 0)
                                {
                                    var maxCount = 0
                                    if(self.canEditBrk == false)
                                    {
                                        self.arrBreakfastItems.forEach({
                                            if($0.NoOfItemsSelected > maxCount)
                                            {
                                                maxCount = $0.NoOfItemsSelected
                                            }
                                        })
                                    }
                                    
                                    if(self.canEditLunch == false)
                                    {
                                        self.arrLunchItems.forEach({
                                            if($0.NoOfItemsSelected > maxCount)
                                            {
                                                maxCount = $0.NoOfItemsSelected
                                            }
                                        })
                                    }
                                    
                                    //self.canDescNoOfGuest = false
                                    self.OccupancyToCompare = maxCount//self.Occupancy
                                    
                                    if(self.Occupancy == self.OccupancyToCompare)
                                    {
                                        self.btn_minus.setTitleColor(UIColor.lightGray, for: .normal)
                                    }
                                }
                        }
                    }
                    else if Date().compare(self.selectedDate) == ComparisonResult.orderedDescending
                    {
                        self.btn_plus.setTitleColor(UIColor.lightGray, for: .normal)
                        self.btn_minus.setTitleColor(UIColor.lightGray, for: .normal)
                    }
                }
                else
                {
                    self.showMessageAlert(message: response.result[MainResponseCodeConstant.keyResponseText].stringValue)
                }
            }
            else
            {
                self.showMessageAlert(message: response.error!.localizedDescription)
            }
        }
    }
    
    @IBAction func btnTray_Clicked(_ sender: Any)
    {
        self.btnTray.isSelected = !self.btnTray.isSelected
        
        if(self.currentSelectedIndex == 0)
        {
            self.IsTrayForBrk = (self.btnTray.isSelected) ? 1 : 0
        }
        else if(self.currentSelectedIndex == 1)
        {
            self.IsTrayForLunch = (self.btnTray.isSelected) ? 1 : 0
        }
        else
        {
            self.IsTrayForDinner = (self.btnTray.isSelected) ? 1 : 0
        }
    }
    
    @IBAction func btnLogOut_Clicked(_ sender: Any)
    {
        AppDelegate.sharedDelegate().RoomName = ""
        CommonUtility.shared.setRoomName(str: "")
        AppDelegate.sharedDelegate().RoomId = ""
        CommonUtility.shared.setRoomId(str: "")
        CommonUtility.shared.setAPIToken(str: "")
        if #available(iOS 13.0, *) {
            let sceneDelegate = UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate
            sceneDelegate.loadLoginPage()
        }
        else
        {
            AppDelegate.sharedDelegate().loadLoginPage()
        }
        
    }
    
    @IBAction func AddGuest(_ sender: Any)
    {
        if(self.Occupancy != 10 && self.canIncNoOfGuest)
        {
            self.Occupancy = self.Occupancy + 1
            self.lbl_quantity.text = "\(self.Occupancy)"
            if(self.Occupancy == 10)
            {
                self.btn_plus.setTitleColor(UIColor.lightGray, for: .normal)
            }
            self.btn_minus.setTitleColor(UIColor.black, for: .normal)
            self.tblItemList.reloadData()
        }
    }
    
    @IBAction func MinusGuest(_ sender: Any)
    {
        if(self.Occupancy != self.OccupancyToCompare && self.canDescNoOfGuest)
        {
            var askToReplace = false
            for i in 0..<self.arrBreakfastItems.count
            {
                if(self.arrBreakfastItems[i].NoOfItemsSelected == self.Occupancy)
                {
                    askToReplace = true
                    break
                }
            }
            if(askToReplace == false)
            {
                for i in 0..<self.arrLunchItems.count
                {
                    if(self.arrLunchItems[i].NoOfItemsSelected == self.Occupancy)
                    {
                        askToReplace = true
                        break
                    }
                }
            }
            if(askToReplace == false)
            {
                for i in 0..<self.arrDinnerItems.count
                {
                    if(self.arrDinnerItems[i].NoOfItemsSelected == self.Occupancy)
                    {
                        askToReplace = true
                        break
                    }
                }
            }
            
            
            if(askToReplace)
            {
                let alert = UIAlertController(title: "", message: "Order is already selected for \(self.Occupancy) guest(s). If you continue, it will remove all items from the order.", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { (action) in
                    
                    if(self.canEditBrk == true)
                    {
                        self.arrBreakfastItems.forEach({
                            
                            $0.LatestSelectedIndex = 0
                            $0.NoOfItemsSelected = 0
                            $0.CatItems.forEach({
                                if($0.ItemQuantity > 0)
                                {
                                    $0.ItemQuantity = 0
                                    $0.ItemOptions.forEach({ $0.IsSelected = 0 })
                                    $0.Preferences.forEach({ $0.IsSelected = 0 })
                                    self.convertToDict(menuItem: $0)
                                }
                                $0.isExpanded = 0
                            })
                        })
                    }
                    
                    if(self.canEditLunch == true)
                    {
                        self.arrLunchItems.forEach({
                            
                            $0.LatestSelectedIndex = 0
                            $0.NoOfItemsSelected = 0
                            $0.CatItems.forEach({
                                if($0.ItemQuantity > 0)
                                {
                                    $0.ItemQuantity = 0
                                    $0.ItemOptions.forEach({ $0.IsSelected = 0 })
                                    $0.Preferences.forEach({ $0.IsSelected = 0 })
                                    self.convertToDict(menuItem: $0)
                                }
                                $0.isExpanded = 0
                            })
                        })
                    }
                    
                    if(self.canEditDinner == true)
                    {
                        self.arrDinnerItems.forEach({
                            
                            $0.LatestSelectedIndex = 0
                            $0.NoOfItemsSelected = 0
                            $0.CatItems.forEach({
                                if($0.ItemQuantity > 0)
                                {
                                    $0.ItemQuantity = 0
                                    $0.ItemOptions.forEach({ $0.IsSelected = 0 })
                                    $0.Preferences.forEach({ $0.IsSelected = 0 })
                                    self.convertToDict(menuItem: $0)
                                }
                                $0.isExpanded = 0
                            })
                        })
                    }
                                        
                    self.ApplyMinusGuest()
                }))
                
                alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
                    
                }))
                
                self.present(alert, animated: true)
            }
            else
            {
                self.ApplyMinusGuest()
            }
        }
    }
    
    func ApplyMinusGuest()
    {
        self.Occupancy = self.Occupancy - 1
        self.lbl_quantity.text = "\(self.Occupancy)"
        if(self.Occupancy == 0 || self.Occupancy == self.OccupancyToCompare)
        {
            self.btn_minus.setTitleColor(UIColor.lightGray, for: .normal)
        }
        self.btn_plus.setTitleColor(UIColor.black, for: .normal)
        self.tblItemList.reloadData()
    }
    
    @IBAction func btnCloseImage_Clicked(_ sender: Any) {
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
            //self.imgGallery.isHidden = true
            self.imgGallery.alpha = 0.0
        } ) { _ in
            self.btnCloseImage.isHidden = true
            self.vw_clearBG.isHidden = true
            self.vw_header.isUserInteractionEnabled = true            
        }
    }
    
}
