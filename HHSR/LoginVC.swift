//
//  SearchRoomVC.swift
//  DiningApp
//
//  Created by Intelli on 2023-01-11.
//

import UIKit

class LoginVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var act_indicator: UIActivityIndicatorView!
    @IBOutlet weak var txtRoomSelection: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnGo: UIButton!
    @IBOutlet weak var cns_txtContainer_top: NSLayoutConstraint!
    @IBOutlet weak var cns_txtPassword_top: NSLayoutConstraint!
    @IBOutlet weak var cns_txtContainer_width: NSLayoutConstraint!
    @IBOutlet weak var cns_txtContainer_height: NSLayoutConstraint!
    @IBOutlet weak var cns_btnGo_top: NSLayoutConstraint!
    @IBOutlet weak var cns_btnGo_width: NSLayoutConstraint!
    
    var selectedRoomName : String = ""
    var selectedRoomID : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
           
        // Do any additional setup after loading the view.
        //self.txtRoomSelection.addRightButtonOnKeyboardWithText("Done", target: self, action: #selector(self.DoneKeyboard))
        
        self.txtRoomSelection.attributedPlaceholder = NSAttributedString(string: "Room No.",
                                                                   attributes: [NSAttributedString.Key.font:UIFont(name: "Helvetica", size: (UIDevice.current.userInterfaceIdiom == .pad) ? 38 : 25)!])
        self.txtPassword.attributedPlaceholder = NSAttributedString(string: "Password",
                                                                    attributes: [NSAttributedString.Key.font:UIFont(name: "Helvetica", size: (UIDevice.current.userInterfaceIdiom == .pad) ? 38 : 25)!])
                 
        if(UIDevice.current.userInterfaceIdiom == .pad)
        {
            self.cns_txtContainer_top.constant = UIScreen.main.bounds.size.height * (322/683)
            self.cns_txtPassword_top.constant = UIScreen.main.bounds.size.height * (417/683)
            self.cns_txtContainer_width.constant = UIScreen.main.bounds.size.width * (287/512)
            self.cns_txtContainer_height.constant = UIScreen.main.bounds.size.height * (60/683)
            self.cns_btnGo_top.constant =  UIScreen.main.bounds.size.height * (512/683)
            self.cns_btnGo_width.constant =  UIScreen.main.bounds.size.width * (25/256)
        }
        else
        {
            self.cns_txtContainer_top.constant = UIScreen.main.bounds.size.height * (108.5/233)
            self.cns_txtPassword_top.constant = UIScreen.main.bounds.size.height * (137.5/233)
            self.cns_txtContainer_width.constant = UIScreen.main.bounds.size.width * (174/215)
            self.cns_txtContainer_height.constant = UIScreen.main.bounds.size.height * (18/233)
            self.cns_btnGo_top.constant =  UIScreen.main.bounds.size.height * (166/233)
            self.cns_btnGo_width.constant =  UIScreen.main.bounds.size.width * (6/43)
        }
    }
    
    func CallLoginService()
    {
        self.view.isUserInteractionEnabled = false
        self.act_indicator.startAnimating()
        
        print("from login")

        NetworkUtilities.shared.makePOSTRequest(with: API.baseURL + API.login_api, parameters: ["room_no" : self.txtRoomSelection.text!, "password" : self.txtPassword.text!]) { (response) in

            if(response.error == nil)
            {
                self.view.isUserInteractionEnabled = true
                self.act_indicator.stopAnimating()
                if(response.result[MainResponseCodeConstant.keyResponseCode].intValue == MainResponseCodeConstant.keyResponseCodeOne)
                {
                    print(response.result)
                
                    AppDelegate.sharedDelegate().RoomId = response.result["room_id"].stringValue
                    CommonUtility.shared.setRoomId(str: AppDelegate.sharedDelegate().RoomId)
                    AppDelegate.sharedDelegate().RoomName = response.result["room_number"].stringValue
                    CommonUtility.shared.setRoomName(str: AppDelegate.sharedDelegate().RoomName)
                    
                    if(response.result[MainResponseCodeConstant.keyAuthenticationToken].exists())
                    {
                        CommonUtility.shared.setAPIToken(str: response.result[MainResponseCodeConstant.keyAuthenticationToken].stringValue)
                    }
                    
                    self.view.endEditing(true)
                    
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
                  
                    if(AppDelegate.sharedDelegate().UserRole == "superadmin" || AppDelegate.sharedDelegate().UserRole == "admin" || AppDelegate.sharedDelegate().UserRole == "concierge" || AppDelegate.sharedDelegate().UserRole == "nurse")
                    {
//                       let SearchRoomVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchRoomVC") as! SearchRoomVC
//                       self.navigationController?.pushViewController(SearchRoomVC, animated: false)
                        AppDelegate.sharedDelegate().arFormList.removeAll()
                        AppDelegate.sharedDelegate().arFormList.append(contentsOf: response.result["form_types"].arrayValue.compactMap(clsForms.init))
                        
                        let catVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CategorySelectionVC") as! CategorySelectionVC
//                        let SearchRoomVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchRoomVC") as! SearchRoomVC
                        self.navigationController?.pushViewController(catVC, animated: false)
                    }
                    else
                    {
                        let MealItemsVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MealItemsVC") as! MealItemsVC
                        MealItemsVC.selectedRoomName = AppDelegate.sharedDelegate().RoomName
                        MealItemsVC.selectedRoomID = Int(AppDelegate.sharedDelegate().RoomId)!
                        MealItemsVC.Occupancy = AppDelegate.sharedDelegate().Occupancy
                        MealItemsVC.lastMenuDate = AppDelegate.sharedDelegate().LastMenuDate
                        self.navigationController?.pushViewController(MealItemsVC, animated: false)
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
    
    override func viewWillDisappear(_ animated: Bool) {
            print("in disappear")
    }
    
    @IBAction func btnGo_Clicked(_ sender: Any)
    {
        
        self.view.endEditing(true)
        if(self.txtRoomSelection.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0)
        {
            self.showMessageAlert(message: "Please enter Room No.")
            //self.lblErrorMessage.text = "Please enter Email ID."
        }
        else if(self.txtPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0)
        {
            self.showMessageAlert(message: "Please enter Password")
            //self.lblErrorMessage.text = "Please enter Password."
        }
        else
        {
            self.CallLoginService()
        }
    }
}
