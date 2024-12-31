//
//  ListFormsVC.swift
//  HHSR
//
//  Created by Intelli on 2023-10-18.
//

import UIKit
import SwiftyJSON
import SearchTextField

class ReportForChargesVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var act_indicator: UIActivityIndicatorView!
    @IBOutlet weak var tblReport : UITableView!
    @IBOutlet var pckView : UIPickerView!
    @IBOutlet weak var vw_clearBG: UIView!
    @IBOutlet weak var vw_header: UIView!
    @IBOutlet weak var vw_filterView: UIView!
    @IBOutlet weak var btn_filter: UIButton!
    @IBOutlet var vw_DatePickerContainer: UIView!
    @IBOutlet weak var lblFilterTitle: UILabel!
    @IBOutlet weak var txt_filterText: UITextField!
    
    var data : [clsChargeReport] = []
    let filterArray = ["No Filter", "Room Number", "Date"]//, "Charged For"]
    let dtpickerWidth : CGFloat = ((UIDevice.current.userInterfaceIdiom == .pad) ? 450 : 300)
    var selectedFilter = "No Filter"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tblReport.register(UINib(nibName: "TblReportForChargesCell", bundle: nil), forCellReuseIdentifier: "TblReportForChargesCell")
        self.tblReport.backgroundColor = .white
        if #available(iOS 13.0, *) {
            self.pckView.overrideUserInterfaceStyle = .light
        }
        self.CallPayableReportService()
        // Do any additional setup after loading the view.
    }
  
    
    func CallPayableReportService()
    {
        self.view.isUserInteractionEnabled = false
        self.act_indicator.startAnimating()
        
        var para = [:] as [String : AnyObject]
        if(self.selectedFilter == "Date")
        {
            para["date"] = self.txt_filterText.text! as AnyObject
        }
        else if(self.selectedFilter == "Room Number")
        {
            para["room_name"] = self.txt_filterText.text! as AnyObject
        }
//        else if(self.selectedFilter == "Charged For")
//        {
//            para["charged_for"] = self.txt_filterText.text! as AnyObject
//        }

        NetworkUtilities.shared.makePOSTRequest(with: API.baseURL + "get-charges-report",parameters: para) { (response) in

            self.view.isUserInteractionEnabled = true
            self.act_indicator.stopAnimating()

            if(response.error == nil)
            {
                if(response.result[MainResponseCodeConstant.keyResponseCode].intValue == MainResponseCodeConstant.keyResponseCodeOne)
                {
                    print(response.result)

                    self.data = response.result["Data"].arrayValue.compactMap(clsChargeReport.init)
                    self.tblReport.reloadData()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "TblReportForChargesCell", for: indexPath) as! TblReportForChargesCell
        cell.selectionStyle = .none
        
        cell.lblRoomAndResident.text = "\(self.data[indexPath.row].RoomNo!) - \(self.data[indexPath.row].ResidentName!)"
        //cell.lblOrderDate.text = "Ordered on : \(self.data[indexPath.row].OrderDate!)"
        
        if(self.data[indexPath.row].IsForGuest! == 1 && self.data[indexPath.row].IsExtraItem == 1 && (self.data[indexPath.row].IsBrkTrayService! == 1 || self.data[indexPath.row].IsLunchTrayService! == 1 || self.data[indexPath.row].IsDinnerTrayService! == 1))
       {
           cell.lblChargedFor.text = "Charged for : Guest, Extra Item, Tray Service"
       }
       else if(self.data[indexPath.row].IsForGuest! == 1 && self.data[indexPath.row].IsExtraItem == 1)
       {
           cell.lblChargedFor.text = "Charged for : Guest, Extra Item"
       }
       else if(self.data[indexPath.row].IsForGuest! == 1 && (self.data[indexPath.row].IsBrkTrayService! == 1 || self.data[indexPath.row].IsLunchTrayService! == 1 || self.data[indexPath.row].IsDinnerTrayService! == 1))
       {
           cell.lblChargedFor.text = "Charged for : Guest, Tray Service"
       }
       else if(self.data[indexPath.row].IsExtraItem == 1 && (self.data[indexPath.row].IsBrkTrayService! == 1 || self.data[indexPath.row].IsLunchTrayService! == 1 || self.data[indexPath.row].IsDinnerTrayService! == 1) && (self.data[indexPath.row].IsBrkEscortService! == 1 || self.data[indexPath.row].IsLunchEscortService! == 1 || self.data[indexPath.row].IsDinnerEscortService! == 1))
       {
            cell.lblChargedFor.text = "Charged for : Extra Item, Tray Service, Escort Service"
       }
       else if(self.data[indexPath.row].IsExtraItem == 1 && (self.data[indexPath.row].IsBrkTrayService! == 1 || self.data[indexPath.row].IsLunchTrayService! == 1 || self.data[indexPath.row].IsDinnerTrayService! == 1))
       {
           cell.lblChargedFor.text = "Charged for : Extra Item, Tray Service"
       }
       else if(self.data[indexPath.row].IsExtraItem == 1 && (self.data[indexPath.row].IsBrkEscortService! == 1 || self.data[indexPath.row].IsLunchEscortService! == 1 || self.data[indexPath.row].IsDinnerEscortService! == 1))
       {
            cell.lblChargedFor.text = "Charged for : Extra Item, Escort Service"
       }
       else if((self.data[indexPath.row].IsBrkTrayService! == 1 || self.data[indexPath.row].IsLunchTrayService! == 1 || self.data[indexPath.row].IsDinnerTrayService! == 1) && (self.data[indexPath.row].IsBrkEscortService! == 1 || self.data[indexPath.row].IsLunchEscortService! == 1 || self.data[indexPath.row].IsDinnerEscortService! == 1))
       {
             cell.lblChargedFor.text = "Charged for : Tray Service, Escort Service"
       }
       else if(self.data[indexPath.row].IsForGuest! == 1)
       {
           cell.lblChargedFor.text = "Charged for : Guest"
       }
       else if(self.data[indexPath.row].IsExtraItem == 1)
       {
           cell.lblChargedFor.text = "Charged for : Extra Item"
       }
       else if(self.data[indexPath.row].IsBrkTrayService! == 1 || self.data[indexPath.row].IsLunchTrayService! == 1 || self.data[indexPath.row].IsDinnerTrayService! == 1)
       {
           cell.lblChargedFor.text = "Charged for : Tray Service"
       }
       else if(self.data[indexPath.row].IsBrkEscortService! == 1 || self.data[indexPath.row].IsLunchEscortService! == 1 || self.data[indexPath.row].IsDinnerEscortService! == 1)
       {
            cell.lblChargedFor.text = "Charged for : Escort Service"
       }
       else
       {
           cell.lblChargedFor.text = ""
       }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let previewPDFVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PreviewPDFVC") as! PreviewPDFVC
//        previewPDFVC.pdfURL = self.data[indexPath.row]["formLink"].stringValue
//        previewPDFVC.form_id = self.data[indexPath.row]["id"].intValue
//        previewPDFVC.isAllowPrint = self.data[indexPath.row]["form_type"]["allow_print"].intValue
//        previewPDFVC.isAllowMail = self.data[indexPath.row]["form_type"]["allow_mail"].intValue
//        previewPDFVC.isAllowFollowUp = self.data[indexPath.row]["is_follow_up_incomplete"].intValue
//        previewPDFVC.CalledFrom = "List"
//        self.navigationController?.pushViewController(previewPDFVC, animated: false)
    }
    
    
    @IBAction func btnBack_Clicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.filterArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.filterArray[row]
    }
    
    @IBAction func btnFilterSelectionClicked(_ sender: Any)
    {
        //self.pckView.reloadAllComponents()
        self.view.endEditing(true)
        self.vw_clearBG.isHidden = false
        self.vw_header.isUserInteractionEnabled = false        
        let wd = UIScreen.main.bounds.size.width
        
        self.vw_DatePickerContainer.frame = CGRect(x: (wd - dtpickerWidth)/2, y: ((UIScreen.main.bounds.size.height - self.vw_DatePickerContainer.frame.size.height)/2), width: dtpickerWidth, height: self.vw_DatePickerContainer.frame.size.height)
                
        self.view.addSubview(self.vw_DatePickerContainer)
        
        
        let idx = self.filterArray.firstIndex(of: self.btn_filter.title(for: .normal)!)
        self.pckView.selectRow(idx ?? 0, inComponent: 0, animated: false)
    }
    
    @IBAction func btnCancelFilterClicked(_ sender: Any)
    {
        self.vw_clearBG.isHidden = true
        self.vw_header.isUserInteractionEnabled = true
        self.vw_DatePickerContainer.removeFromSuperview()
    }
    
    @IBAction func btnSelectFilterClicked(_ sender: Any)
    {
       
        self.vw_clearBG.isHidden = true
        self.vw_header.isUserInteractionEnabled = true
        self.vw_DatePickerContainer.removeFromSuperview()
        
        self.selectedFilter = self.filterArray[self.pckView.selectedRow(inComponent: 0)]
        self.btn_filter.setTitle(self.selectedFilter, for: .normal)
        if(self.selectedFilter == "No Filter")
        {
            self.vw_filterView.isHidden = true
            self.CallPayableReportService()
        }
        else
        {
            self.vw_filterView.isHidden = false
            if(self.selectedFilter == "Room Number")
            {
                self.lblFilterTitle.text = "Enter Room No"
                self.txt_filterText.placeholder = "Room Number"
            }
            else if(self.selectedFilter == "Date")
            {
                self.lblFilterTitle.text = "Enter Date"
                self.txt_filterText.placeholder = "YYYY-MM-DD"
            }
//            else
//            {
//                self.lblFilterTitle.text = "Enter Charged For"
//                self.txt_filterText.placeholder = ""
//            }
            self.txt_filterText.text = ""
        }
            
            
    }
    
    @IBAction func btnApplyFilterClicked(_ sender: Any)
    {
        if(self.txt_filterText.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0)
        {
            self.showMessageAlert(message: "Please enter text to filter.")
        }
        else
        {
            self.CallPayableReportService()
        }
    }
}
