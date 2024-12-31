//
//  SearchRoomVC.swift
//  DiningApp
//
//  Created by Intelli on 2023-01-11.
//

import UIKit
import SwiftyJSON
import SearchTextField

class LogFormVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var act_indicator: UIActivityIndicatorView!
    @IBOutlet weak var txtRoomNumber : UITextField!
    @IBOutlet weak var lblResidentName : UILabel!
    @IBOutlet weak var txtLog : UITextView!
    @IBOutlet weak var txtActionTaken : UITextField!
    @IBOutlet weak var txtFollowUpReq : UITextField!
    @IBOutlet weak var txtLoggedBy : SearchTextField!
    
    @IBOutlet weak var vw_clearBG: UIView!
    @IBOutlet weak var vw_header: UIView!
    
    let dtpickerWidth : CGFloat = ((UIDevice.current.userInterfaceIdiom == .pad) ? 450 : 300)
    var room_id = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtLog.backgroundColor = UIColor.white
        self.txtLog.layer.borderWidth = 1.0
        self.txtLog.layer.borderColor = UIColor.black.cgColor
        
        self.txtRoomNumber.delegate = self
        //self.txtLoggedBy.theme = .darkTheme()
        self.txtLoggedBy.theme.bgColor = .white
        self.txtLoggedBy.theme.font = UIFont(name: "Helvetica", size: (UIDevice.current.userInterfaceIdiom == .pad) ? 23.0 : 18.0)!
        self.txtLoggedBy.filterStrings(AppDelegate.sharedDelegate().arLoggedBy)
            //["rose","red","read","blue","black","green"])
    }
    
    override func viewWillDisappear(_ animated: Bool) {
            print("in disappear")
    }
    
    
    @IBAction func btnBack_Clicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    
    @IBAction func btnSubmit_Clicked(_ sender: Any)
    {
        if(self.txtRoomNumber.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0)
        {
            self.showMessageAlert(message: "Please enter Room Number.")
        }
        else if(!AppDelegate.sharedDelegate().arRoomList.map({ $0.RoomName.lowercased() }).contains(self.txtRoomNumber.text?.lowercased()))
        {
            self.showMessageAlert(message: "Room Number not valid.")
        }
        else if(self.txtLog.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0)
        {
            self.showMessageAlert(message: "Please enter What it is about.")
        }
        else if(self.txtLoggedBy.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0)
        {
            self.showMessageAlert(message: "Please enter Logged By.")
        }
//        else if(self.lblDate.title(for: .normal) == "Select Date")
//        {
//            self.showMessageAlert(message: "Please select Date.")
//        }
//        else if(self.txtPhoneNo.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0)
//        {
//            self.showMessageAlert(message: "Please enter Phone No.")
//        }
//        else if(self.txtPhoneNo.text?.trimmingCharacters(in: .whitespacesAndNewlines).count != 10)
//        {
//            self.showMessageAlert(message: "Please enter valid 10 digit Phone No.")
//        }
//        else if(self.txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0)
//        {
//            self.showMessageAlert(message: "Please enter Email.")
//        }
//        else if(!self.txtEmail.isValidEmail())
//        {
//            self.showMessageAlert(message: "Please enter valid Email.")
//        }
        else
        {
            self.callSubmitFormService()
        }
    }
    
    func callSubmitFormService()
    {
        
        let dtFormatter = DateFormatter()
        dtFormatter.dateFormat = "yyyy-MM-dd H:mm:ss"
        dtFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let dictItem = [
            "room_number" : self.txtRoomNumber.text!,
            "resident_name" : self.lblResidentName.text!,
            "log_text" : self.txtLog.text!,
            "action_taken" : self.txtActionTaken.text!,
            "follow_up_required" : self.txtFollowUpReq.text!,
            "is_completed" : 0,
            "logged_by" : self.txtLoggedBy.text!.capitalized,
            "logged_at" : dtFormatter.string(from: Date())
        ] as [String : AnyObject]
        
        let json: JSON = JSON(dictItem)
        print("string converted object is \(json.rawString()!)")


        self.view.isUserInteractionEnabled = false
        self.act_indicator.startAnimating()


        let para = ["form_type" : "2", "data" : json.rawString()!, "room_id" : self.room_id] as [String : Any]
        
        //self.showMessageAlert(message:"para are \(para)")

        NetworkUtilities.shared.makePOSTRequest(with: API.baseURL + "general-form-submit-phase1", parameters: para) { (response) in


            print("api is \(API.baseURL + API.general_form_submit_api) para are \(para)")

            if(response.error == nil)
            {
                self.view.isUserInteractionEnabled = true
                self.act_indicator.stopAnimating()
                if(response.result[MainResponseCodeConstant.keyResponseCode].intValue == MainResponseCodeConstant.keyResponseCodeOne)
                {
                    if(AppDelegate.sharedDelegate().arLoggedBy.map({$0.lowercased()}).contains(self.txtLoggedBy.text!.lowercased()))
                    {
                    }
                    else
                    {
                        AppDelegate.sharedDelegate().arLoggedBy.append(self.txtLoggedBy.text!.capitalized)
                        CommonUtility.shared.setLoggedBy(str: AppDelegate.sharedDelegate().arLoggedBy.joined(separator: "*arLog*"))
                    }
                    
                    print(response.result)
                    CommonUtility.shared.showErrorAlertOnWindow("Success", message: "Form successfully Submitted.")
                    //self.navigationController?.popViewController(animated: false)
                    let previewPDFVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PreviewPDFVC") as! PreviewPDFVC
                    previewPDFVC.pdfURL = response.result["form_link"].stringValue
                    previewPDFVC.form_id = response.result["submitted_form_id"].intValue
                    let idx = AppDelegate.sharedDelegate().arFormList.firstIndex(where: { $0.FormId == 2 })
                    previewPDFVC.isAllowPrint = AppDelegate.sharedDelegate().arFormList[idx!].IsPrintAllowed
                    previewPDFVC.isAllowMail = AppDelegate.sharedDelegate().arFormList[idx!].IsMailAllowed
                    previewPDFVC.CalledFrom = "Add"
                    self.navigationController?.pushViewController(previewPDFVC, animated: false)
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
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.lblResidentName.text = ""
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(" FROM HERE ")
        
        if(textField == self.txtRoomNumber)
        {
            if(AppDelegate.sharedDelegate().arRoomList.map({ $0.RoomName.lowercased() }).contains(self.txtRoomNumber.text?.lowercased()))
            {
                
                let pos = AppDelegate.sharedDelegate().arRoomList.map({ $0.RoomName.lowercased() }).firstIndex(of: self.txtRoomNumber.text!.lowercased())
                //self.lblSelectedRoom.text = self.arRoomName[pos!]
                self.txtRoomNumber.text = AppDelegate.sharedDelegate().arRoomList[pos!].RoomName
                self.lblResidentName.text = AppDelegate.sharedDelegate().arRoomList[pos!].ResidentName
                self.room_id = AppDelegate.sharedDelegate().arRoomList[pos!].RoomId
                
//                self.selectedRoomName = AppDelegate.sharedDelegate().arRoomList[pos!].RoomName
//                self.selectedRoomID = AppDelegate.sharedDelegate().arRoomList[pos!].RoomId
//                self.occupancy = AppDelegate.sharedDelegate().arRoomList[pos!].Occupancy
            }
//            else
//            {
//                //self.txtRoomSelection.text = ""
//                if((self.txtRoomSelection.text?.replacingOccurrences(of: " ", with: "").count)! > 0)
//                {
//                    self.showMessageAlert(message: "Room No. not valid.")
//                }
//                else
//                {
//                    self.showMessageAlert(message: "Please enter Room No.")
//                }
//            }
        }
    }

    
}


//api is http://hamiltondinnerapp.intellidt.com/api/general-form-submit para are ["form_type": "1", "data": "[\n  {\n    \"address\" : \"Cc\",\n    \"gender\" : \"Male\",\n    \"languages\" : \"English\",\n    \"first_name\" : \"bb\",\n    \"last_name\" : \"aa\",\n    \"email\" : \"bb@aa.com\",\n    \"birth_date\" : \"02 Nov 2023\",\n    \"phone_no\" : \"3434343434\"\n  }\n]"]
