//
//  SubmitFormVC.swift
//  HHSR
//
//  Created by Intelli on 2024-03-18.
//

import UIKit
import SwiftyJSON

class SubmitFormVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    
    @IBOutlet weak var act_indicator: UIActivityIndicatorView!
    @IBOutlet weak var tblFormData : UITableView!
    @IBOutlet weak var cns_btnSubmitWidth: NSLayoutConstraint!
    @IBOutlet weak var btnBack: UIButton!
    
    var arFields : [clsFormFields] = []
    var dictItems: [[String:Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(Bool.random() == true)
        {
            var dictItem = [
            "fieldLabel" : "First Name",
            "fieldType" : "textfield"
            ] as [String : Any]
            
            dictItems.append(dictItem)
            
            dictItem = [
            "fieldLabel" : "Last Name",
            "fieldType" : "textfield"
            ] as [String : Any]
            
            dictItems.append(dictItem)
        }
        else
        {
            let responseString = "[\n {\n  \"fieldLabel\" : \"First Name\",\n  \"fieldType\" : \"textfield\"\n  },\n {\n  \"fieldLabel\" : \"Surname\",\n  \"fieldType\" : \"textfield\"\n  }]"
          
            //let responseString = "[\n {\n  \"fieldLabel\" : \"First Name\",\n  \"fieldType\" : \"textfield\",\n   \"fieldVal\" : \"a\",\n  }]"
            //"[\n {\n  \"fieldLabel\" : \"First Name\",\n  \"fieldType\" : \"textfield\",\n   \"fieldVal\" : \"a\"\n  },\n {\n  \"fieldLabel\" : \"Surname\",\n  \"fieldType\" : \"textfield\",\n   \"fieldVal\" : \"a\"\n  }]"
            
            let json = JSON(parseJSON: responseString)
            
            for i in 0..<json.count
            {
                dictItems.append(json[i].dictionaryObject!)
            }
            
//            if let dataFromString = responseString.data(using: String.Encoding.utf8, allowLossyConversion: false) {
//                JSON(data: dataFromString)
//                var labels = json.dictionaryObject! as! [String: String]
//                print(labels)
//            }
        }
        
//        for dic in dictItems{
//            let value = clsFormFields(fromDictionary: dic)
//            self.arFields.append(value)
//        }
        
//      self.arFields.append(clsFormFields(fieldLabel: "First Name", fieldType: "textfield"))
//      self.arFields.append(clsFormFields(fieldLabel: "Last Name", fieldType: "textfield"))
        
        self.view.backgroundColor = .white
        self.tblFormData.backgroundColor = .white
        
        if(UIDevice.current.userInterfaceIdiom == .pad)
        {
            self.cns_btnSubmitWidth.constant = (UIScreen.main.bounds.size.width * 20.0) / 59.0
        }
        else
        {
            self.cns_btnSubmitWidth.constant = (UIScreen.main.bounds.size.width * 30.0) / 59.0
        }
        
        self.tblFormData.register(UINib(nibName: "TblFormTxtFieldCell", bundle: nil), forCellReuseIdentifier: "TblFormTxtFieldCell")

        self.CallFieldListService()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnBack_Clicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func btnSubmit_Clicked(_ sender: Any) {
        self.view.endEditing(true)
        self.callSubmitFormService()
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arFields.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TblFormTxtFieldCell", for: indexPath) as! TblFormTxtFieldCell
        cell.selectionStyle = .none
        
        cell.lblTitle.text = self.arFields[indexPath.row].FieldLabel
        cell.txtData.tag = indexPath.row
        cell.txtData.delegate = self
        
        return cell
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //self.showMessageAlert(message: "tag is \(textField.tag) and val is \(textField.text)")
        let idx = textField.tag
        self.arFields[idx].FieldVal = textField.text!
    }
    
   //let responseString = "[\n {\n  \"fieldLabel\" : \"First Name\",\n  \"fieldType\" : \"textfield\",\n   \"fieldVal\" : \"a\",\n  }]"
    //"{\"1\":\"Location 1\",\"2\":\"Location 2\",\"3\":\"Location 3\"}"
   

    
    func callSubmitFormService()
    {
     
        self.dictItems.removeAll()
        self.arFields.forEach({
            self.dictItems.append($0.toDictionary())
        })


        let json: JSON = JSON(self.dictItems)
        print("string converted object is \(json.rawString()!)")


        self.view.isUserInteractionEnabled = false
        self.act_indicator.startAnimating()
        //self.showMessageAlert(message: "json is \(json.rawString()!)")
        //API.general_form_submit_api

        let para = ["form_type" : "1", "data" : json.rawString()!] as [String : Any]

        
        self.showMessageAlert(message: "para val is :  \(para)")

        NetworkUtilities.shared.makePOSTRequest(with: API.baseURL + "temp-form-save", parameters: para) { (response) in

            print("api is \(API.baseURL + API.general_form_submit_api) para are \(para)")

            if(response.error == nil)
            {
                self.view.isUserInteractionEnabled = true
                self.act_indicator.stopAnimating()
                if(response.result[MainResponseCodeConstant.keyResponseCode].intValue == MainResponseCodeConstant.keyResponseCodeOne)
                {
                                       
                    print(response.result)
                    //CommonUtility.shared.showErrorAlertOnWindow(
                    self.showMessageAlert(message: "Form successfully Submitted")
                    //self.navigationController?.popViewController(animated: false)
//                    let previewPDFVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PreviewPDFVC") as! PreviewPDFVC
//                    previewPDFVC.pdfURL = response.result["form_link"].stringValue
//                    previewPDFVC.form_id = response.result["submitted_form_id"].intValue
//                    let idx = AppDelegate.sharedDelegate().arFormList.firstIndex(where: { $0.FormId == 2 })
//                    previewPDFVC.isAllowPrint = AppDelegate.sharedDelegate().arFormList[idx!].IsPrintAllowed
//                    previewPDFVC.isAllowMail = AppDelegate.sharedDelegate().arFormList[idx!].IsMailAllowed
//                    previewPDFVC.CalledFrom = "Add"
//                    self.navigationController?.pushViewController(previewPDFVC, animated: false)
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
    
    func CallFieldListService()
    {
        self.view.isUserInteractionEnabled = false
        self.act_indicator.startAnimating()

       
        NetworkUtilities.shared.makeGETRequest(with: API.baseURL + "get_form_fields") { (response) in
            if(response.error == nil)
            {
                self.view.isUserInteractionEnabled = true
                self.act_indicator.stopAnimating()
                if(response.result[MainResponseCodeConstant.keyResponseCode].intValue == MainResponseCodeConstant.keyResponseCodeOne)
                {                                        
                    self.arFields.removeAll()
                    self.arFields.append(contentsOf: response.result["body"].arrayValue.compactMap(clsFormFields.init))
                    self.tblFormData.reloadData()
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
