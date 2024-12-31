//
//  SearchRoomVC.swift
//  DiningApp
//
//  Created by Intelli on 2023-01-11.
//

import UIKit
import SwiftyJSON
import PencilKit

class MoveInSummaryVC: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var act_indicator: UIActivityIndicatorView!
    @IBOutlet var dtPicker : UIDatePicker!
    @IBOutlet weak var vw_clearBG: UIView!
    @IBOutlet weak var vw_header: UIView!
    @IBOutlet var vw_DatePickerContainer: UIView!
    @IBOutlet weak var txt_suiteNumber : UITextField!
    @IBOutlet weak var txt_salseName : UITextField!
    @IBOutlet weak var btnContractYearly : UIButton!
    @IBOutlet weak var btnContractMonthly : UIButton!
    @IBOutlet weak var btnContractWeekly : UIButton!
    @IBOutlet weak var btnContractDaily : UIButton!
    @IBOutlet weak var btnDt_CntSigning : UIButton!
    @IBOutlet weak var btnDt_TenancyCom : UIButton!
    @IBOutlet weak var btnDt_CntExpiry : UIButton!
    @IBOutlet weak var txtres1_FName : UITextField!
    @IBOutlet weak var txtres1_MName : UITextField!
    @IBOutlet weak var txtres1_LName : UITextField!
    @IBOutlet weak var btnres1_DOB : UIButton!
    @IBOutlet weak var btnHas2ndResident : UIButton!
    @IBOutlet weak var vw_res2_FName : UIView!
    @IBOutlet weak var vw_res2_MName : UIView!
    @IBOutlet weak var vw_res2_LName : UIView!
    @IBOutlet weak var vw_res2_DOB : UIView!
    @IBOutlet weak var cns_stkRes2Bottom : NSLayoutConstraint!
    @IBOutlet weak var txtres2_FName : UITextField!
    @IBOutlet weak var txtres2_MName : UITextField!
    @IBOutlet weak var txtres2_LName : UITextField!
    @IBOutlet weak var btnres2_DOB : UIButton!
    @IBOutlet weak var btnPaymentReceived : UIButton!
    @IBOutlet weak var vw_PaymentChqNum : UIView!
    @IBOutlet weak var vw_PaymentChqDate : UIView!
    @IBOutlet weak var vw_PaymentChqTotal : UIView!
    @IBOutlet weak var cns_stkPaymentReceivedBottom : NSLayoutConstraint!
    @IBOutlet weak var txtPaymentChqNum : UITextField!
    @IBOutlet weak var btnPaymentChqDate : UIButton!
    @IBOutlet weak var txtPaymentChqTotal : UITextField!
    @IBOutlet weak var txtMonthlyRate : UITextField!
    @IBOutlet weak var txtCarePlanRate : UITextField!
    @IBOutlet weak var txt1TimeMoveInFee : UITextField!
    @IBOutlet weak var txtParkingRate : UITextField!
    @IBOutlet weak var txtParkingQuantity : UITextField!
    @IBOutlet weak var txtScooterRate : UITextField!
    @IBOutlet weak var txtScooterQuantity : UITextField!
    @IBOutlet weak var txtWindowScreenRate : UITextField!
    @IBOutlet weak var txtWindowScreenQuantity : UITextField!
    @IBOutlet weak var txtGrabBarRate : UITextField!
    @IBOutlet weak var txtGrabBarQuantity : UITextField!
    @IBOutlet weak var txtPaymentOthers : UITextField!
    @IBOutlet weak var btnDepositReceived : UIButton!
    @IBOutlet weak var vw_DepositChqNum : UIView!
    @IBOutlet weak var vw_DepositChqDate : UIView!
    @IBOutlet weak var vw_DepositChqTotal : UIView!
    @IBOutlet weak var cns_stkDepositReceivedBottom : NSLayoutConstraint!
    @IBOutlet weak var txtDepositChqNum : UITextField!
    @IBOutlet weak var btnDepositChqDate : UIButton!
    @IBOutlet weak var txtDepositChqTotal : UITextField!
    @IBOutlet weak var txtHalfMRentalDepositfor1stRes : UITextField!
    @IBOutlet weak var txtHalfMCarePlan : UITextField!
    @IBOutlet weak var vw_HalfMRentalDepositfor2ndRes : UIView!
    @IBOutlet weak var txtHalfMRentalDepositfor2ndRes : UITextField!
    @IBOutlet weak var cns_vwHalfMRentalDepositfor2ndResBottom : NSLayoutConstraint!
    @IBOutlet weak var cns_hgt_txtHalfMRentalDepositfor2ndRes : NSLayoutConstraint!
    @IBOutlet weak var txtMoveInOut : UITextField!
    @IBOutlet weak var txtElpasRate : UITextField!
    @IBOutlet weak var txtElpasQuantity : UITextField!
    @IBOutlet weak var txtGarageFobRate : UITextField!
    @IBOutlet weak var txtGarageFobQuantity : UITextField!
    @IBOutlet weak var txtDepositOthers : UITextField!
    @IBOutlet weak var btnPayorInfoPAD : UIButton!
    @IBOutlet weak var btnPayorInfoPDChq : UIButton!
    @IBOutlet weak var vw_PayerName : UIView!
    @IBOutlet weak var vw_BankName : UIView!
    @IBOutlet weak var vw_BankID : UIView!
    @IBOutlet weak var vw_AccountNumber : UIView!
    @IBOutlet weak var vw_Transit : UIView!
    @IBOutlet weak var txtPayerName : UITextField!
    @IBOutlet weak var txtBankName : UITextField!
    @IBOutlet weak var txtBankID : UITextField!
    @IBOutlet weak var txtAccountNumber : UITextField!
    @IBOutlet weak var txtTransit : UITextField!
    @IBOutlet weak var cns_stkPADInfoBottom : NSLayoutConstraint!
    @IBOutlet weak var btnUnitKey : UIButton!
    @IBOutlet weak var txtUnitKey : UITextField!
    @IBOutlet weak var btnElpasFOB : UIButton!
    @IBOutlet weak var txtElpasFOB : UITextField!
    @IBOutlet weak var txtResidentSignature : UITextField!
    @IBOutlet weak var btnInsCopyReceived : UIButton!
    @IBOutlet weak var btnInsCopyReceivedDate : UIButton!
    @IBOutlet weak var cns_hgt_btnInsCopyReceivedDate : NSLayoutConstraint!
    @IBOutlet weak var cns_btnInsCopyReceivedDateBottom : NSLayoutConstraint!
    @IBOutlet weak var btnInsCovrApproved : UIButton!
    @IBOutlet weak var vw_InsCmpName : UIView!
    @IBOutlet weak var vw_PolicyNumber : UIView!
    @IBOutlet weak var txtInsCmpName : UITextField!
    @IBOutlet weak var txtPolicyNumber : UITextField!
    @IBOutlet weak var cns_stkInsCovrApprovedBottom : NSLayoutConstraint!
    @IBOutlet weak var txtReviewedBy : UITextField!
    @IBOutlet weak var btnDate : UIButton!
    @IBOutlet weak var imgSignature : UIImageView!
    @IBOutlet var canvasView : PKCanvasView!
    @IBOutlet var vw_CanvasContainer: UIView!
    
    var contractTerm = ""
    var CurrentDateSelection = "SigningDate"
    let dtpickerWidth : CGFloat = ((UIDevice.current.userInterfaceIdiom == .pad) ? 450 : 300)
    let canvasWidth : CGFloat = ((UIDevice.current.userInterfaceIdiom == .pad) ? 450 : 300)
    var calledFrom = "Add"
    var form_id = 0
    var isSignAdded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        self.dtPicker.datePickerMode = .date
        if #available(iOS 13.0, *) {
            self.dtPicker.overrideUserInterfaceStyle = .light
            self.canvasView.overrideUserInterfaceStyle = .light
        }
       
        self.imgSignature.layer.borderWidth = 1
        self.imgSignature.layer.borderColor = UIColor.black.cgColor
        
        if #available(iOS 14.0, *) {
            self.canvasView.drawingPolicy = .anyInput
        }
        self.canvasView.backgroundColor = .white
        self.canvasView.tool = PKInkingTool(.marker, color: .black, width: 1)
        self.canvasView.becomeFirstResponder()
               
        if(self.calledFrom == "Edit")
        {
            self.CallFormDetailService()
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.btnSignature_Clicked(_:)))
        self.imgSignature.isUserInteractionEnabled = true
        self.imgSignature.addGestureRecognizer(tapGesture)
    }
    
    @objc func btnSignature_Clicked(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
        self.vw_clearBG.isHidden = false
        self.vw_header.isUserInteractionEnabled = false
        let wd = UIScreen.main.bounds.size.width
            
        self.vw_CanvasContainer.frame = CGRect(x: (wd - canvasWidth)/2, y: ((UIScreen.main.bounds.size.height - self.vw_CanvasContainer.frame.size.height)/2), width: canvasWidth, height: self.vw_CanvasContainer.frame.size.height)
        self.view.addSubview(self.vw_CanvasContainer)
        
    }
    
    func getSignatureImage() -> UIImage?
    {
        UIGraphicsBeginImageContextWithOptions(self.canvasView.bounds.size, false, 0)
        self.canvasView.drawHierarchy(in: self.canvasView.bounds, afterScreenUpdates: true)
        let signatureImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return signatureImage
    }
    
    @IBAction func btnClearSignatureClicked(_ sender: Any)
    {
        self.vw_clearBG.isHidden = true
        self.vw_header.isUserInteractionEnabled = true
        self.vw_CanvasContainer.removeFromSuperview()
        self.canvasView.drawing = PKDrawing()
    }
    
    @IBAction func btnAddSignatureClicked(_ sender: Any)
    {
        self.vw_clearBG.isHidden = true
        self.vw_header.isUserInteractionEnabled = true
        let img = UIGraphicsImageRenderer(bounds: self.canvasView.bounds).image { _ in
            self.canvasView.drawHierarchy(in: self.canvasView.bounds, afterScreenUpdates: true)
        }
        self.imgSignature.image = img //getSignatureImage()!
        self.vw_CanvasContainer.removeFromSuperview()
        self.canvasView.drawing = PKDrawing()
        self.isSignAdded = true
    }
    
    @IBAction func btnBack_Clicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if(textField == self.txtMonthlyRate)
        {
            if(self.txtMonthlyRate.text!.count > 0)
            {
                self.txtHalfMRentalDepositfor1stRes.text = "\(Float(self.txtMonthlyRate.text!)!/2)"
//                if(self.btnHas2ndResident.isSelected)
//                {
                    self.txtHalfMRentalDepositfor2ndRes.text = "\(Float(self.txtMonthlyRate.text!)!/2)"
                //}
            }
            else
            {
                self.txtHalfMRentalDepositfor1stRes.text = ""
//                if(self.btnHas2ndResident.isSelected)
//                {
                    self.txtHalfMRentalDepositfor2ndRes.text = ""
                //}
            }
        }
        else if(textField == self.txtCarePlanRate)
        {
            if(self.txtCarePlanRate.text!.count > 0)
            {
                self.txtHalfMCarePlan.text = "\(Float(self.txtCarePlanRate.text!)!/2)"
            }
            else
            {
                self.txtHalfMCarePlan.text = ""
            }
        }
    }
    
    @IBAction func btnSelectDateClicked(_ sender: Any)
    {
        let btn = sender as! UIButton
        self.view.endEditing(true)
        self.vw_clearBG.isHidden = false
        self.vw_header.isUserInteractionEnabled = false
        let wd = UIScreen.main.bounds.size.width
        
        self.vw_DatePickerContainer.frame = CGRect(x: (wd - dtpickerWidth)/2, y: ((UIScreen.main.bounds.size.height - self.vw_DatePickerContainer.frame.size.height)/2), width: dtpickerWidth, height: self.vw_DatePickerContainer.frame.size.height)
   
        self.view.addSubview(self.vw_DatePickerContainer)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy" // hh:mm a
        dateFormatter.locale = self.dtPicker.locale
        //"dd MMM YYYY hh:mm a"
        // HH:mm:ss z
        if(btn.tag == 1)
        {
            self.CurrentDateSelection = "SigningDate"
            if(self.btnDt_CntSigning.title(for: .normal) != "Select Date")
            {
                let date = dateFormatter.date(from: self.btnDt_CntSigning.title(for: .normal)!)
                dateFormatter.dateFormat =  "yyyy-MM-dd"
                let yourDate = dateFormatter.string(from: date!)
                self.dtPicker.date = dateFormatter.date(from: yourDate)!
            }
            else
            {
                self.dtPicker.date = Date()
            }
        }
        else if(btn.tag == 2)
        {
            self.CurrentDateSelection = "TenancyCommenceDate"
            if(self.btnDt_TenancyCom.title(for: .normal) != "Select Date")
            {
                let date = dateFormatter.date(from: self.btnDt_TenancyCom.title(for: .normal)!)
                dateFormatter.dateFormat =  "yyyy-MM-dd"
                let yourDate = dateFormatter.string(from: date!)
                self.dtPicker.date = dateFormatter.date(from: yourDate)!
            }
            else
            {
                self.dtPicker.date = Date()
            }
        }
        else if(btn.tag == 3)
        {
            self.CurrentDateSelection = "ExpiryDate"
            if(self.btnDt_CntExpiry.title(for: .normal) != "Select Date")
            {
                let date = dateFormatter.date(from: self.btnDt_CntExpiry.title(for: .normal)!)
                dateFormatter.dateFormat =  "yyyy-MM-dd"
                let yourDate = dateFormatter.string(from: date!)
                self.dtPicker.date = dateFormatter.date(from: yourDate)!
            }
            else
            {
                self.dtPicker.date = Date()
            }
        }
        else if(btn.tag == 4)
        {
            self.CurrentDateSelection = "Res1DOB"
            if(self.btnres1_DOB.title(for: .normal) != "Select Date")
            {
                let date = dateFormatter.date(from: self.btnres1_DOB.title(for: .normal)!)
                dateFormatter.dateFormat =  "yyyy-MM-dd"
                let yourDate = dateFormatter.string(from: date!)
                self.dtPicker.date = dateFormatter.date(from: yourDate)!
            }
            else
            {
                self.dtPicker.date = Date()
            }
        }
        else if(btn.tag == 5)
        {
            self.CurrentDateSelection = "Res2DOB"
            if(self.btnres2_DOB.title(for: .normal) != "Select Date")
            {
                let date = dateFormatter.date(from: self.btnres2_DOB.title(for: .normal)!)
                dateFormatter.dateFormat =  "yyyy-MM-dd"
                let yourDate = dateFormatter.string(from: date!)
                self.dtPicker.date = dateFormatter.date(from: yourDate)!
            }
            else
            {
                self.dtPicker.date = Date()
            }
        }
        else if(btn.tag == 6)
        {
            self.CurrentDateSelection = "PaymentChqDate"
            if(self.btnPaymentChqDate.title(for: .normal) != "Select Date")
            {
                let date = dateFormatter.date(from: self.btnPaymentChqDate.title(for: .normal)!)
                dateFormatter.dateFormat =  "yyyy-MM-dd"
                let yourDate = dateFormatter.string(from: date!)
                self.dtPicker.date = dateFormatter.date(from: yourDate)!
            }
            else
            {
                self.dtPicker.date = Date()
            }
        }
        else if(btn.tag == 7)
        {
            self.CurrentDateSelection = "DepositChqDate"
            if(self.btnDepositChqDate.title(for: .normal) != "Select Date")
            {
                let date = dateFormatter.date(from: self.btnDepositChqDate.title(for: .normal)!)
                dateFormatter.dateFormat =  "yyyy-MM-dd"
                let yourDate = dateFormatter.string(from: date!)
                self.dtPicker.date = dateFormatter.date(from: yourDate)!
            }
            else
            {
                self.dtPicker.date = Date()
            }
        }
        else if(btn.tag == 8)
        {
            self.CurrentDateSelection = "InsCopyReceivedDate"
            if(self.btnInsCopyReceivedDate.title(for: .normal) != "Select Date")
            {
                let date = dateFormatter.date(from: self.btnInsCopyReceivedDate.title(for: .normal)!)
                dateFormatter.dateFormat =  "yyyy-MM-dd"
                let yourDate = dateFormatter.string(from: date!)
                self.dtPicker.date = dateFormatter.date(from: yourDate)!
            }
            else
            {
                self.dtPicker.date = Date()
            }
        }
        else if(btn.tag == 9)
        {
            self.CurrentDateSelection = "Date"
            if(self.btnDate.title(for: .normal) != "Select Date")
            {
                let date = dateFormatter.date(from: self.btnDate.title(for: .normal)!)
                dateFormatter.dateFormat =  "yyyy-MM-dd"
                let yourDate = dateFormatter.string(from: date!)
                self.dtPicker.date = dateFormatter.date(from: yourDate)!
            }
            else
            {
                self.dtPicker.date = Date()
            }
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
        formatter.dateFormat = "yyyy-MM-dd" // hh:mm a
        
        let myString = formatter.string(from: self.dtPicker.date)
        let yourDate = formatter.date(from: myString)
        formatter.dateFormat = "dd MMM YYYY" // hh:mm a
        let selectedDate = formatter.string(from: yourDate!)
        
        if(self.CurrentDateSelection == "SigningDate")
        {
            self.btnDt_CntSigning.setTitle(selectedDate, for: .normal)
        }
        else if(self.CurrentDateSelection == "TenancyCommenceDate")
        {
            self.btnDt_TenancyCom.setTitle(selectedDate, for: .normal)
        }
        else if(self.CurrentDateSelection == "ExpiryDate")
        {
            self.btnDt_CntExpiry.setTitle(selectedDate, for: .normal)
        }
        else if(self.CurrentDateSelection == "Res1DOB")
        {
            self.btnres1_DOB.setTitle(selectedDate, for: .normal)
        }
        else if(self.CurrentDateSelection == "Res2DOB")
        {
            self.btnres2_DOB.setTitle(selectedDate, for: .normal)
        }
        else if(self.CurrentDateSelection == "PaymentChqDate")
        {
            self.btnPaymentChqDate.setTitle(selectedDate, for: .normal)
        }
        else if(self.CurrentDateSelection == "DepositChqDate")
        {
            self.btnDepositChqDate.setTitle(selectedDate, for: .normal)
        }
        else if(self.CurrentDateSelection == "InsCopyReceivedDate")
        {
            self.btnInsCopyReceivedDate.setTitle(selectedDate, for: .normal)
        }
        else if(self.CurrentDateSelection == "Date")
        {
            self.btnDate.setTitle(selectedDate, for: .normal)
        }
//        else
//        {
//            self.btnNotiDateTime.setTitle(selectedDate, for: .normal)
//        }
             
    }
    
    @IBAction func btnUnitKey_Clicked(_ sender: Any)
    {
        let btn = sender as! UIButton
        self.txtUnitKey.isHidden = (btn.isSelected) ? true : false
        btn.isSelected = !btn.isSelected
    }
    
    @IBAction func btnElpasFob_Clicked(_ sender: Any)
    {
        let btn = sender as! UIButton
        self.txtElpasFOB.isHidden = (btn.isSelected) ? true : false
        btn.isSelected = !btn.isSelected
    }
    
    @IBAction func btnInsCopyReceived_Clicked(_ sender: Any)
    {
        let btn = sender as! UIButton
        self.btnInsCopyReceivedDate.isHidden = (btn.isSelected) ? true : false
        self.cns_hgt_btnInsCopyReceivedDate.constant = (btn.isSelected) ? 0 : 30
        self.cns_btnInsCopyReceivedDateBottom.constant = (btn.isSelected) ? 0 : 10
        btn.isSelected = !btn.isSelected
    }
    
    @IBAction func btnInsCovrApproved_Clicked(_ sender: Any)
    {
        let btn = sender as! UIButton
        btn.isSelected = !btn.isSelected
        self.vw_InsCmpName.isHidden = (btn.isSelected) ? false : true
        self.vw_PolicyNumber.isHidden = (btn.isSelected) ? false : true
        self.cns_stkInsCovrApprovedBottom.constant = (btn.isSelected) ? 10 : 0
    }
    
    @IBAction func btnPayorInfo_Clicked(_ sender: Any)
    {
        let btn = sender as! UIButton
        if(btn.isSelected == true)
        {
            btn.isSelected = false
            if(btn == self.btnPayorInfoPAD)
            {
                self.vw_PayerName.isHidden = true
                self.vw_BankName.isHidden = true
                self.vw_BankID.isHidden = true
                self.vw_AccountNumber.isHidden = true
                self.vw_Transit.isHidden = true
                self.cns_stkPADInfoBottom.constant =  0
            }
        }
        else
        {
            btn.isSelected = true
            if(btn == self.btnPayorInfoPAD)
            {
                self.btnPayorInfoPDChq.isSelected = false
                self.vw_PayerName.isHidden = false
                self.vw_BankName.isHidden = false
                self.vw_BankID.isHidden = false
                self.vw_AccountNumber.isHidden = false
                self.vw_Transit.isHidden = false
                self.cns_stkPADInfoBottom.constant =  10
            }
            else
            {
                self.btnPayorInfoPAD.isSelected = false
                self.vw_PayerName.isHidden = true
                self.vw_BankName.isHidden = true
                self.vw_BankID.isHidden = true
                self.vw_AccountNumber.isHidden = true
                self.vw_Transit.isHidden = true
                self.cns_stkPADInfoBottom.constant =  0
            }
        }
    }
    
    @IBAction func btnChkMark_Clicked(_ sender: Any)
    {
        let btn = sender as! UIButton
        if(btn.isSelected == true)
        {
            btn.isSelected = false
            self.contractTerm = ""
        }
        else
        {
            btn.isSelected = true
            if(btn == self.btnContractYearly)
            {
                self.contractTerm = "Yearly"
                self.btnContractMonthly.isSelected = false
                self.btnContractWeekly.isSelected = false
                self.btnContractDaily.isSelected = false
            }
            else if(btn == self.btnContractMonthly)
            {
                self.contractTerm = "Monthly"
                self.btnContractYearly.isSelected = false
                self.btnContractWeekly.isSelected = false
                self.btnContractDaily.isSelected = false
            }
            else if(btn == self.btnContractWeekly)
            {
                self.contractTerm = "Weekly"
                self.btnContractYearly.isSelected = false
                self.btnContractMonthly.isSelected = false
                self.btnContractDaily.isSelected = false
            }
            else
            {
                self.contractTerm = "Daily"
                self.btnContractYearly.isSelected = false
                self.btnContractMonthly.isSelected = false
                self.btnContractWeekly.isSelected = false
            }
        }
    }
    
    @IBAction func btnHas2ndRes_Clicked(_ sender: Any)
    {
        let btn = sender as! UIButton
        btn.isSelected = !btn.isSelected
        self.vw_res2_FName.isHidden = (btn.isSelected) ? false : true
        self.vw_res2_MName.isHidden = (btn.isSelected) ? false : true
        self.vw_res2_LName.isHidden = (btn.isSelected) ? false : true
        self.vw_res2_DOB.isHidden = (btn.isSelected) ? false : true
        self.vw_HalfMRentalDepositfor2ndRes.isHidden = (btn.isSelected) ? false : true
        self.cns_stkRes2Bottom.constant = (btn.isSelected) ? 10 : 0
        self.cns_vwHalfMRentalDepositfor2ndResBottom.constant = (btn.isSelected) ? 10 : 0
        self.cns_hgt_txtHalfMRentalDepositfor2ndRes.constant = (btn.isSelected) ? 30 : 0
    }
    
    @IBAction func btnPaymentReceived_Clicked(_ sender: Any)
    {
        let btn = sender as! UIButton
        btn.isSelected = !btn.isSelected
        self.vw_PaymentChqNum.isHidden = (btn.isSelected) ? false : true
        self.vw_PaymentChqDate.isHidden = (btn.isSelected) ? false : true
        self.vw_PaymentChqTotal.isHidden = (btn.isSelected) ? false : true
        self.cns_stkPaymentReceivedBottom.constant = (btn.isSelected) ? 10 : 0
    }
    
    @IBAction func btnDeositReceived_Clicked(_ sender: Any)
    {
        let btn = sender as! UIButton
        btn.isSelected = !btn.isSelected
        self.vw_DepositChqNum.isHidden = (btn.isSelected) ? false : true
        self.vw_DepositChqDate.isHidden = (btn.isSelected) ? false : true
        self.vw_DepositChqTotal.isHidden = (btn.isSelected) ? false : true
        self.cns_stkDepositReceivedBottom.constant = (btn.isSelected) ? 15 : 5
    }
    
    @IBAction func btnSubmitClicked(_ sender: Any)
    {
        
        if(self.txt_suiteNumber.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0)
        {
            self.showMessageAlert(message: "Please enter Suite Number.")
        }
        else if(self.btnDt_CntSigning.title(for: .normal) == "Select Date")
        {
            self.showMessageAlert(message: "Please select Contract Signing Date.")
        }
        else if(self.txt_salseName.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0)
        {
            self.showMessageAlert(message: "Please enter Sales Name.")
        }
        else if(self.btnContractYearly.isSelected == false && self.btnContractMonthly.isSelected == false && self.btnContractWeekly.isSelected == false && self.btnContractDaily.isSelected == false)
        {
            self.showMessageAlert(message: "Please select Contract Term.")
        }
        else if(self.btnDt_TenancyCom.title(for: .normal) == "Select Date")
        {
            self.showMessageAlert(message: "Please select Tenancy Commence Date.")
        }
        else if(self.btnDt_CntExpiry.title(for: .normal) == "Select Date")
        {
            self.showMessageAlert(message: "Please select Contract Expiry Date.")
        }
        else if(self.txtres1_FName.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0)
        {
            self.showMessageAlert(message: "Please enter First Name of 1st Resident.")
        }
        else if(self.txtres1_LName.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0)
        {
            self.showMessageAlert(message: "Please enter Last Name of 1st Resident.")
        }
        else if(self.btnres1_DOB.title(for: .normal) == "Select Date")
        {
            self.showMessageAlert(message: "Please select DOB of 1st Resident.")
        }
        else if(self.btnHas2ndResident.isSelected == true && self.txtres2_FName.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0)
        {
            self.showMessageAlert(message: "Please enter First Name of 2nd Resident.")
        }
        else if(self.btnHas2ndResident.isSelected == true && self.txtres2_LName.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0)
        {
            self.showMessageAlert(message: "Please enter Last Name of 2nd Resident.")
        }
        else if(self.btnHas2ndResident.isSelected == true && self.btnres2_DOB.title(for: .normal) == "Select Date")
        {
            self.showMessageAlert(message: "Please select DOB of 2nd Resident.")
        }
        else if(self.btnPaymentReceived.isSelected == true && self.txtPaymentChqNum.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0)
        {
            self.showMessageAlert(message: "Please enter Cheque Number for 1st Month Payment.")
        }
        else if(self.btnPaymentReceived.isSelected == true && self.btnPaymentChqDate.title(for: .normal) == "Select Date")
        {
            self.showMessageAlert(message: "Please select Cheque Date for 1st Month Payment.")
        }
        else if(self.btnPaymentReceived.isSelected == true && self.txtPaymentChqTotal.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0)
        {
            self.showMessageAlert(message: "Please enter Cheque Total for 1st Month Payment.")
        }
        else if(self.txtMonthlyRate.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0)
        {
            self.showMessageAlert(message: "Please enter Monthly Rate.")
        }
        else if(self.btnDepositReceived.isSelected == true && self.txtDepositChqNum.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0)
        {
            self.showMessageAlert(message: "Please enter Cheque Number for Security Deposit.")
        }
        else if(self.btnDepositReceived.isSelected == true && self.btnDepositChqDate.title(for: .normal) == "Select Date")
        {
            self.showMessageAlert(message: "Please select Cheque Date for Security Deposit.")
        }
        else if(self.btnDepositReceived.isSelected == true && self.txtDepositChqTotal.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0)
        {
            self.showMessageAlert(message: "Please enter Cheque Total for Security Deposit.")
        }
        else if(self.btnPayorInfoPAD.isSelected == false && self.btnPayorInfoPDChq.isSelected == false)
        {
            self.showMessageAlert(message: "Please select Payor Information.")
        }
        else if(self.btnPayorInfoPAD.isSelected == true && self.txtPayerName.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0)
        {
            self.showMessageAlert(message: "Please enter Payor's Name.")
        }
        else if(self.btnPayorInfoPAD.isSelected == true && self.txtBankName.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0)
        {
            self.showMessageAlert(message: "Please enter Bank Name.")
        }
        else if(self.btnPayorInfoPAD.isSelected == true && self.txtBankID.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0)
        {
            self.showMessageAlert(message: "Please enter Bank ID.")
        }
        else if(self.btnPayorInfoPAD.isSelected == true && (self.txtBankID.text?.trimmingCharacters(in: .whitespacesAndNewlines).count)! != 3)
        {
            self.showMessageAlert(message: "Bank ID must be of 3 digits Only.")
        }
        else if(self.btnPayorInfoPAD.isSelected == true && self.txtAccountNumber.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0)
        {
            self.showMessageAlert(message: "Please enter Account Number.")
        }
        else if(self.btnPayorInfoPAD.isSelected == true && self.txtTransit.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0)
        {
            self.showMessageAlert(message: "Please enter Transit.")
        }
        else if(self.btnPayorInfoPAD.isSelected == true && (self.txtTransit.text?.trimmingCharacters(in: .whitespacesAndNewlines).count)! != 5)
        {
            self.showMessageAlert(message: "Transit must be of 5 digits Only.")
        }
        else if(self.btnUnitKey.isSelected == true && self.txtUnitKey.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0)
        {
            self.showMessageAlert(message: "Please enter Unit Key.")
        }
        else if(self.btnElpasFOB.isSelected == true && self.txtElpasFOB.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0)
        {
            self.showMessageAlert(message: "Please enter Elpas Fob.")
        }
        else if(self.isSignAdded == false)
        {
            self.showMessageAlert(message: "Please provide Resident Signature.")
        }
        else if(self.btnInsCopyReceived.isSelected == true && self.btnInsCopyReceivedDate.title(for: .normal) == "Select Date")
        {
            self.showMessageAlert(message: "Please select Date for Suite Insurance Copy Received.")
        }
        else if(self.btnInsCovrApproved.isSelected == true && self.txtInsCmpName.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0)
        {
            self.showMessageAlert(message: "Please enter Insurance Company Name.")
        }
        else if(self.btnInsCovrApproved.isSelected == true && self.txtPolicyNumber.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0)
        {
            self.showMessageAlert(message: "Please enter Policy Number.")
        }
        else if(self.txtReviewedBy.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0)
        {
            self.showMessageAlert(message: "Please enter Reviewed by.")
        }
        else if(self.btnDate.title(for: .normal) == "Select Date")
        {
            self.showMessageAlert(message: "Please select Date.")
        }
        else
        {
            if(self.calledFrom == "Edit")
            {
                self.callEditFormService()
            }
            else
            {
                self.callSubmitFormService()
            }
           // self.showMessageAlert(message: "Successfully passed Validation.")

        }
    }
 
    func callEditFormService()
    {
        
        let dictItem = self.setValuesAsParameters()
  
        let json: JSON = JSON(dictItem)
        print("string converted object is \(json.rawString()!)")
        

        self.view.isUserInteractionEnabled = false
        self.act_indicator.startAnimating()
        
        let imgData = self.imgSignature.image!.jpegData(compressionQuality: 1)!
        let para = ["form_id" : "\(self.form_id)", "data" : json.rawString()!] as [String : Any]
        
        NetworkUtilities.shared.makePOSTwithMultipartFormDataRequest(with: API.baseURL + "edit-form-phase1", fromWhere: "", parameters: para, imageParameters: [:], VideoParameters : [:], DocumentParameters: [:], thumbImageParameters: [:], ImgData: imgData, VideoData: nil) { (response) in
        //NetworkUtilities.shared.makePOSTRequest(with: API.baseURL + "edit-form-phase1", parameters: para) { (response) in
            
            
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
                    let idx = AppDelegate.sharedDelegate().arFormList.firstIndex(where: { $0.FormId == 1 })
                    previewPDFVC.isAllowPrint = AppDelegate.sharedDelegate().arFormList[idx!].IsPrintAllowed
                    previewPDFVC.isAllowMail = AppDelegate.sharedDelegate().arFormList[idx!].IsMailAllowed
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
    
    
    func callSubmitFormService()
    {
        let dictItem = self.setValuesAsParameters()
        
        let json: JSON = JSON(dictItem)
        print("string converted object is \(json.rawString()!)")
       
        self.view.isUserInteractionEnabled = false
        self.act_indicator.startAnimating()

        let imgData = self.imgSignature.image!.jpegData(compressionQuality: 1)!
        let para : [String : Any] = ["form_type" : "3", "data" : json.rawString()!] as [String : Any]

            NetworkUtilities.shared.makePOSTwithMultipartFormDataRequest(with: API.baseURL + "general-form-submit-phase1", fromWhere: "", parameters: para, imageParameters: [:], VideoParameters : [:], DocumentParameters: [:], thumbImageParameters: [:], ImgData: imgData, VideoData: nil) { (response) in


            print("api is \(API.baseURL + API.general_form_submit_api) para are \(para)")

            if(response.error == nil)
            {
                self.view.isUserInteractionEnabled = true
                self.act_indicator.stopAnimating()
                if(response.result[MainResponseCodeConstant.keyResponseCode].intValue == MainResponseCodeConstant.keyResponseCodeOne)
                {                   
                    print(response.result)
                    CommonUtility.shared.showErrorAlertOnWindow("Success", message: "Form successfully Submitted.")
                    //self.navigationController?.popViewController(animated: false)
                    let previewPDFVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PreviewPDFVC") as! PreviewPDFVC
                    previewPDFVC.pdfURL = response.result["form_link"].stringValue
                    previewPDFVC.form_id = response.result["submitted_form_id"].intValue
                    let idx = AppDelegate.sharedDelegate().arFormList.firstIndex(where: { $0.FormId == 3 })
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
    
    
    func setValuesAsParameters() -> [String : AnyObject]
    {
        
//        let incident_dt = self.btnDateOfInc.title(for: .normal)!.prefix(11)
//        let incident_tm = self.btnDateOfInc.title(for: .normal)!.suffix(8)
//        let discovery_dt = self.btnDateOfDisc.title(for: .normal)!.prefix(11)
//        let discovery_tm = self.btnDateOfDisc.title(for: .normal)!.suffix(8)
//        let completed_dt = self.btnNotiDateTime.title(for: .normal)!.prefix(11)
//        let completed_tm = self.btnNotiDateTime.title(for: .normal)!.suffix(8)
                               
        var dictItem = [
            "suite_number" : self.txt_suiteNumber.text!,
            "contract_signing_date" : self.btnDt_CntSigning.title(for: .normal)!,
            "sales_name" : self.txt_salseName.text!,
            "contract_term_yearly" : (self.btnContractYearly.isSelected) ? 1 : 0,
            "contract_term_monthly" :(self.btnContractMonthly.isSelected) ? 1 : 0,
            "contract_term_weekly" : (self.btnContractWeekly.isSelected) ? 1 : 0,
            "contract_term_daily" : (self.btnContractDaily.isSelected) ? 1 : 0,
            "tenancy_commence_date" : self.btnDt_TenancyCom.title(for: .normal)!,
            "contract_expiry_date" : self.btnDt_CntExpiry.title(for: .normal)!,
            "first_resident_name_first_name" : self.txtres1_FName.text!,
            "first_resident_name_last_name" : self.txtres1_LName.text!,
            "first_resident_name_middle_name" : self.txtres1_MName.text!,
            "first_resident_dob" : self.btnres1_DOB.title(for: .normal)!,
            "has_2nd_resident" : (self.btnHas2ndResident.isSelected) ? 1 : 0,
            "first_month_payment_received" : (self.btnPaymentReceived.isSelected) ? 1 : 0,
            "monthly_rate" : self.txtMonthlyRate.text!,
            "care_plan_rate" : self.txtCarePlanRate.text!,
            "one_time_move_in_fee" : self.txt1TimeMoveInFee.text!,
            "parking_rate" : self.txtParkingRate.text!,
            "parking_quantity" : self.txtParkingQuantity.text!,
            "scooter_rate" : self.txtScooterRate.text!,
            "scooter_quantity" : self.txtScooterQuantity.text!,
            "window_screen_rate" : self.txtWindowScreenRate.text!,
            "window_screen_quantity" : self.txtWindowScreenQuantity.text!,
            "grab_bar_rate" : self.txtGrabBarRate.text!,
            "grab_bar_quantity" : self.txtGrabBarQuantity.text!,
            "payment_others_rate" : self.txtPaymentOthers.text!,
            "security_deposit_received" : (self.btnDepositReceived.isSelected) ? 1 : 0,
            "half_month_deposit_for_first_resident_rate" : self.txtHalfMRentalDepositfor1stRes.text!,
            "half_month_care_plan_rate" : self.txtHalfMCarePlan.text!,
            "move_in_out_rate" : self.txtMoveInOut.text!,
            "elpas_rate" : self.txtElpasRate.text!,
            "elpas_quantity" : self.txtElpasQuantity.text!,
            "garage_fob_rate" : self.txtGarageFobRate.text!,
            "garage_fob_quantity" : self.txtGarageFobQuantity.text!,
            "deposit_others_rate" : self.txtDepositOthers.text!,
            "payor_information_PAD" : (self.btnPayorInfoPAD.isSelected) ? 1 : 0,
            "payor_information_Post_Dated_Cheque" : (self.btnPayorInfoPDChq.isSelected) ? 1 : 0,
            "unit_key" : (self.btnUnitKey.isSelected) ? 1 : 0,
            "elpas_fob" : (self.btnElpasFOB.isSelected) ? 1 : 0,
            //"resident_signature" : self.txtResidentSignature.text!,
            "suite_insurance_copy_received" : (self.btnInsCopyReceived.isSelected) ? 1 : 0,
            "suite_insurance_coverage_approved" : (self.btnInsCovrApproved.isSelected) ? 1 : 0,
            "reviewed_by" : self.txtReviewedBy.text!,
            "date" : self.btnDate.title(for: .normal)!
        ] as [String : AnyObject]
        
        if(self.btnHas2ndResident.isSelected == true)
        {
            dictItem["second_resident_name_first_name"] = self.txtres2_FName.text! as AnyObject
            dictItem["second_resident_name_last_name"] = self.txtres2_LName.text! as AnyObject
            dictItem["second_resident_name_middle_name"] = self.txtres2_MName.text! as AnyObject
            dictItem["second_resident_dob"] = self.btnres2_DOB.title(for: .normal)! as AnyObject
            dictItem["half_month_deposit_for_second_resident_rate"] = self.txtHalfMRentalDepositfor2ndRes.text! as AnyObject
        }
        
        if(self.btnPaymentReceived.isSelected == true)
        {
            dictItem["first_month_payment_received_cheque_note"] = self.txtPaymentChqNum.text! as AnyObject
            dictItem["first_month_payment_received_cheque_amount"] = self.txtPaymentChqTotal.text! as AnyObject
            dictItem["first_month_payment_received_cheque_date"] = self.btnPaymentChqDate.title(for: .normal)! as AnyObject
        }
        
        if(self.btnDepositReceived.isSelected == true)
        {
            dictItem["security_deposit_received_cheque_note"] = self.txtDepositChqNum.text! as AnyObject
            dictItem["security_deposit_received_cheque_amount"] = self.txtDepositChqTotal.text! as AnyObject
            dictItem["security_deposit_received_cheque_date"] = self.btnDepositChqDate.title(for: .normal)! as AnyObject
        }
        
        if(self.btnPayorInfoPAD.isSelected == true)
        {
            dictItem["payor_name"] = self.txtPayerName.text! as AnyObject
            dictItem["bank_name"] = self.txtBankName.text! as AnyObject
            dictItem["bank_ID"] = self.txtBankID.text! as AnyObject
            dictItem["account_number"] = self.txtAccountNumber.text! as AnyObject
            dictItem["transit"] = self.txtTransit.text! as AnyObject
        }
        
        if(self.btnUnitKey.isSelected == true)
        {
            dictItem["unit_key_value"] = self.txtUnitKey.text! as AnyObject
        }
           
        if(self.btnElpasFOB.isSelected == true)
        {
            dictItem["elpas_fob_value"] = self.txtElpasFOB.text! as AnyObject
        }
        
        if(self.btnInsCopyReceived.isSelected == true)
        {
            dictItem["suite_insurance_copy_received_date"] = self.btnInsCopyReceivedDate.title(for: .normal)! as AnyObject
        }
        
        if(self.btnInsCovrApproved.isSelected == true)
        {
            dictItem["insurance_company_name"] = self.txtInsCmpName.text! as AnyObject
            dictItem["policy_number"] = self.txtPolicyNumber.text! as AnyObject
        }
           
        return dictItem
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
                    if((form_detail["suite_number"]?.exists()) != nil)
                    {
                        self.txt_suiteNumber.text = form_detail["suite_number"]?.stringValue
                    }
                    if((form_detail["contract_signing_date"]?.exists()) != nil)
                    {
                        self.btnDt_CntSigning.setTitle(form_detail["contract_signing_date"]?.stringValue, for: .normal)
                    }
                    if((form_detail["sales_name"]?.exists()) != nil)
                    {
                        self.txt_salseName.text = form_detail["sales_name"]?.stringValue
                    }
                    if((form_detail["contract_term_yearly"]?.exists()) != nil)
                    {
                        self.btnContractYearly.isSelected = (form_detail["contract_term_yearly"]?.intValue == 1) ? true : false
                    }
                    if((form_detail["contract_term_monthly"]?.exists()) != nil)
                    {
                        self.btnContractMonthly.isSelected = (form_detail["contract_term_monthly"]?.intValue == 1) ? true : false
                    }
                    if((form_detail["contract_term_weekly"]?.exists()) != nil)
                    {
                        self.btnContractWeekly.isSelected = (form_detail["contract_term_weekly"]?.intValue == 1) ? true : false
                    }
                    if((form_detail["contract_term_daily"]?.exists()) != nil)
                    {
                        self.btnContractDaily.isSelected = (form_detail["contract_term_daily"]?.intValue == 1) ? true : false
                    }
                    if((form_detail["tenancy_commence_date"]?.exists()) != nil)
                    {
                        self.btnDt_TenancyCom.setTitle(form_detail["tenancy_commence_date"]?.stringValue, for: .normal)
                    }
                    if((form_detail["contract_expiry_date"]?.exists()) != nil)
                    {
                        self.btnDt_CntExpiry.setTitle(form_detail["contract_expiry_date"]?.stringValue, for: .normal)
                    }
                    if((form_detail["first_resident_name_first_name"]?.exists()) != nil)
                    {
                        self.txtres1_FName.text = form_detail["first_resident_name_first_name"]?.stringValue
                    }
                    if((form_detail["first_resident_name_last_name"]?.exists()) != nil)
                    {
                        self.txtres1_LName.text = form_detail["first_resident_name_last_name"]?.stringValue
                    }
                    if((form_detail["first_resident_name_middle_name"]?.exists()) != nil)
                    {
                        self.txtres1_MName.text = form_detail["first_resident_name_middle_name"]?.stringValue
                    }
                    if((form_detail["first_resident_dob"]?.exists()) != nil)
                    {
                        self.btnres1_DOB.setTitle(form_detail["first_resident_dob"]?.stringValue, for: .normal)
                    }
                    if((form_detail["has_2nd_resident"]?.exists()) != nil)
                    {
                        if(form_detail["has_2nd_resident"]?.intValue == 1)
                        {
                            self.btnHas2ndResident.isSelected = true
                            self.vw_res2_FName.isHidden = false
                            self.vw_res2_MName.isHidden = false
                            self.vw_res2_LName.isHidden = false
                            self.vw_res2_DOB.isHidden = false
                            self.vw_HalfMRentalDepositfor2ndRes.isHidden = false
                            self.cns_stkRes2Bottom.constant = 10
                            self.cns_vwHalfMRentalDepositfor2ndResBottom.constant = 10
                            self.cns_hgt_txtHalfMRentalDepositfor2ndRes.constant = 30
                            
                            if((form_detail["second_resident_name_first_name"]?.exists()) != nil)
                            {
                                self.txtres2_FName.text = form_detail["second_resident_name_first_name"]?.stringValue
                            }
                            if((form_detail["second_resident_name_last_name"]?.exists()) != nil)
                            {
                                self.txtres2_LName.text = form_detail["second_resident_name_last_name"]?.stringValue
                            }
                            if((form_detail["second_resident_name_middle_name"]?.exists()) != nil)
                            {
                                self.txtres2_MName.text = form_detail["second_resident_name_middle_name"]?.stringValue
                            }
                            if((form_detail["second_resident_dob"]?.exists()) != nil)
                            {
                                self.btnres2_DOB.setTitle(form_detail["second_resident_dob"]?.stringValue, for: .normal)
                            }
                            if((form_detail["half_month_deposit_for_second_resident_rate"]?.exists()) != nil)
                            {
                                self.txtHalfMRentalDepositfor2ndRes.text = form_detail["half_month_deposit_for_second_resident_rate"]?.stringValue
                            }
                        }
                    }
                    if((form_detail["first_month_payment_received"]?.exists()) != nil)
                    {
                        if(form_detail["first_month_payment_received"]?.intValue == 1)
                        {
                            self.btnPaymentReceived.isSelected = true
                            self.vw_PaymentChqNum.isHidden = false
                            self.vw_PaymentChqDate.isHidden = false
                            self.vw_PaymentChqTotal.isHidden = false
                            self.cns_stkPaymentReceivedBottom.constant = 10
                                                       
                            if((form_detail["first_month_payment_received_cheque_note"]?.exists()) != nil)
                            {
                                self.txtPaymentChqNum.text = form_detail["first_month_payment_received_cheque_note"]?.stringValue
                            }
                            if((form_detail["first_month_payment_received_cheque_amount"]?.exists()) != nil)
                            {
                                self.txtPaymentChqTotal.text = form_detail["first_month_payment_received_cheque_amount"]?.stringValue
                            }
                            if((form_detail["first_month_payment_received_cheque_date"]?.exists()) != nil)
                            {
                                self.btnPaymentChqDate.setTitle(form_detail["first_month_payment_received_cheque_date"]?.stringValue, for: .normal)
                            }
                        }
                    }
                    if((form_detail["monthly_rate"]?.exists()) != nil)
                    {
                        self.txtMonthlyRate.text = form_detail["monthly_rate"]?.stringValue
                    }
                    if((form_detail["care_plan_rate"]?.exists()) != nil)
                    {
                        self.txtCarePlanRate.text = form_detail["care_plan_rate"]?.stringValue
                    }
                    if((form_detail["one_time_move_in_fee"]?.exists()) != nil)
                    {
                        self.txt1TimeMoveInFee.text = form_detail["one_time_move_in_fee"]?.stringValue
                    }
                    if((form_detail["parking_rate"]?.exists()) != nil)
                    {
                        self.txtParkingRate.text = form_detail["parking_rate"]?.stringValue
                    }
                    if((form_detail["parking_quantity"]?.exists()) != nil)
                    {
                        self.txtParkingQuantity.text = form_detail["parking_quantity"]?.stringValue
                    }
                    if((form_detail["scooter_rate"]?.exists()) != nil)
                    {
                        self.txtScooterRate.text = form_detail["scooter_rate"]?.stringValue
                    }
                    if((form_detail["scooter_quantity"]?.exists()) != nil)
                    {
                        self.txtScooterQuantity.text = form_detail["scooter_quantity"]?.stringValue
                    }
                    if((form_detail["window_screen_rate"]?.exists()) != nil)
                    {
                        self.txtWindowScreenRate.text = form_detail["window_screen_rate"]?.stringValue
                    }
                    if((form_detail["window_screen_quantity"]?.exists()) != nil)
                    {
                        self.txtWindowScreenQuantity.text = form_detail["window_screen_quantity"]?.stringValue
                    }
                    if((form_detail["grab_bar_rate"]?.exists()) != nil)
                    {
                        self.txtGrabBarRate.text = form_detail["grab_bar_rate"]?.stringValue
                    }
                    if((form_detail["grab_bar_quantity"]?.exists()) != nil)
                    {
                        self.txtGrabBarQuantity.text = form_detail["grab_bar_quantity"]?.stringValue
                    }
                    if((form_detail["payment_others_rate"]?.exists()) != nil)
                    {
                        self.txtPaymentOthers.text = form_detail["payment_others_rate"]?.stringValue
                    }
                    if((form_detail["security_deposit_received"]?.exists()) != nil)
                    {
                        if(form_detail["security_deposit_received"]?.intValue == 1)
                        {
                            self.btnDepositReceived.isSelected = true
                            self.vw_DepositChqNum.isHidden = false
                            self.vw_DepositChqDate.isHidden = false
                            self.vw_DepositChqTotal.isHidden = false
                            self.cns_stkDepositReceivedBottom.constant = 15
                              
                            if((form_detail["security_deposit_received_cheque_note"]?.exists()) != nil)
                            {
                                self.txtDepositChqNum.text = form_detail["security_deposit_received_cheque_note"]?.stringValue
                            }
                            if((form_detail["security_deposit_received_cheque_amount"]?.exists()) != nil)
                            {
                                self.txtDepositChqTotal.text = form_detail["security_deposit_received_cheque_amount"]?.stringValue
                            }
                            if((form_detail["security_deposit_received_cheque_date"]?.exists()) != nil)
                            {
                                self.btnDepositChqDate.setTitle(form_detail["security_deposit_received_cheque_date"]?.stringValue, for: .normal)
                            }
                        }
                    }
                    if((form_detail["half_month_deposit_for_first_resident_rate"]?.exists()) != nil)
                    {
                        self.txtHalfMRentalDepositfor1stRes.text = form_detail["half_month_deposit_for_first_resident_rate"]?.stringValue
                    }
                    if((form_detail["half_month_care_plan_rate"]?.exists()) != nil)
                    {
                        self.txtHalfMCarePlan.text = form_detail["half_month_care_plan_rate"]?.stringValue
                    }
                    if((form_detail["move_in_out_rate"]?.exists()) != nil)
                    {
                        self.txtMoveInOut.text = form_detail["move_in_out_rate"]?.stringValue
                    }
                    if((form_detail["elpas_rate"]?.exists()) != nil)
                    {
                        self.txtElpasRate.text = form_detail["elpas_rate"]?.stringValue
                    }
                    if((form_detail["elpas_quantity"]?.exists()) != nil)
                    {
                        self.txtElpasQuantity.text = form_detail["elpas_quantity"]?.stringValue
                    }
                    if((form_detail["garage_fob_rate"]?.exists()) != nil)
                    {
                        self.txtGarageFobRate.text = form_detail["garage_fob_rate"]?.stringValue
                    }
                    if((form_detail["garage_fob_quantity"]?.exists()) != nil)
                    {
                        self.txtGarageFobQuantity.text = form_detail["garage_fob_quantity"]?.stringValue
                    }
                    if((form_detail["deposit_others_rate"]?.exists()) != nil)
                    {
                        self.txtDepositOthers.text = form_detail["deposit_others_rate"]?.stringValue
                    }
                    if((form_detail["payor_information_Post_Dated_Cheque"]?.exists()) != nil)
                    {
                        if(form_detail["payor_information_Post_Dated_Cheque"]?.intValue == 1)
                        {
                            self.btnPayorInfoPDChq.isSelected = true
                        }
                    }
                    if((form_detail["payor_information_PAD"]?.exists()) != nil)
                    {
                        if(form_detail["payor_information_PAD"]?.intValue == 1)
                        {
                            self.btnPayorInfoPAD.isSelected = true
                            self.vw_PayerName.isHidden = false
                            self.vw_BankName.isHidden = false
                            self.vw_BankID.isHidden = false
                            self.vw_AccountNumber.isHidden = false
                            self.vw_Transit.isHidden = false
                            self.cns_stkPADInfoBottom.constant =  10
                      
                            if((form_detail["payor_name"]?.exists()) != nil)
                            {
                                self.txtPayerName.text = form_detail["payor_name"]?.stringValue
                            }
                            if((form_detail["bank_name"]?.exists()) != nil)
                            {
                                self.txtBankName.text = form_detail["bank_name"]?.stringValue
                            }
                            if((form_detail["bank_ID"]?.exists()) != nil)
                            {
                                self.txtBankID.text = form_detail["bank_ID"]?.stringValue
                            }
                            if((form_detail["account_number"]?.exists()) != nil)
                            {
                                self.txtAccountNumber.text = form_detail["account_number"]?.stringValue
                            }
                            if((form_detail["transit"]?.exists()) != nil)
                            {
                                self.txtTransit.text = form_detail["transit"]?.stringValue
                            }
                        }
                    }
                    if((form_detail["unit_key"]?.exists()) != nil)
                    {
                        if(form_detail["unit_key"]?.intValue == 1)
                        {
                            self.btnUnitKey.isSelected = true
                            self.txtUnitKey.isHidden = false
                            if((form_detail["unit_key_value"]?.exists()) != nil)
                            {
                                self.txtUnitKey.text = form_detail["unit_key_value"]?.stringValue
                            }
                        }
                    }
                    if((form_detail["elpas_fob"]?.exists()) != nil)
                    {
                        if(form_detail["elpas_fob"]?.intValue == 1)
                        {
                            self.btnElpasFOB.isSelected = true
                            self.txtElpasFOB.isHidden = false
                            if((form_detail["elpas_fob_value"]?.exists()) != nil)
                            {
                                self.txtElpasFOB.text = form_detail["elpas_fob_value"]?.stringValue
                            }
                        }
                    }
                    if((form_detail["suite_insurance_copy_received"]?.exists()) != nil)
                    {
                        if(form_detail["suite_insurance_copy_received"]?.intValue == 1)
                        {
                            self.btnInsCopyReceived.isSelected = true
                            self.btnInsCopyReceivedDate.isHidden = false
                            self.cns_hgt_btnInsCopyReceivedDate.constant =  30
                            self.cns_btnInsCopyReceivedDateBottom.constant = 10
                            
                            if((form_detail["suite_insurance_copy_received_date"]?.exists()) != nil)
                            {
                                self.btnInsCopyReceivedDate.setTitle(form_detail["suite_insurance_copy_received_date"]?.stringValue, for: .normal)
                            }
                        }
                    }
                    if((form_detail["suite_insurance_coverage_approved"]?.exists()) != nil)
                    {
                        if(form_detail["suite_insurance_coverage_approved"]?.intValue == 1)
                        {
                            self.btnInsCovrApproved.isSelected = true
                            self.vw_InsCmpName.isHidden = false
                            self.vw_PolicyNumber.isHidden = false
                            self.cns_stkInsCovrApprovedBottom.constant = 10
                                                   
                            if((form_detail["insurance_company_name"]?.exists()) != nil)
                            {
                                self.txtInsCmpName.text = form_detail["insurance_company_name"]?.stringValue
                            }
                            if((form_detail["policy_number"]?.exists()) != nil)
                            {
                                self.txtPolicyNumber.text = form_detail["policy_number"]?.stringValue
                            }
                        }
                    }
                    if((form_detail["reviewed_by"]?.exists()) != nil)
                    {
                        self.txtReviewedBy.text = form_detail["reviewed_by"]?.stringValue
                    }
                    if((form_detail["date"]?.exists()) != nil)
                    {
                        self.btnDate.setTitle(form_detail["date"]?.stringValue, for: .normal)
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
    
}
