//
//  SearchRoomVC.swift
//  DiningApp
//
//  Created by Intelli on 2023-01-11.
//

import UIKit

class SearchRoomVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var act_indicator: UIActivityIndicatorView!
    @IBOutlet weak var txtRoomSelection: UITextField!
    @IBOutlet weak var btnGo: UIButton!
    @IBOutlet weak var cns_txtContainer_top: NSLayoutConstraint!
    @IBOutlet weak var cns_txtContainer_width: NSLayoutConstraint!
    @IBOutlet weak var cns_txtContainer_height: NSLayoutConstraint!
    @IBOutlet weak var cns_btnGo_right: NSLayoutConstraint!
    @IBOutlet weak var cns_btnGo_width: NSLayoutConstraint!
    @IBOutlet weak var cns_btnReport_height: NSLayoutConstraint!
    @IBOutlet weak var cns_btnReport_width: NSLayoutConstraint!
    @IBOutlet weak var cns_btnReport_top: NSLayoutConstraint!
    @IBOutlet weak var cns_btnLogout_top: NSLayoutConstraint!
    @IBOutlet weak var cns_btnLogout_width: NSLayoutConstraint!
    @IBOutlet weak var cns_btnLogout_height: NSLayoutConstraint!
    @IBOutlet weak var lblLoggedInAs: UILabel!
    
  
  //  var arRoomName : [String] = []
    var selectedRoomName : String = ""
    var selectedRoomID : Int = 0
    var occupancy : Int = 0
  //  var lastMenuDate : String = ""
    
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
        // Do any additional setup after loading the view.
        self.txtRoomSelection.delegate = self
        self.txtRoomSelection.addRightButtonOnKeyboardWithText("Done", target: self, action: #selector(self.DoneKeyboard))
        
        self.txtRoomSelection.attributedPlaceholder = NSAttributedString(string: "Room No.",
                                                                   attributes: [NSAttributedString.Key.font:UIFont(name: "Helvetica", size: (UIDevice.current.userInterfaceIdiom == .pad) ? 38 : 25)!])
                 
        if(UIDevice.current.userInterfaceIdiom == .pad)
        {
            self.cns_txtContainer_top.constant = UIScreen.main.bounds.size.height * (343/683)
            self.cns_txtContainer_width.constant = UIScreen.main.bounds.size.width * (9/16)
            self.cns_txtContainer_height.constant = UIScreen.main.bounds.size.height * (60/683)
            self.cns_btnGo_right.constant =  self.cns_txtContainer_width.constant * (1/32)
            self.cns_btnGo_width.constant =  self.cns_txtContainer_width.constant * (25/144)
            
            self.cns_btnReport_height.constant = UIScreen.main.bounds.size.height * (44/683)
            self.cns_btnReport_width.constant = UIScreen.main.bounds.size.width * (103/256)
            self.cns_btnReport_top.constant = UIScreen.main.bounds.size.height * (475/683)
            self.cns_btnLogout_top.constant = UIScreen.main.bounds.size.height * (553/683)
            
            self.cns_btnLogout_width.constant = 96
            self.cns_btnLogout_height.constant = 34
        }
        else
        {
            self.cns_txtContainer_top.constant = UIScreen.main.bounds.size.height * (1/2)
            self.cns_txtContainer_width.constant = UIScreen.main.bounds.size.width * (35/43)
            self.cns_txtContainer_height.constant = UIScreen.main.bounds.size.height * (18/233)
            self.cns_btnGo_right.constant =  self.cns_txtContainer_width.constant * (1/35)
            self.cns_btnGo_width.constant =  self.cns_txtContainer_width.constant * (6/35)
            
            self.cns_btnReport_height.constant = UIScreen.main.bounds.size.height * (25/466)
            self.cns_btnReport_width.constant = UIScreen.main.bounds.size.width * (47/86)
            self.cns_btnReport_top.constant = UIScreen.main.bounds.size.height * (164/233)
            self.cns_btnLogout_top.constant = UIScreen.main.bounds.size.height * (188/233)
        }
    }    
    
    @objc func DoneKeyboard()
    {
        self.txtRoomSelection.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(" FROM HERE ")
        if(AppDelegate.sharedDelegate().arRoomList.map({ $0.RoomName.lowercased() }).contains(self.txtRoomSelection.text?.lowercased()))
        {
            
            let pos = AppDelegate.sharedDelegate().arRoomList.map({ $0.RoomName.lowercased() }).firstIndex(of: self.txtRoomSelection.text!.lowercased())
            //self.lblSelectedRoom.text = self.arRoomName[pos!]
            self.txtRoomSelection.text = AppDelegate.sharedDelegate().arRoomList[pos!].RoomName
            //self.btnGo.isEnabled = true
            self.selectedRoomName = AppDelegate.sharedDelegate().arRoomList[pos!].RoomName
            self.selectedRoomID = AppDelegate.sharedDelegate().arRoomList[pos!].RoomId
            self.occupancy = AppDelegate.sharedDelegate().arRoomList[pos!].Occupancy
        }
        else
        {
            //self.txtRoomSelection.text = ""
            if((self.txtRoomSelection.text?.replacingOccurrences(of: " ", with: "").count)! > 0)
            {
                self.showMessageAlert(message: "Room No. not valid.")
            }
            else
            {
                self.showMessageAlert(message: "Please enter Room No.")
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
            print("in disappear")
    }
    
    @IBAction func btnReport_Clicked(_ sender: Any)
    {
        let reportVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ReportVC") as! ReportVC
        reportVC.lastMenuDate = AppDelegate.sharedDelegate().LastMenuDate
        if (reportVC.lastMenuDate.compare(Date()) == ComparisonResult.orderedAscending)
        {
            reportVC.selectedDate = reportVC.lastMenuDate
        }
        else
        {
            reportVC.selectedDate = Date()
        }
        self.navigationController?.pushViewController(reportVC, animated: false)
    }
    
    @IBAction func btnBack_Clicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func btnForms_Clicked(_ sender: Any)
    {
        //SubmitFormVC //PreviewPDFVC
        let ListFormVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ListFormsVC") as! ListFormsVC
        //submitFormVC.pdfURL = "https://www.tutorialspoint.com/swift/swift_tutorial.pdf"
        self.navigationController?.pushViewController(ListFormVC, animated: false)
    }
    
    @IBAction func btnGo_Clicked(_ sender: Any) {
        
        if(self.txtRoomSelection.isFirstResponder)
        {
            self.txtRoomSelection.resignFirstResponder()
        }
        
        if(AppDelegate.sharedDelegate().arRoomList.map({ $0.RoomName.lowercased() }).contains(self.txtRoomSelection.text?.lowercased()))
        {
            let MealItemsVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MealItemsVC") as! MealItemsVC
            MealItemsVC.selectedRoomName = self.selectedRoomName
            MealItemsVC.selectedRoomID = self.selectedRoomID
            MealItemsVC.Occupancy = self.occupancy
            MealItemsVC.lastMenuDate = AppDelegate.sharedDelegate().LastMenuDate
            self.navigationController?.pushViewController(MealItemsVC, animated: false)
        }
        else
        {
            //self.txtRoomSelection.text = ""
            if((self.txtRoomSelection.text?.replacingOccurrences(of: " ", with: "").count)! > 0)
            {
                self.showMessageAlert(message: "Room No. not valid.")
            }
            else
            {
                self.showMessageAlert(message: "Please enter Room No.")
            }
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
    
}
