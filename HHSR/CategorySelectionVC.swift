//
//  CategorySelectionVC.swift
//  iEduGame
//
//  Created by Intelli on 2021-09-22.
//

import UIKit

class CategorySelectionVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
     
  
//    @IBOutlet weak var btnAddition: UIButton!
//    @IBOutlet weak var btnSubtraction: UIButton!
//    @IBOutlet weak var cns_btnAdditionTop: NSLayoutConstraint!
//    @IBOutlet weak var cns_btnAdditionLeft: NSLayoutConstraint!
//    @IBOutlet weak var cns_btnSubtractionRight: NSLayoutConstraint!
//    @IBOutlet weak var cns_btnMultiplyTop: NSLayoutConstraint!
//    @IBOutlet weak var cns_btnAdditionWidth: NSLayoutConstraint!
//    @IBOutlet weak var cns_btnAdditionHeight: NSLayoutConstraint!
//    @IBOutlet weak var cns_btnsettings_left: NSLayoutConstraint!
//    @IBOutlet weak var cns_btnsettings_bottom: NSLayoutConstraint!
//    @IBOutlet weak var cns_btnsettings_width: NSLayoutConstraint!
//    @IBOutlet weak var cns_img_home_width: NSLayoutConstraint!
//    @IBOutlet weak var cns_img_home_height: NSLayoutConstraint!
//    @IBOutlet weak var cns_img_home_top: NSLayoutConstraint!
    @IBOutlet weak var act_indicator: UIActivityIndicatorView!
    @IBOutlet weak var btnLogOut: UIButton!
    @IBOutlet weak var clCatSelection: UICollectionView!
    @IBOutlet weak var cl_right: NSLayoutConstraint!
    @IBOutlet weak var cl_left: NSLayoutConstraint!
    @IBOutlet weak var cl_hgt: NSLayoutConstraint!
    @IBOutlet weak var cns_btnSubmitWidth: NSLayoutConstraint!
    @IBOutlet weak var cns_cl_top: NSLayoutConstraint!
    @IBOutlet weak var cns_logOut_top: NSLayoutConstraint!
    @IBOutlet weak var lblLoggedInAs: UILabel!
       
    var cl_cell_width : CGFloat = 100.0
    var cell_Padding : CGFloat = 20.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(AppDelegate.sharedDelegate().UserRole == "superadmin")
        {
            self.lblLoggedInAs.text = "Logged in as SuperAdmin"
        }
        else if(AppDelegate.sharedDelegate().UserRole == "admin")
        {
            self.lblLoggedInAs.text = "Logged in as Admin"
        }
        else if(AppDelegate.sharedDelegate().UserRole == "concierge")
        {
            self.lblLoggedInAs.text = "Logged in as Concierge"
        }
        else
        {
            self.lblLoggedInAs.text = "Logged in as Nurse"
        }
        //self.lblLoggedInAs.text = (AppDelegate.sharedDelegate().UserRole == "admin") ? "Logged in as Admin" : ((AppDelegate.sharedDelegate().UserRole == "concierge") ? "Logged in as Concierge" : "Logged in as Nurse")
                
        self.clCatSelection.register(UINib(nibName: "clCellCategorySelection", bundle: nil), forCellWithReuseIdentifier: "clCellCategorySelection")
      
        self.btnLogOut.isHidden = true
        self.clCatSelection.isHidden = true
        
        print("total is \(UIScreen.main.bounds.size.width) width is \(self.cl_cell_width) and padding is \(self.cell_Padding)")
        
        if(UIDevice.current.userInterfaceIdiom == .pad)
        {
            self.cns_btnSubmitWidth.constant = (UIScreen.main.bounds.size.width * 20.0) / 59.0
            self.cl_cell_width = UIScreen.main.bounds.size.width * (12.5/59) //20 //4
        }
        else
        {
            self.cns_btnSubmitWidth.constant = (UIScreen.main.bounds.size.width * 30.0) / 59.0
            self.cl_cell_width = UIScreen.main.bounds.size.width * (16/59) //20 //4
        }
        
        self.cell_Padding = (UIScreen.main.bounds.size.width - (self.cl_cell_width * 2))/3
        self.cl_right.constant = self.cell_Padding
        self.cl_left.constant = self.cell_Padding
        
       // self.CallProfileService()
        
        let img = ((AppDelegate.sharedDelegate().LanguagePref == 0) ? UIImage(named: "btn_logout") : UIImage(named: "btn_logout_cn"))
        self.btnLogOut.setBackgroundImage(img, for: .normal)
        self.btnLogOut.isHidden = false
        self.clCatSelection.reloadData()
        self.clCatSelection.isHidden = false
    }
    
    override func viewDidLayoutSubviews() {
        self.cl_hgt.constant = self.clCatSelection.contentSize.height
        let half =  (UIScreen.main.bounds.size.height - self.cl_hgt.constant)/2
        
        if(UIDevice.current.userInterfaceIdiom == .pad)
        {
            self.cns_cl_top.constant = (half) * (8.5/10)
        }
        else if(UIScreen.main.bounds.size.height <= 667) //667 //736
        {
            self.cns_cl_top.constant = (half) * (9/10)
            self.cns_logOut_top.constant = (UIScreen.main.bounds.size.height - self.cns_cl_top.constant - self.cl_hgt.constant) * (16/67)
        }
        else
        {
            self.cns_cl_top.constant = (half) * (7/10)
        }
        
        print("half is \(half) and top is \(self.cns_cl_top.constant)")
    }

    @IBAction func btnNext_Clicked(_ sender: Any)
    {
        let MealItemsVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MealItemsVC") as! MealItemsVC
        MealItemsVC.selectedRoomName = AppDelegate.sharedDelegate().RoomName
        MealItemsVC.selectedRoomID = Int(AppDelegate.sharedDelegate().RoomId)!
        MealItemsVC.Occupancy = AppDelegate.sharedDelegate().Occupancy
        MealItemsVC.lastMenuDate = AppDelegate.sharedDelegate().LastMenuDate
        self.navigationController?.pushViewController(MealItemsVC, animated: false)
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { 
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "clCellCategorySelection",for:indexPath) as! clCellCategorySelection
        if(AppDelegate.sharedDelegate().LanguagePref == 0)
        {
            cell.img_catIcon.image = UIImage(named: "cat_icon_\(indexPath.row)")
        }
        else
        {
            cell.img_catIcon.image = UIImage(named: "cat_icon_cn_\(indexPath.row)")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print("hgt and wd")
        return CGSize(width: self.cl_cell_width, height: self.cl_cell_width)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(indexPath.row == 0)
        {
//            if(AppDelegate.sharedDelegate().UserRole == "admin")
//            {
                let SearchRoomVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchRoomVC") as! SearchRoomVC
                self.navigationController?.pushViewController(SearchRoomVC, animated: false)
//            }
//            else
//            {
//                let MealItemsVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MealItemsVC") as! MealItemsVC
//                MealItemsVC.selectedRoomName = AppDelegate.sharedDelegate().RoomName
//                MealItemsVC.selectedRoomID = Int(AppDelegate.sharedDelegate().RoomId)!
//                MealItemsVC.Occupancy = AppDelegate.sharedDelegate().Occupancy
//                MealItemsVC.lastMenuDate = AppDelegate.sharedDelegate().LastMenuDate
//                self.navigationController?.pushViewController(MealItemsVC, animated: false)
//            }
        }
        else if(indexPath.row == 1)
        {
            let ListFormVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ListFormsVC") as! ListFormsVC
            self.navigationController?.pushViewController(ListFormVC, animated: false)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        print("spacing")
        return 50.0
    }
    
    
    func CallProfileService()
    {
        self.view.isUserInteractionEnabled = false
        self.act_indicator.startAnimating()

        NetworkUtilities.shared.makePOSTRequest(with: API.baseURL + "get-user-data", parameters: nil) { (response) in
            
            if(response.error == nil)
            {
                self.view.isUserInteractionEnabled = true
                self.act_indicator.stopAnimating()
                
              //  self.CallRoomListService()
                
                if(response.result[MainResponseCodeConstant.keyResponseCode].intValue == MainResponseCodeConstant.keyResponseCodeOne)
                {
                    print(response.result)
                    AppDelegate.sharedDelegate().arRoomList.removeAll()
                    AppDelegate.sharedDelegate().arRoomList.append(contentsOf: response.result[MainResponseCodeConstant.keyRoomsList].arrayValue.compactMap(clsRoom.init))
                    
                    AppDelegate.sharedDelegate().UserRole = response.result["role"].stringValue
                    AppDelegate.sharedDelegate().Occupancy = response.result["occupancy"].intValue
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd"
                    AppDelegate.sharedDelegate().LastMenuDate = formatter.date(from: response.result[MainResponseCodeConstant.keyLastMenuDate].stringValue)!
                    AppDelegate.sharedDelegate().LanguagePref = response.result["language"].intValue
                    if(AppDelegate.sharedDelegate().LanguagePref == 0)
                    {
                        AppDelegate.sharedDelegate().LanguagePrefCode = "en"
                        AppDelegate.sharedDelegate().guidelineText = response.result["guideline"].stringValue
                    }
                    else
                    {
                        AppDelegate.sharedDelegate().LanguagePrefCode = "zh-HK"
                        AppDelegate.sharedDelegate().guidelineText = response.result["guideline_cn"].stringValue
                    }
                                        
                    let img = ((AppDelegate.sharedDelegate().LanguagePref == 0) ? UIImage(named: "btn_logout") : UIImage(named: "btn_logout_cn"))
                    self.btnLogOut.setBackgroundImage(img, for: .normal)
                    self.btnLogOut.isHidden = false
                    self.clCatSelection.reloadData()
                    self.clCatSelection.isHidden = false
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
    
    func CallRoomListService()
    {
        self.view.isUserInteractionEnabled = false
        self.act_indicator.startAnimating()

        NetworkUtilities.shared.makeGETRequest(with: API.baseURL + API.room_list_api) { (response) in
//, parameters: ["log_date" : self.selectedDate.toString(dateFormat: "yyyy-MM-dd")]
            if(response.error == nil)
            {
                self.view.isUserInteractionEnabled = true
                self.act_indicator.stopAnimating()
                if(response.result[MainResponseCodeConstant.keyResponseCode].intValue == MainResponseCodeConstant.keyResponseCodeOne)
                {
                    print(response.result["rooms"])
                    AppDelegate.sharedDelegate().arRoomList.removeAll()
                    AppDelegate.sharedDelegate().arRoomList.append(contentsOf: response.result[MainResponseCodeConstant.keyRoomsList].arrayValue.compactMap(clsRoom.init))
                    AppDelegate.sharedDelegate().lastMenuDate = response.result[MainResponseCodeConstant.keyLastMenuDate].stringValue
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

