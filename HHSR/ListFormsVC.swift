//
//  ListFormsVC.swift
//  HHSR
//
//  Created by Intelli on 2023-10-18.
//

import UIKit
import SwiftyJSON
import SearchTextField

class ListFormsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var act_indicator: UIActivityIndicatorView!
    @IBOutlet weak var tblFormData : UITableView!
    @IBOutlet var pckView : UIPickerView!
    @IBOutlet weak var vw_clearBG: UIView!
    @IBOutlet weak var vw_header: UIView!
    @IBOutlet var vw_DatePickerContainer: UIView!
    @IBOutlet weak var btnFormType: UIButton!
    @IBOutlet var vw_CompleteContainer: UIView!
    @IBOutlet var CompletedBy : SearchTextField!
    
    let dtpickerWidth : CGFloat = ((UIDevice.current.userInterfaceIdiom == .pad) ? 450 : 300)
    
    var data : [JSON] = []
    var selectedFormId = 0
    var selectedRowForCompleted = 0
    var FormListFrom = ""
    var allFormArray = AppDelegate.sharedDelegate().arFormList
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btnFormType.setTitle("All Forms", for: .normal)
        self.allFormArray.insert(clsForms(formId: 0, formName: "All Forms"), at: 0)
        
        self.tblFormData.register(UINib(nibName: "TblListFormsCell", bundle: nil), forCellReuseIdentifier: "TblListFormsCell")
        self.tblFormData.backgroundColor = .white
        self.CallFormService()
        
        if #available(iOS 13.0, *) {
            self.pckView.overrideUserInterfaceStyle = .light
        } 
        
        NotificationCenter.default.addObserver(self, selector: #selector(refreshForm), name: NSNotification.Name(rawValue: NotificationNamesConstant.keyRefreshFormList), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(attachmentUpdated), name: NSNotification.Name(rawValue: NotificationNamesConstant.keyAttachmentUpdated), object: nil)
        
        self.CompletedBy.theme.bgColor = .white
        self.CompletedBy.theme.font = UIFont(name: "Helvetica", size: (UIDevice.current.userInterfaceIdiom == .pad) ? 23.0 : 18.0)!
        self.CompletedBy.filterStrings(AppDelegate.sharedDelegate().arLoggedBy)

        // Do any additional setup after loading the view.
    }
    
    @objc func refreshForm(notification : NSNotification)
    {
        self.CallFormService()
    }
    
    @objc func attachmentUpdated(notification : NSNotification)
    {
        let uinfo = notification.userInfo
        
        let idx = self.data.firstIndex(where: { $0["id"].intValue ==  uinfo![PushNotificationKeysConstant.keyFormId] as! Int })
        let newLink = uinfo![PushNotificationKeysConstant.keyFormPDFURL] as! String
        self.data[idx!]["formLink"] = JSON(newLink)
    }
    
    func CallFormService()
    {
        self.view.isUserInteractionEnabled = false
        self.act_indicator.startAnimating()

        NetworkUtilities.shared.makePOSTRequest(with: API.baseURL + "list-forms",parameters: ["form_type" : self.selectedFormId]) { (response) in

            self.view.isUserInteractionEnabled = true
            self.act_indicator.stopAnimating()
            
            if(response.error == nil)
            {
                if(response.result[MainResponseCodeConstant.keyResponseCode].intValue == MainResponseCodeConstant.keyResponseCodeOne)
                {
                    print(response.result)
                    
                    self.data = response.result["list"].arrayValue
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TblListFormsCell", for: indexPath) as! TblListFormsCell
        cell.selectionStyle = .none
    
        //form_response
        let form_detail = self.data[indexPath.row]["jsonData"]
        let form_detail2 = JSON(self.data[indexPath.row]["jsonData"])
        
        //let form_detail = allData["form_response"]?.dictionaryValue
        
        print("form response is \(form_detail) and created date is \(self.data[indexPath.row]["created_at"]) and 2 val is \(form_detail2)")
        
        if(self.data[indexPath.row]["form_type_id"] == 1)
        {
            cell.lblCategory.text = "\(form_detail2["incident_involved"])"
            //if(form_detail2["followUp_issue"] == "" && form_detail2["followUp_findings"] == "" && form_detail2["followUp_possible_solutions"] == "" && form_detail2["followUp_action_plan"] == "" && form_detail2["followUp_examine_result"] == "")
            if(AppDelegate.sharedDelegate().UserRole == "concierge" || AppDelegate.sharedDelegate().UserRole == "nurse")
            {}
            else if(self.data[indexPath.row]["is_follow_up_incomplete"] == 1)
            {
                cell.contentView.backgroundColor = UIColor.ColorCodes.followUpBgColor
            }
            else
            {
                cell.contentView.backgroundColor = .white
            }
            cell.btnEdit.isHidden = false
            cell.btnDelete.isHidden = false
            cell.btnDelete.setBackgroundImage(UIImage(named: "Delete"), for: .normal)
        }
        else if(self.data[indexPath.row]["form_type_id"] == 3)
        {
            cell.contentView.backgroundColor = .white
            cell.lblCategory.text = "\(form_detail2["suite_number"]) - \(form_detail2["first_resident_name_first_name"]) \(form_detail2["first_resident_name_last_name"])"
            cell.btnEdit.isHidden = false
            cell.btnDelete.isHidden = false
            cell.btnDelete.setBackgroundImage(UIImage(named: "Delete"), for: .normal)
        }
        else
        {
            cell.contentView.backgroundColor = .white
            cell.lblCategory.text = "\(form_detail2["room_number"]) - \(form_detail2["resident_name"])"
            cell.btnEdit.isHidden = true
            if(form_detail2["is_completed"] == 0)
            {
                cell.btnDelete.isHidden = false
            }
            else
            {
                cell.btnDelete.isHidden = true
            }
            cell.btnDelete.setBackgroundImage(UIImage(named: "Complete"), for: .normal)
        }
        //"\(self.data[indexPath.row]["form_response"]["first_name"]) \(form_detail2["incident_involved"])"
        
        let dtFormatter = DateFormatter()
        dtFormatter.dateFormat = "yyyy-MM-dd H:mm:ss"
        dtFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        var dt = "\(self.data[indexPath.row]["created_at"])"
        if let date = dtFormatter.date(from: dt)
        {
            dtFormatter.timeZone = TimeZone.current
            dtFormatter.dateFormat = "yyyy-MM-dd h:mm a"
            dt = dtFormatter.string(from: date)
        }
        
//        if(dt == NSNull)
//        {
//            dt = "2023-09-16 14:15:16" 
//        }
        cell.lblItem.text = dt
        
        cell.btnEdit.tag =  indexPath.row
        cell.btnEdit.addTarget(self, action: #selector(EditForm), for: .touchUpInside)
        cell.btnDelete.tag = indexPath.row
        cell.btnDelete.addTarget(self, action: #selector(DeleteForm), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let previewPDFVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PreviewPDFVC") as! PreviewPDFVC
        previewPDFVC.pdfURL = self.data[indexPath.row]["formLink"].stringValue
        previewPDFVC.form_id = self.data[indexPath.row]["id"].intValue
        previewPDFVC.isAllowPrint = self.data[indexPath.row]["form_type"]["allow_print"].intValue
        previewPDFVC.isAllowMail = self.data[indexPath.row]["form_type"]["allow_mail"].intValue
        previewPDFVC.isAllowFollowUp = self.data[indexPath.row]["is_follow_up_incomplete"].intValue
        previewPDFVC.CalledFrom = "List"
        self.navigationController?.pushViewController(previewPDFVC, animated: false)
    }
    
    @objc func EditForm(_ sender: Any)
    {
        let btn = sender as! UIButton
        if(self.data[btn.tag]["form_type_id"] == 1)
        {
            //let form_detail2 = JSON(self.data[btn.tag]["jsonData"])
            let EditFormVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UnusalOccuranceVC") as! UnusalOccuranceVC
            EditFormVC.form_id = self.data[btn.tag]["id"].intValue
            EditFormVC.calledFrom = "Edit"
            //if(form_detail2["followUp_issue"] == "" && form_detail2["followUp_findings"] == "" && form_detail2["followUp_possible_solutions"] == "" && form_detail2["followUp_action_plan"] == "" && form_detail2["followUp_examine_result"] == "")
            if(self.data[btn.tag]["is_follow_up_incomplete"] == 1)
            {
                EditFormVC.isFollowUpIncomplete = true
            }
            else
            {
                EditFormVC.isFollowUpIncomplete = false
            }
            self.navigationController?.pushViewController(EditFormVC, animated: false)
        }
        else if(self.data[btn.tag]["form_type_id"] == 3)
        {
            let EditFormVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MoveInSummaryVC") as! MoveInSummaryVC
            EditFormVC.form_id = self.data[btn.tag]["id"].intValue
            EditFormVC.calledFrom = "Edit"
            self.navigationController?.pushViewController(EditFormVC, animated: false)
        }
        else if(self.data[btn.tag]["form_type_id"] == 2)
        {
            let EditFormVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LogFormVC") as! LogFormVC//LogFormVC
           // EditFormVC.form_id = self.data[btn.tag]["id"].intValue
           // EditFormVC.calledFrom = "Edit"
            self.navigationController?.pushViewController(EditFormVC, animated: false)
        }
    }
    
    @objc func DeleteForm(_ sender: Any)
    {
        let btn = sender as! UIButton
        
        if(btn.backgroundImage(for: .normal) == UIImage(named: "Complete"))
        {
            self.selectedRowForCompleted = btn.tag
            self.view.endEditing(true)
            self.vw_clearBG.isHidden = false
            self.vw_header.isUserInteractionEnabled = false
            let wd = UIScreen.main.bounds.size.width
            
            self.vw_CompleteContainer.frame = CGRect(x: (wd - dtpickerWidth)/2, y: ((UIScreen.main.bounds.size.height - self.vw_CompleteContainer.frame.size.height)/2), width: dtpickerWidth, height: self.vw_CompleteContainer.frame.size.height)
            
            self.view.addSubview(self.vw_CompleteContainer)
        }
        else
        {
            let alert = UIAlertController(title: "Delete Confirmation", message: "Are you sure to delete the Form?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
                self.CallDeleteFormService(row: btn.tag)
            }))
            alert.addAction(UIAlertAction(title: "No", style: .default, handler: { (action) in
            }))
            
            DispatchQueue.main.async
            {
                if(UIDevice.current.model.range(of: "iPad") != nil)
                {
                    alert.popoverPresentationController?.sourceView = self.view
                    alert.popoverPresentationController?.sourceRect = self.view.bounds
                    self.present(alert, animated: true, completion: nil)
                }
                else
                {
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    func CallDeleteFormService(row : Int)
    {
        self.view.isUserInteractionEnabled = false
        self.act_indicator.startAnimating()

        NetworkUtilities.shared.makePOSTRequest(with: API.baseURL + "delete-form",parameters: ["form_id" : self.data[row]["id"].intValue]) { (response) in

            self.view.isUserInteractionEnabled = true
            self.act_indicator.stopAnimating()
            
            if(response.error == nil)
            {
                if(response.result[MainResponseCodeConstant.keyResponseCode].intValue == MainResponseCodeConstant.keyResponseCodeOne)
                {
                    print(response.result)
                    
                    self.data.remove(at: [row])
                    self.tblFormData.reloadData()
                        //.deleteRows(at: [IndexPath(row: row, section: 0)], with: .none)
                    self.showMessageAlert("Success", message: "Form successfully Deleted.")
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
    
    @IBAction func btnAddForm_Clicked(_ sender: Any)
    {
        if(self.btnFormType.title(for: .normal) == "All Forms")
        {
           // self.showMessageAlert(message: "Please Select Form Type.")
            self.FormListFrom = "Add"
            self.btnFormSelectionClicked(sender)
        }
        else if(self.btnFormType.title(for: .normal) == "Log Form")
        {
            let submitFormVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LogFormVC") as! LogFormVC//LogFormVC
            //submitFormVC.pdfURL = "https://www.tutorialspoint.com/swift/swift_tutorial.pdf"
            self.navigationController?.pushViewController(submitFormVC, animated: false)
        }
        else if(self.btnFormType.title(for: .normal) == "MoveIn Summary Form")
        {
            let submitFormVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MoveInSummaryVC") as! MoveInSummaryVC
            self.navigationController?.pushViewController(submitFormVC, animated: false)
        }
        else
        {
            let submitFormVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UnusalOccuranceVC") as! UnusalOccuranceVC
            //submitFormVC.pdfURL = "https://www.tutorialspoint.com/swift/swift_tutorial.pdf"
            self.navigationController?.pushViewController(submitFormVC, animated: false)
        }
       
    }
    
    @IBAction func btnBack_Clicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return (self.FormListFrom == "Add") ? AppDelegate.sharedDelegate().arFormList.count : self.allFormArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return (self.FormListFrom == "Add") ? AppDelegate.sharedDelegate().arFormList[row].FormName : self.allFormArray[row].FormName
    }
    
    
    @IBAction func btnFormSelectionClicked(_ sender: Any)
    {
        self.pckView.reloadAllComponents()
        self.view.endEditing(true)
        self.vw_clearBG.isHidden = false
        self.vw_header.isUserInteractionEnabled = false
        let wd = UIScreen.main.bounds.size.width
        
        self.vw_DatePickerContainer.frame = CGRect(x: (wd - dtpickerWidth)/2, y: ((UIScreen.main.bounds.size.height - self.vw_DatePickerContainer.frame.size.height)/2), width: dtpickerWidth, height: self.vw_DatePickerContainer.frame.size.height)
                
        self.view.addSubview(self.vw_DatePickerContainer)
        
        if(self.btnFormType.title(for: .normal) != "All Forms")
        {
            if(self.FormListFrom == "Add")
            {
                let idx = AppDelegate.sharedDelegate().arFormList.map({ $0.FormName }).firstIndex(of: self.btnFormType.title(for: .normal))
                self.pckView.selectRow(idx ?? 0, inComponent: 0, animated: false)
            }
            else
            {
                let idx = self.allFormArray.map({ $0.FormName }).firstIndex(of: self.btnFormType.title(for: .normal))
                self.pckView.selectRow(idx ?? 0, inComponent: 0, animated: false)
            }
        }
        else
        {
            self.pckView.selectRow(0, inComponent: 0, animated: false)
        }
    }
    
    
    @IBAction func btnCompleteLogClicked(_ sender: Any)
    {
        self.vw_clearBG.isHidden = true
        self.vw_header.isUserInteractionEnabled = true
        self.vw_CompleteContainer.removeFromSuperview()
    
       
        if(self.CompletedBy.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0)
        {
            self.showMessageAlert(message: "Please enter Completed By.")
        }
        else
        {
              self.callLogCompletedService()
        }
    }
    
    @IBAction func btnCancelCompleteClicked(_ sender: Any)
    {
        self.vw_clearBG.isHidden = true
        self.vw_header.isUserInteractionEnabled = true
        self.vw_CompleteContainer.removeFromSuperview()
        self.CompletedBy.text = ""
    }
    
    @IBAction func btnCancelFormClicked(_ sender: Any)
    {
        self.FormListFrom = ""
        self.vw_clearBG.isHidden = true
        self.vw_header.isUserInteractionEnabled = true
        self.vw_DatePickerContainer.removeFromSuperview()
    }
    
    @IBAction func btnSelectFormClicked(_ sender: Any)
    {
       
        self.vw_clearBG.isHidden = true
        self.vw_header.isUserInteractionEnabled = true
        self.vw_DatePickerContainer.removeFromSuperview()
            
        let selectedForm = (self.FormListFrom == "Add") ? AppDelegate.sharedDelegate().arFormList[self.pckView.selectedRow(inComponent: 0)] : self.allFormArray[self.pckView.selectedRow(inComponent: 0)]
        self.selectedFormId = selectedForm.FormId
        self.btnFormType.setTitle(selectedForm.FormName, for: .normal)
        self.CallFormService()
        
        if(self.FormListFrom == "Add")
        {
            self.FormListFrom = ""
//            let formName = AppDelegate.sharedDelegate().arFormList[ self.pckView.selectedRow(inComponent: 0)].FormName
//
//            if(formName == "All Forms")
//            {
//                self.showMessageAlert(message: "Please Select Form Type.")
//            }
            if(selectedForm.FormName == "Log Form")
            {
                let submitFormVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LogFormVC") as! LogFormVC//LogFormVC
                //submitFormVC.pdfURL = "https://www.tutorialspoint.com/swift/swift_tutorial.pdf"
                self.navigationController?.pushViewController(submitFormVC, animated: false)
            }
            else if(selectedForm.FormName == "MoveIn Summary Form")
            {
                let submitFormVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MoveInSummaryVC") as! MoveInSummaryVC
                self.navigationController?.pushViewController(submitFormVC, animated: false)
            }
            else
            {
                let submitFormVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UnusalOccuranceVC") as! UnusalOccuranceVC
                //submitFormVC.pdfURL = "https://www.tutorialspoint.com/swift/swift_tutorial.pdf"
                self.navigationController?.pushViewController(submitFormVC, animated: false)
            }
        }
            
    }
    
    func callLogCompletedService()
    {

        self.view.isUserInteractionEnabled = false
        self.act_indicator.startAnimating()
           //
        let para = ["completed_by" : "\(self.CompletedBy.text!.capitalized)", "form_id" : "\(self.data[self.selectedRowForCompleted]["id"])"] as [String : Any]
        
        NetworkUtilities.shared.makePOSTRequest(with: API.baseURL + "complete-log", parameters: para) { (response) in
            
            
            print("api is \(API.baseURL + "complete-log") para are \(para)")
            
            if(response.error == nil)
            {
                self.view.isUserInteractionEnabled = true
                self.act_indicator.stopAnimating()
                if(response.result[MainResponseCodeConstant.keyResponseCode].intValue == MainResponseCodeConstant.keyResponseCodeOne)
                {
                    print(response.result)
                    self.data[self.selectedRowForCompleted]["jsonData"] = response.result["jsonData"]
                    self.data[self.selectedRowForCompleted]["formLink"] = response.result["formLink"]
                    self.tblFormData.reloadRows(at: [IndexPath(row: self.selectedRowForCompleted, column: 0)], with: .none)
                    self.showMessageAlert("Success", message: "Log completed successfully.")
                    
                    if(AppDelegate.sharedDelegate().arLoggedBy.map({$0.lowercased()}).contains(self.CompletedBy.text!.lowercased()))
                    {
                    }
                    else
                    {
                        AppDelegate.sharedDelegate().arLoggedBy.append(self.CompletedBy.text!.capitalized)
                        CommonUtility.shared.setLoggedBy(str: AppDelegate.sharedDelegate().arLoggedBy.joined(separator: "*arLog*"))
                        self.CompletedBy.filterStrings(AppDelegate.sharedDelegate().arLoggedBy)
                    }
                    
                    self.CompletedBy.text = ""
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

//"{\"log_text\":\"Test for 101\",\"room_number\":\"101\",\"action_taken\":\"\",\"is_completed\":1,\"resident_name\":\"Yu Suet Fong Wong\",\"follow_up_required\":\"\",\"completed_by\":\"Sal\",\"completed_at\":\"2023-12-18 08:34:56\"}"



//'{\"log_text\": \"Test for 101\", \"room_number\": \"101\", \"action_taken\": \"\", \"is_completed\": 0, \"resident_name\": \"Yu Suet Fong Wong\", \"follow_up_required\": \"\"}';

//'{\"log_text\": \"With details\", \"room_number\": \"311\", \"action_taken\": \"informed\", \"is_completed\": 0, \"resident_name\": \"Ainslie Peach\", \"follow_up_required\": \"no\"}';

//'{\"log_text\": \"Test\", \"room_number\": \"316\", \"action_taken\": \"\", \"is_completed\": 0, \"resident_name\": \"Josephine Cho\", \"follow_up_required\": \"\"}';

//'\"{\\\"log_text\\\":\\\"Test\\\",\\\"logged_by\\\":\\\"R Oza\\\",\\\"room_number\\\":\\\"101\\\",\\\"action_taken\\\":\\\"\\\",\\\"is_completed\\\":1,\\\"resident_name\\\":\\\"Yu Suet Fong Wong\\\",\\\"follow_up_required\\\":\\\"\\\",\\\"completed_by\\\":\\\"user1\\\",\\\"completed_at\\\":\\\"2023-12-16 06:59:09\\\"}\"'

//'\"{\\\"log_text\\\":\\\"Issue 1\\\",\\\"logged_by\\\":\\\"Rahi O\\\",\\\"room_number\\\":\\\"102\\\",\\\"action_taken\\\":\\\"\\\",\\\"is_completed\\\":1,\\\"resident_name\\\":\\\"Chee Ping Fung\\\",\\\"follow_up_required\\\":\\\"\\\",\\\"completed_by\\\":\\\"user1\\\",\\\"completed_at\\\":\\\"2023-12-16 07:04:51\\\"}\"';

//'\"{\\\"log_text\\\":\\\"Log details\\\",\\\"logged_by\\\":\\\"Sal\\\",\\\"room_number\\\":\\\"311\\\",\\\"action_taken\\\":\\\"\\\",\\\"is_completed\\\":1,\\\"resident_name\\\":\\\"Ainslie Peach\\\",\\\"follow_up_required\\\":\\\"\\\",\\\"completed_by\\\":\\\"user12\\\",\\\"completed_at\\\":\\\"2023-12-16 07:11:15\\\"}\"';



//"{\"log_text\":\"Log details\",\"logged_by\":\"Sal\",\"room_number\":\"311\",\"action_taken\":\"\",\"is_completed\":1,\"resident_name\":\"Ainslie Peach\",\"follow_up_required\":\"\",\"completed_by\":\"user12\",\"completed_at\":\"2023-12-16 07:11:15\"}"


//{"log_text": "Data check", "logged_by": "R Oza", "room_number": "106", "action_taken": "checking ", "is_completed": 0, "resident_name": "Lai Ching Yau", "follow_up_required": ""}
