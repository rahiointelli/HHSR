//
//  SearchRoomVC.swift
//  DiningApp
//
//  Created by Intelli on 2023-01-11.
//

import UIKit
import SwiftyJSON
import SearchTextField

class EditResidentVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var act_indicator: UIActivityIndicatorView!
    @IBOutlet weak var txtFoodTexture : UITextView!
    @IBOutlet weak var txtSplInst : UITextView!
    @IBOutlet weak var txtAllergyInfo : UITextView!
    @IBOutlet weak var vw_clearBG: UIView!
    @IBOutlet weak var vw_header: UIView!
    @IBOutlet weak var lblRoomName: UILabel!
    @IBOutlet weak var lblFoodTxt: UILabel!
    @IBOutlet weak var lblSplInst: UILabel!
    @IBOutlet weak var lblAllergyInfo: UILabel!
    @IBOutlet weak var btnSubmit: UIButton!
    
    let dtpickerWidth : CGFloat = ((UIDevice.current.userInterfaceIdiom == .pad) ? 450 : 300)
    var selectedRoomName : String = ""
    var selectedRoomID : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lblFoodTxt.text = "foodTexture".localizeString(string: AppDelegate.sharedDelegate().LanguagePrefCode)
        self.lblSplInst.text = "splInst".localizeString(string: AppDelegate.sharedDelegate().LanguagePrefCode)
        self.lblAllergyInfo.text = "allergyInfo".localizeString(string: AppDelegate.sharedDelegate().LanguagePrefCode)
        self.btnSubmit.setTitle("submit".localizeString(string: AppDelegate.sharedDelegate().LanguagePrefCode), for: .normal)
        
        self.lblRoomName.text = "# \(self.selectedRoomName)"
        self.txtFoodTexture.backgroundColor = UIColor.white
        self.txtFoodTexture.layer.borderWidth = 1.0
        self.txtFoodTexture.layer.borderColor = UIColor.black.cgColor
        self.txtSplInst.backgroundColor = UIColor.white
        self.txtSplInst.layer.borderWidth = 1.0
        self.txtSplInst.layer.borderColor = UIColor.black.cgColor
        self.txtAllergyInfo.backgroundColor = UIColor.white
        self.txtAllergyInfo.layer.borderWidth = 1.0
        self.txtAllergyInfo.layer.borderColor = UIColor.black.cgColor
        
        self.CallGetResDetails()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
            print("in disappear")
    }
    
    
    @IBAction func btnBack_Clicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    func CallGetResDetails()
    {
        self.view.isUserInteractionEnabled = false
        self.act_indicator.startAnimating()

     
        NetworkUtilities.shared.makeGETRequest(with: API.baseURL + "\(self.selectedRoomID)/get-room-details") { (response) in
            
            self.view.isUserInteractionEnabled = true
            self.act_indicator.stopAnimating()
            if(response.error == nil)
            {
                if(response.result[MainResponseCodeConstant.keyResponseCode].intValue == MainResponseCodeConstant.keyResponseCodeOne)
                {
                    print(response.result)
                    self.txtFoodTexture.text = response.result["Data"]["food_texture"].stringValue
                    self.txtSplInst.text = response.result["Data"]["special_instrucations"].stringValue
                    self.txtAllergyInfo.text = response.result["Data"]["allergy_info"].stringValue
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
    
    
    @IBAction func btnSubmit_Clicked(_ sender: Any)
    {
        self.callUpdateRoomDetails()
    }
    
    func callUpdateRoomDetails()
    {
        self.view.isUserInteractionEnabled = false
        self.act_indicator.startAnimating()


        let para = ["food_texture" : self.txtFoodTexture.text!, "special_instrucations" : self.txtSplInst.text!, "allergy_info" : self.txtAllergyInfo.text!] as [String : Any]
        
        //self.showMessageAlert(message:"para are \(para)")

        NetworkUtilities.shared.makePOSTRequest(with: API.baseURL + "\(self.selectedRoomID)/update-room-details", parameters: para) { (response) in


            print("api is \(API.baseURL + API.general_form_submit_api) para are \(para)")

            if(response.error == nil)
            {
                self.view.isUserInteractionEnabled = true
                self.act_indicator.stopAnimating()
                if(response.result[MainResponseCodeConstant.keyResponseCode].intValue == MainResponseCodeConstant.keyResponseCodeOne)
                {
                         
                    print(response.result)
                    CommonUtility.shared.showErrorAlertOnWindow("Success", message: "Details successfully Updated.")
                    self.navigationController?.popViewController(animated: false)
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


//api is http://hamiltondinnerapp.intellidt.com/api/general-form-submit para are ["form_type": "1", "data": "[\n  {\n    \"address\" : \"Cc\",\n    \"gender\" : \"Male\",\n    \"languages\" : \"English\",\n    \"first_name\" : \"bb\",\n    \"last_name\" : \"aa\",\n    \"email\" : \"bb@aa.com\",\n    \"birth_date\" : \"02 Nov 2023\",\n    \"phone_no\" : \"3434343434\"\n  }\n]"]
