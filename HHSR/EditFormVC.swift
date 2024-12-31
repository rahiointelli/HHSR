//
//  EditFormVC.swift
//  DiningApp
//
//  Created by Intelli on 2023-01-11.
//

import UIKit
import SwiftyJSON

class EditFormVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var act_indicator: UIActivityIndicatorView!
    @IBOutlet weak var txtFName : UITextField!
    @IBOutlet weak var txtLName : UITextField!
    @IBOutlet weak var txtAddress : UITextView!
    @IBOutlet weak var txtPhoneNo : UITextField!
    @IBOutlet weak var txtEmail : UITextField!
    @IBOutlet weak var btnMale : UIButton!
    @IBOutlet weak var btnFemale : UIButton!
    @IBOutlet weak var lblDate: UIButton!
    @IBOutlet weak var btnLangEnglish: UIButton!
    @IBOutlet weak var btnLangChinese: UIButton!
    @IBOutlet var dtPicker : UIDatePicker!
    @IBOutlet weak var vw_clearBG: UIView!
    @IBOutlet weak var vw_header: UIView!
    @IBOutlet var vw_DatePickerContainer: UIView!
    
    let dtpickerWidth : CGFloat = ((UIDevice.current.userInterfaceIdiom == .pad) ? 450 : 300)
    var form_id = 11
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtAddress.backgroundColor = UIColor.white
        self.txtAddress.layer.borderWidth = 1.0
        self.txtAddress.layer.borderColor = UIColor.black.cgColor
        
        if #available(iOS 13.4, *) {
            self.dtPicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        self.dtPicker.datePickerMode = .date
        self.dtPicker.overrideUserInterfaceStyle = .light
        
        self.CallFormDetailService()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
            print("in disappear")
    }
    
    
    @IBAction func btnBack_Clicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    
    @IBAction func btnGender_Clicked(_ sender: Any) {
        let btn = sender as! UIButton
        if(btn.isSelected)
        {
            
        }
        else
        {
            self.btnMale.isSelected = !(self.btnMale.isSelected)
            self.btnFemale.isSelected = !(self.btnFemale.isSelected)
        }
    }
    
    @IBAction func btnLanguage_Clicked(_ sender: Any) {
        let btn = sender as! UIButton
        btn.isSelected = !(btn.isSelected)
    }
    
    @IBAction func btnScheduleDateClicked(_ sender: Any)
    {
                
        self.view.endEditing(true)
        self.vw_clearBG.isHidden = false
        self.vw_header.isUserInteractionEnabled = false
        let wd = UIScreen.main.bounds.size.width
        
        self.vw_DatePickerContainer.frame = CGRect(x: (wd - dtpickerWidth)/2, y: ((UIScreen.main.bounds.size.height - self.vw_DatePickerContainer.frame.size.height)/2), width: dtpickerWidth, height: self.vw_DatePickerContainer.frame.size.height)
   
        self.view.addSubview(self.vw_DatePickerContainer)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        dateFormatter.locale = self.dtPicker.locale
        //"dd MMM YYYY hh:mm a"
        // HH:mm:ss z
        if(self.lblDate.title(for: .normal) != "Select Date")
        {
            let date = dateFormatter.date(from: self.lblDate.title(for: .normal)!)
            dateFormatter.dateFormat =  "yyyy-MM-dd"
            let yourDate = dateFormatter.string(from: date!)
           
            print(yourDate)
            self.dtPicker.date = dateFormatter.date(from: yourDate)!
        }
        else
        {
            self.dtPicker.date = Date()
        }
    }
    
    @IBAction func btnCancelDateClicked(_ sender: Any)
    {
        self.vw_clearBG.isHidden = true
        self.vw_header.isUserInteractionEnabled = true
        self.vw_DatePickerContainer.removeFromSuperview()
    }
    
    @IBAction func btnAddDateClicked(_ sender: Any)
    {
        self.vw_clearBG.isHidden = true
        self.vw_header.isUserInteractionEnabled = true
        self.vw_DatePickerContainer.removeFromSuperview()
        
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let myString = formatter.string(from: self.dtPicker.date)
        let yourDate = formatter.date(from: myString)
        formatter.dateFormat = "dd MMM YYYY"
        let selectedDate = formatter.string(from: yourDate!)
        self.lblDate.setTitle(selectedDate, for: .normal)
             
    }
    
    
    @IBAction func btnSubmit_Clicked(_ sender: Any)
    {

        if(self.txtFName.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0)
        {
            self.showMessageAlert(message: "Please enter First Name.")
        }
        else if(self.txtLName.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0)
        {
            self.showMessageAlert(message: "Please enter Last Name.")
        }
        else if(self.txtAddress.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0)
        {
            self.showMessageAlert(message: "Please enter Address.")
        }
        else if(self.lblDate.title(for: .normal) == "Select Date")
        {
            self.showMessageAlert(message: "Please select Date.")
        }
        else if(self.txtPhoneNo.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0)
        {
            self.showMessageAlert(message: "Please enter Phone No.")
        }
        else if(self.txtPhoneNo.text?.trimmingCharacters(in: .whitespacesAndNewlines).count != 10)
        {
            self.showMessageAlert(message: "Please enter valid 10 digit Phone No.")
        }
        else if(self.txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0)
        {
            self.showMessageAlert(message: "Please enter Email.")
        }
        else if(!self.txtEmail.isValidEmail())
        {
            self.showMessageAlert(message: "Please enter valid Email.")
        }
        else
        {
            self.callSubmitFormService()
        }
    }
    
    func callSubmitFormService()
    {
        
        var languages = ""
        if(self.btnLangEnglish.isSelected)
        {
            languages = "English"
        }
        if(self.btnLangChinese.isSelected)
        {
            if(languages == "")
            {
                languages = "Chinese"
            }
            else
            {
                languages = languages + ",Chinese"
            }
        }
        
        let dictItem = [
            "first_name" : self.txtFName.text!,
            "last_name" : self.txtLName.text!,
            "address" : self.txtAddress.text!,
            "birth_date" : self.lblDate.title(for: .normal)!,
            "gender" : (self.btnMale.isSelected) ? "Male" : "Female",
            "phone_no" : self.txtPhoneNo.text!,
            "email" : self.txtEmail.text!,
            "languages" : languages
        ] as [String : AnyObject]
        
        let json: JSON = JSON(dictItem)
        print("string converted object is \(json.rawString()!)")
        

        self.view.isUserInteractionEnabled = false
        self.act_indicator.startAnimating()
        
           
        let para = ["form_id" : self.form_id, "data" : json.rawString()!] as [String : Any]
        
        NetworkUtilities.shared.makePOSTRequest(with: API.baseURL + "edit-form", parameters: para) { (response) in
            
            
            print("api is \(API.baseURL + "edit-form") para are \(para)")
            
            if(response.error == nil)
            {
                self.view.isUserInteractionEnabled = true
                self.act_indicator.stopAnimating()
                if(response.result[MainResponseCodeConstant.keyResponseCode].intValue == MainResponseCodeConstant.keyResponseCodeOne)
                {
                    print(response.result)
                    CommonUtility.shared.showErrorAlertOnWindow("Success", message: "Form successfully Edited.")
                    //self.navigationController?.popViewController(animated: false)
                    let previewPDFVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PreviewPDFVC") as! PreviewPDFVC
                    previewPDFVC.pdfURL = response.result["new_form_link"].stringValue
                    previewPDFVC.form_id = self.form_id
                    previewPDFVC.CalledFrom = "Edit"
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

    
    func CallFormDetailService()
    {
        self.view.isUserInteractionEnabled = false
        self.act_indicator.startAnimating()

        NetworkUtilities.shared.makePOSTRequest(with: API.baseURL + "form-details", parameters: ["form_id" : self.form_id]) { (response) in
            
            self.view.isUserInteractionEnabled = true
            self.act_indicator.stopAnimating()

            if(response.error == nil)
            {
                if(response.result[MainResponseCodeConstant.keyResponseCode].intValue == MainResponseCodeConstant.keyResponseCodeOne)
                {
                    print(response.result)
                    let form_detail = response.result["form_data"].dictionaryValue
                    if((form_detail["first_name"]?.exists()) != nil)
                    {
                        self.txtFName.text = form_detail["first_name"]?.stringValue
                    }
                    if((form_detail["last_name"]?.exists()) != nil)
                    {
                        self.txtLName.text = form_detail["last_name"]?.stringValue
                    }
                    if((form_detail["address"]?.exists()) != nil)
                    {
                        self.txtAddress.text = form_detail["address"]?.stringValue
                    }
                    if((form_detail["gender"]?.exists()) != nil)
                    {
                        self.btnMale.isSelected = (form_detail["gender"]?.stringValue == "Male") ?   true : false
                        self.btnFemale.isSelected = (form_detail["gender"]?.stringValue == "Female") ?   true : false
                    }
                    if((form_detail["birth_date"]?.exists()) != nil)
                    {
                        self.lblDate.setTitle(form_detail["birth_date"]?.stringValue, for: .normal)
                    }
                    if((form_detail["phone_no"]?.exists()) != nil)
                    {
                        self.txtPhoneNo.text = form_detail["phone_no"]?.stringValue
                    }
                    if((form_detail["email"]?.exists()) != nil)
                    {
                        self.txtEmail.text = form_detail["email"]?.stringValue
                    }
                    if((form_detail["languages"]?.exists()) != nil)
                    {
                        let langs = form_detail["languages"]?.stringValue.components(separatedBy: ",")
                        if(langs!.contains("English"))
                        {
                            self.btnLangEnglish.isSelected = true
                        }
                        if(langs!.contains("Chinese"))
                        {
                            self.btnLangChinese.isSelected = true
                        }
                    }
                    //"languages" : languages
                  
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
