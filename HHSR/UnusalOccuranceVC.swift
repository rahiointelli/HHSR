//
//  SearchRoomVC.swift
//  DiningApp
//
//  Created by Intelli on 2023-01-11.
//

import UIKit
import SwiftyJSON
import TLPhotoPicker
import Photos
import AVKit
import MobileCoreServices
import SDWebImage

class UnusalOccuranceVC: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, TLPhotosPickerViewControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{

    @IBOutlet weak var act_indicator: UIActivityIndicatorView!
    @IBOutlet var dtPicker : UIDatePicker!
    @IBOutlet weak var vw_clearBG: UIView!
    @IBOutlet weak var vw_header: UIView!
    @IBOutlet var vw_DatePickerContainer: UIView!
    @IBOutlet weak var vw_Name1 : UIView!
    @IBOutlet weak var vw_Position1 : UIView!
    @IBOutlet weak var vw_Name2 : UIView!
    @IBOutlet weak var vw_Position2 : UIView!
    @IBOutlet weak var txt_Witness_Name1 : UITextField!
    @IBOutlet weak var txt_Witness_Position1 : UITextField!
    @IBOutlet weak var txt_Witness_Name2 : UITextField!
    @IBOutlet weak var txt_Witness_Position2 : UITextField!
    @IBOutlet weak var btnWitnessYes : UIButton!
    @IBOutlet weak var btnWitnessNo : UIButton!
    @IBOutlet weak var txtFactual : UITextView!
    @IBOutlet weak var btnOtherIncInvolved : UIButton!
    @IBOutlet weak var vw_OtherIncInvolved : UIView!
    @IBOutlet weak var txt_OtherIncInvolved : UITextField!
    @IBOutlet weak var btnOtherTypeOfInc : UIButton!
    @IBOutlet weak var txtOtherTypeOfInc : UITextField!
    @IBOutlet weak var txtOtherSafetyDevices : UITextField!
    @IBOutlet weak var btnOtherCondAtInc : UIButton!
    @IBOutlet weak var vw_OtherCondAtInc : UIView!
    @IBOutlet weak var txt_OtherCondAtInc : UITextField!
    @IBOutlet weak var btnOtherAmbulation : UIButton!
    @IBOutlet weak var vw_OtherAmbulation : UIView!
    @IBOutlet weak var txt_OtherAmbulation : UITextField!
    @IBOutlet weak var btnOtherInformOfInc : UIButton!
    @IBOutlet weak var txtOtherInformOfInc : UITextField!
    @IBOutlet weak var btnNotiResidentYes : UIButton!
    @IBOutlet weak var btnNotiResidentNo : UIButton!
    @IBOutlet weak var vw_NotiResident_Name : UIView!
    @IBOutlet weak var vw_NotiResident_Date : UIView!
    @IBOutlet weak var txtIssue : UITextView!
    @IBOutlet weak var txtFindings : UITextView!
    @IBOutlet weak var txtSolutions : UITextView!
    @IBOutlet weak var txtActionPlan : UITextView!
    @IBOutlet weak var txtFollowUp : UITextView!
    @IBOutlet weak var txtLocOfInc : UITextField!
    @IBOutlet weak var txtLocOfDisc : UITextField!
    @IBOutlet weak var txtWitnessedBy : UITextField!
    @IBOutlet weak var txtDiscoveredBy : UITextField!
    @IBOutlet weak var btnDateOfInc : UIButton!
    @IBOutlet weak var btnDateOfDisc : UIButton!
    @IBOutlet weak var btnDateOfNotiRes : UIButton!
    @IBOutlet weak var btnNotiDateTime : UIButton!
    
    @IBOutlet weak var stk_Fob : UIStackView!
    @IBOutlet weak var stk_CallBell : UIStackView!
    @IBOutlet weak var stk_Caution : UIStackView!
    @IBOutlet weak var stk_FireAlarmPulled : UIStackView!
    @IBOutlet weak var stk_FireFalseAlarm : UIStackView!
    @IBOutlet weak var stk_FireExti : UIStackView!
    @IBOutlet weak var stk_FirePerInjury : UIStackView!
    @IBOutlet weak var stk_FirePropDamage : UIStackView!
    @IBOutlet weak var txtINIAssistantGM : UITextField!
    @IBOutlet weak var txtINIGM : UITextField!
    @IBOutlet weak var txtINIRiskMangCm : UITextField!
    @IBOutlet weak var txtINIOther : UITextField!
    @IBOutlet weak var txtNotiFamDoc : UITextField!
    @IBOutlet weak var btnDateOfNotiFamDoc : UIButton!
    @IBOutlet weak var txtNotiOther : UITextField!
    @IBOutlet weak var btnDateOfNotiOther : UIButton!
    @IBOutlet weak var txtNotiResName : UITextField!
    @IBOutlet weak var txtNotiCompletedBy : UITextField!
    @IBOutlet weak var txtNotiPosition : UITextField!
    
    @IBOutlet weak var btnIncInvResident : UIButton!
    @IBOutlet weak var btnIncInvVisitor : UIButton!
    @IBOutlet weak var btnIncInvStaff : UIButton!
    
    
    @IBOutlet weak var btnCondOriented : UIButton!
    @IBOutlet weak var btnCondDisoriented : UIButton!
    @IBOutlet weak var btnCondSedated : UIButton!
    @IBOutlet weak var btnFallAsMediChange : UIButton!
    @IBOutlet weak var btnFallAsCardMedi : UIButton!
    @IBOutlet weak var btnFallAsVisualDef : UIButton!
    @IBOutlet weak var btnFallAsMoodAltMed : UIButton!
    @IBOutlet weak var btnFallAsReloc : UIButton!
    @IBOutlet weak var btnFallAsTempIllness : UIButton!
    @IBOutlet weak var btnAmbuUnlimited : UIButton!
    @IBOutlet weak var btnAmbuLimited : UIButton!
    @IBOutlet weak var btnAmbuReqAssistance : UIButton!
    @IBOutlet weak var btnAmbuWheelchair : UIButton!
    @IBOutlet weak var btnAmbuWalker : UIButton!
    @IBOutlet weak var btnTypeOfIncFall : UIButton!
    @IBOutlet weak var btnTypeOfIncFire : UIButton!
    @IBOutlet weak var btnTypeOfIncSecurity : UIButton!
    @IBOutlet weak var btnTypeOfIncElopement : UIButton!
    @IBOutlet weak var btnTypeOfIncDeath : UIButton!
    @IBOutlet weak var btnTypeOfIncResidentAbase : UIButton!
    @IBOutlet weak var btnTypeOfIncTreatment : UIButton!
    @IBOutlet weak var btnTypeOfIncLossOfProperty : UIButton!
    @IBOutlet weak var btnTypeOfIncChoking : UIButton!
    @IBOutlet weak var btnTypeOfIncAggressiveBehavior : UIButton!
    @IBOutlet weak var btnINIAssistantGM : UIButton!
    @IBOutlet weak var btnINIGM : UIButton!
    @IBOutlet weak var btnINIRiskMangCm : UIButton!
    
    @IBOutlet weak var lblAttachmentCount: UIButton!
    @IBOutlet weak var tblAttachmentList: UICollectionView!
    @IBOutlet weak var cns_tblAttachmentHeight: NSLayoutConstraint!
    @IBOutlet weak var vw_FollowUp: UIView!
    @IBOutlet weak var vw_chkMarkFollowUp: UIView!
    @IBOutlet weak var btnShowFollowUp: UIButton!
    @IBOutlet weak var scl_view: UIScrollView!
    @IBOutlet weak var stk_followUp: UIStackView!
    
    let imagePicker = UIImagePickerController()
    let customImagePicker = CustomPhotoPickerViewController()
    var selectedAssets = [PHAsset]()
    var CapturedImages : [Data] = []
    var SelectedImages : [Data] = []
    var CapturedVideos : [URL] = []
    var CapturedVidThumbs : [UIImage] = []
    var SelectedVideos : [URL] = []
    var SelectedOriginalVideos : [URL] = []
    var SelectedVidThumbs : [UIImage] = []
    var CapturedImage : Data? = nil
    var CapturedVideo : URL? = nil
    var CapturedVidThumb : UIImage? = nil
    var VideoCompressionStatus : [(URL, Bool)] = []
    var SelectedAssetsSize = 0.0
    let maximumAllowedAttachments = 7
    let MessageMaximumAttachments = "Maximum 7 attachments can be added."
    let MessageMaximumFileSize = "Total Attachments size must be less than 30 MB."
    let MaxTotalUploadFilesSizeInMB = 30.0
    var TotalAddedSize = 0.0
    var arAttachmentMappingContainer : [(String,String)] = []
    var SelectedImageNames : [String] = []
    var SelectedVideoNames : [String] = []
    var arEditAttachments : [clsAttachment] = []
    
    var safetyFobVal = "No"
    var safetyCallBellVal = "No"
    var safetyCautionVal = "No"
    var FireAlarmPulledVal = "No"
    var FireFalseAlarmVal = "No"
    var FireExtiVal = "No"
    var FirePerInjuryVal = "No"
    var FirePropDamageVal = "No"
    var CurrentDateSelection = "Incident"
    let dtpickerWidth : CGFloat = ((UIDevice.current.userInterfaceIdiom == .pad) ? 450 : 300)
    var calledFrom = "Add"
    var form_id = 0
    var isFollowUpIncomplete = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        //UNUSAL OCCURANCE INCIDENT REPORT
        if(AppDelegate.sharedDelegate().UserRole == "concierge" || AppDelegate.sharedDelegate().UserRole == "nurse")
        {
            self.vw_chkMarkFollowUp.isHidden = true
            self.vw_FollowUp.isHidden = true
        }
        else if(self.calledFrom == "Add")
        {
            self.vw_FollowUp.isHidden = true
        }
        else
        {
            self.vw_FollowUp.isHidden = false
            self.btnShowFollowUp.isSelected = true
        }
        
        //self.txtFactual.backgroundColor = UIColor.white
        self.txtFactual.layer.borderColor = UIColor.black.cgColor
        self.txtFactual.layer.borderWidth = 1.0
        self.txtIssue.layer.borderColor = UIColor.black.cgColor
        self.txtIssue.layer.borderWidth = 1.0
        self.txtFindings.layer.borderColor = UIColor.black.cgColor
        self.txtFindings.layer.borderWidth = 1.0
        self.txtSolutions.layer.borderColor = UIColor.black.cgColor
        self.txtSolutions.layer.borderWidth = 1.0
        self.txtActionPlan.layer.borderColor = UIColor.black.cgColor
        self.txtActionPlan.layer.borderWidth = 1.0
        self.txtFollowUp.layer.borderColor = UIColor.black.cgColor
        self.txtFollowUp.layer.borderWidth = 1.0
        
        self.tblAttachmentList.register(UINib(nibName: "MediaAttachmentListTblCell", bundle: nil), forCellWithReuseIdentifier: "MediaAttachmentListTblCell")
        self.imagePicker.delegate = self
        self.customImagePicker.delegate = self
        var configure = TLPhotosPickerConfigure()
        configure.numberOfColumn = 3
        configure.maxSelectedAssets = self.maximumAllowedAttachments
        customImagePicker.configure = configure
//
//        if #available(iOS 13.4, *) {
//            self.dtPicker.preferredDatePickerStyle = .wheels
//        } else {
//            // Fallback on earlier versions
//        }
//        self.dtPicker.datePickerMode = .dateAndTime
        if #available(iOS 13.0, *) {
            self.dtPicker.overrideUserInterfaceStyle = .light
        }
        
        self.txtFactual.backgroundColor = .white
        self.txtIssue.backgroundColor = .white
        self.txtFindings.backgroundColor = .white
        self.txtSolutions.backgroundColor = .white
        self.txtActionPlan.backgroundColor = .white
        self.txtFollowUp.backgroundColor = .white
        
        if(self.calledFrom == "Edit")
        {
            self.CallFormDetailService()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(self.calledFrom == "Edit")
        {
            return self.arEditAttachments.count
        }
        return self.arAttachmentMappingContainer.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MediaAttachmentListTblCell",for:indexPath) as! MediaAttachmentListTblCell
       
        cell.btn_remove.tag = indexPath.row
        cell.btn_remove.addTarget(self, action: #selector(btnRemoveAttachmentClicked(_:)), for: .touchUpInside)
        
        if(self.calledFrom == "Edit")
        {
            if(self.arEditAttachments[indexPath.row].MediaType == "image")
            {
                cell.imgMedia.sd_setImage(with: URL(string: self.arEditAttachments[indexPath.row].Path), placeholderImage: nil, options: .refreshCached, completed: nil)
                //cell.imgMedia.image = self.arEditAttachments[indexPath.row].Path
                cell.imgVideoIcon.isHidden = true
            }
            else
            {
                if(self.arEditAttachments[indexPath.row].ThumbImage.count > 0)
                {
                    cell.imgMedia.sd_setImage(with: URL(string: self.arEditAttachments[indexPath.row].ThumbImage), placeholderImage: nil, options: .refreshCached, completed: nil)
                }
                else
                {
                    cell.imgMedia.image = UIImage(named: "img_food")
                }
                cell.imgVideoIcon.isHidden = false
            }
        }
        else
        {
            let idx = self.arAttachmentMappingContainer[indexPath.row].1
            
            if(self.arAttachmentMappingContainer[indexPath.row].0 == "CapturedImages")
            {
                cell.imgMedia.image = UIImage(data: self.CapturedImages[Int(idx)!])
                cell.imgVideoIcon.isHidden = true
            }
            else if(self.arAttachmentMappingContainer[indexPath.row].0 == "CapturedVideos")
            {
                cell.imgMedia.image = self.CapturedVidThumbs[Int(idx)!]
                cell.imgVideoIcon.isHidden = false
            }
            else if(self.arAttachmentMappingContainer[indexPath.row].0 == "SelectedImages")
            {
                cell.imgMedia.image = UIImage(data: self.SelectedImages[Int(idx)!])
                cell.imgVideoIcon.isHidden = true
            }
            else if(self.arAttachmentMappingContainer[indexPath.row].0 == "SelectedVideos")
            {
                cell.imgMedia.image = self.SelectedVidThumbs[Int(idx)!]
                cell.imgVideoIcon.isHidden = false
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print("hgt and wd")
        return CGSize(width: 80.0, height: 100.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(self.calledFrom == "Edit")
        {
            if(self.arEditAttachments[indexPath.row].MediaType == "image")
            {
                let FullImgVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FullmageVC") as! FullmageVC
                
                DispatchQueue.main.async { [weak self] in
                    if let imageData = try? Data(contentsOf: URL(string: self!.arEditAttachments[indexPath.row].Path)!) {
                        if let loadedImage = UIImage(data: imageData) {
                            FullImgVC.imgToLoad = loadedImage
                            self!.navigationController?.pushViewController(FullImgVC, animated: false)
                        }
                    }
                }
//                FullImgVC.imgToLoad =  UIImage(data: Data(contentsOf: URL(string: self.arEditAttachments[indexPath.row].Path)!))
//                self.navigationController?.pushViewController(FullImgVC, animated: false)
            }
            else
            {
                let player = AVPlayer(url: URL(string:self.arEditAttachments[indexPath.row].Path)!)
                let playerViewController = AVPlayerViewController()
                playerViewController.player = player
                self.present(playerViewController, animated: true) {
                    playerViewController.player!.play()
                }
            }
        }
        else
        {
            let idx = self.arAttachmentMappingContainer[indexPath.row].1
            if(self.arAttachmentMappingContainer[indexPath.row].0 == "CapturedImages")
            {
                let FullImgVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FullmageVC") as! FullmageVC
                FullImgVC.imgToLoad =  UIImage(data: self.CapturedImages[Int(idx)!])
                self.navigationController?.pushViewController(FullImgVC, animated: false)
            }
            else if(self.arAttachmentMappingContainer[indexPath.row].0 == "CapturedVideos")
            {
                let player = AVPlayer(url: self.CapturedVideos[Int(idx)!])
                let playerViewController = AVPlayerViewController()
                playerViewController.player = player
                self.present(playerViewController, animated: true) {
                    playerViewController.player!.play()
                }
            }
            else if(self.arAttachmentMappingContainer[indexPath.row].0 == "SelectedImages")
            {
                let FullImgVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FullmageVC") as! FullmageVC
                FullImgVC.imgToLoad =  UIImage(data: self.SelectedImages[Int(idx)!])
                self.navigationController?.pushViewController(FullImgVC, animated: false)
            }
            else if(self.arAttachmentMappingContainer[indexPath.row].0 == "SelectedVideos")
            {
                let player = AVPlayer(url: self.SelectedVideos[Int(idx)!])
                let playerViewController = AVPlayerViewController()
                playerViewController.player = player
                self.present(playerViewController, animated: true) {
                    playerViewController.player!.play()
                }
            }
        }
    }
    
    @objc func btnRemoveAttachmentClicked(_ sender: Any)
    {
        if(self.calledFrom == "Edit")
        {
            let btn = sender as! UIButton
            
            let alert = UIAlertController(title: "Delete Confirmation", message: "Are you sure to delete this attachment?", preferredStyle: .alert)
                                         
             let YesAction = UIAlertAction(title: "Yes", style: .default, handler:{ (action)in
                                                                         
              self.view.isUserInteractionEnabled = false
              self.act_indicator.startAnimating()
                 
                 NetworkUtilities.shared.makePOSTRequest(with: API.baseURL + "delete-form-attachment-phase1", parameters: ["form_id" : self.form_id, "attachment_id" : self.arEditAttachments[btn.tag].Id!]) { (response) in
                       
                        self.view.isUserInteractionEnabled = true
                        self.act_indicator.stopAnimating()
                   
                        if (response.error == nil)
                        {
                            if(response.result[MainResponseCodeConstant.keyResponseCode].intValue == MainResponseCodeConstant.keyResponseCodeOne)
                            {
                                print("success")
                                
                                self.arEditAttachments =
                                (response.result["attachments"].arrayValue.compactMap(clsAttachment.init))
                                
                                self.TotalAddedSize = self.arEditAttachments.map({ Double($0.MediaSize) * 0.001 }).reduce(0, +)
                                
                                if(self.arEditAttachments.count == 0)
                                {
                                    self.lblAttachmentCount.setTitle("No Attachment", for: .normal)
                                    self.lblAttachmentCount.setTitleColor(UIColor.ColorCodes.addPrjLightGrayColor, for: .normal)
                                    self.cns_tblAttachmentHeight.constant = 0
                                }
                                else if(self.arEditAttachments.count == 1)
                                {
                                    self.lblAttachmentCount.setTitle("1 Attachment", for: .normal)
                                    self.cns_tblAttachmentHeight.constant = 100
                                }
                                else
                                {
                                    self.lblAttachmentCount.setTitle("\(self.arEditAttachments.count) Attachments", for: .normal)
                                    self.cns_tblAttachmentHeight.constant = 100
                                }
                                
                                self.tblAttachmentList.reloadData()
                                self.showMessageAlert(message:"Attachment Deleted Successfully.")
                                
                                NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationNamesConstant.keyAttachmentUpdated), object: nil, userInfo: [PushNotificationKeysConstant.keyFormId:  self.form_id, PushNotificationKeysConstant.keyFormPDFURL : response.result["newLink"].stringValue])
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
             })
             alert.addAction(YesAction)
                      
             alert.addAction(UIAlertAction(title: "No", style: .default, handler:{ (action)in
                   print("User click Dismiss button")
             }))
               
               DispatchQueue.main.async
               {
                   if ( UIDevice.current.model.range(of: "iPad") != nil)
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
        else
        {
            let btn = sender as! UIButton
            let type = self.arAttachmentMappingContainer[btn.tag].0
            let idx = self.arAttachmentMappingContainer[btn.tag].1
            if(type == "CapturedImages")
            {
                self.CapturedImages.remove(at: Int(idx)!)
                self.arAttachmentMappingContainer.remove(at: btn.tag)
            }
            else if(type == "CapturedVideos")
            {
                self.CapturedVideos.remove(at: Int(idx)!)
                self.CapturedVidThumbs.remove(at: Int(idx)!)
                self.arAttachmentMappingContainer.remove(at: btn.tag)
            }
            else if(type == "SelectedImages")
            {
                self.SelectedImages.remove(at: Int(idx)!)
                self.SelectedImageNames.remove(at : Int(idx)!)
                self.arAttachmentMappingContainer.remove(at: btn.tag)
            }
            else if(type == "SelectedVideos")
            {
                self.SelectedVideos.remove(at: Int(idx)!)
                self.SelectedVidThumbs.remove(at: Int(idx)!)
                self.SelectedVideoNames.remove(at : Int(idx)!)
                self.arAttachmentMappingContainer.remove(at: btn.tag)
            }
            
            for k in 0..<self.arAttachmentMappingContainer.count
            {
                var obj = self.arAttachmentMappingContainer[k]
                if(obj.0 == type && Int(obj.1)! > Int(idx)! )
                {
                    obj.1 = "\(Int(obj.1)! - 1)"
                    self.arAttachmentMappingContainer[k] = obj
                }
            }
            
            if(self.arAttachmentMappingContainer.count == 0)
            {
                self.lblAttachmentCount.setTitle("No Attachment", for: .normal)
                self.lblAttachmentCount.setTitleColor(UIColor.ColorCodes.addPrjLightGrayColor, for: .normal)
                self.cns_tblAttachmentHeight.constant = 0
            }
            else if(self.arAttachmentMappingContainer.count == 1)
            {
                self.lblAttachmentCount.setTitle("1 Attachment", for: .normal)
                self.cns_tblAttachmentHeight.constant = 100
            }
            else
            {
                self.lblAttachmentCount.setTitle("\(self.arAttachmentMappingContainer.count) Attachments", for: .normal)
                self.cns_tblAttachmentHeight.constant = 100
            }
            
            self.tblAttachmentList.reloadData()
        }
    }
    
    
    @IBAction func btnScheduleIncidentClicked(_ sender: Any)
    {
                
        self.view.endEditing(true)
        self.vw_clearBG.isHidden = false
        self.vw_header.isUserInteractionEnabled = false
        let wd = UIScreen.main.bounds.size.width
        
        self.vw_DatePickerContainer.frame = CGRect(x: (wd - dtpickerWidth)/2, y: ((UIScreen.main.bounds.size.height - self.vw_DatePickerContainer.frame.size.height)/2), width: dtpickerWidth, height: self.vw_DatePickerContainer.frame.size.height)
   
        self.view.addSubview(self.vw_DatePickerContainer)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy hh:mm a"
        dateFormatter.locale = self.dtPicker.locale
        //"dd MMM YYYY hh:mm a"
        // HH:mm:ss z
        if(self.btnDateOfInc.title(for: .normal) != "Select Date/Time")
        {
            let date = dateFormatter.date(from: self.btnDateOfInc.title(for: .normal)!)
            dateFormatter.dateFormat =  "yyyy-MM-dd hh:mm a"
            let yourDate = dateFormatter.string(from: date!)
           
            print(yourDate)
            self.dtPicker.date = dateFormatter.date(from: yourDate)!
        }
        else
        {
            self.dtPicker.date = Date()
        }
        self.CurrentDateSelection = "Incident"
    }
    
    @IBAction func btnScheduleDiscoveryClicked(_ sender: Any)
    {
                
        self.view.endEditing(true)
        self.vw_clearBG.isHidden = false
        self.vw_header.isUserInteractionEnabled = false
        let wd = UIScreen.main.bounds.size.width
        
        self.vw_DatePickerContainer.frame = CGRect(x: (wd - dtpickerWidth)/2, y: ((UIScreen.main.bounds.size.height - self.vw_DatePickerContainer.frame.size.height)/2), width: dtpickerWidth, height: self.vw_DatePickerContainer.frame.size.height)
   
        self.view.addSubview(self.vw_DatePickerContainer)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy hh:mm a"
        dateFormatter.locale = self.dtPicker.locale
        //"dd MMM YYYY hh:mm a"
        // HH:mm:ss z
        if(self.btnDateOfDisc.title(for: .normal) != "Select Date/Time")
        {
            let date = dateFormatter.date(from: self.btnDateOfDisc.title(for: .normal)!)
            dateFormatter.dateFormat =  "yyyy-MM-dd hh:mm a"
            let yourDate = dateFormatter.string(from: date!)
           
            print(yourDate)
            self.dtPicker.date = dateFormatter.date(from: yourDate)!
        }
        else
        {
            self.dtPicker.date = Date()
        }
        self.CurrentDateSelection = "Discovery"
    }
    
    @IBAction func btnNotiResiDateClicked(_ sender: Any)
    {
                
        self.view.endEditing(true)
        self.vw_clearBG.isHidden = false
        self.vw_header.isUserInteractionEnabled = false
        let wd = UIScreen.main.bounds.size.width
        
        self.vw_DatePickerContainer.frame = CGRect(x: (wd - dtpickerWidth)/2, y: ((UIScreen.main.bounds.size.height - self.vw_DatePickerContainer.frame.size.height)/2), width: dtpickerWidth, height: self.vw_DatePickerContainer.frame.size.height)
   
        self.view.addSubview(self.vw_DatePickerContainer)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy hh:mm a"
        dateFormatter.locale = self.dtPicker.locale
        //"dd MMM YYYY hh:mm a"
        // HH:mm:ss z
        if(self.btnDateOfNotiRes.title(for: .normal) != "Select Date/Time")
        {
            let date = dateFormatter.date(from: self.btnDateOfNotiRes.title(for: .normal)!)
            dateFormatter.dateFormat =  "yyyy-MM-dd hh:mm a"
            let yourDate = dateFormatter.string(from: date!)
           
            print(yourDate)
            self.dtPicker.date = dateFormatter.date(from: yourDate)!
        }
        else
        {
            self.dtPicker.date = Date()
        }
        self.CurrentDateSelection = "NotifiedResident"
    }
    
    @IBAction func btnNotiDateTimeClicked(_ sender: Any)
    {
                
        self.view.endEditing(true)
        self.vw_clearBG.isHidden = false
        self.vw_header.isUserInteractionEnabled = false
        let wd = UIScreen.main.bounds.size.width
        
        self.vw_DatePickerContainer.frame = CGRect(x: (wd - dtpickerWidth)/2, y: ((UIScreen.main.bounds.size.height - self.vw_DatePickerContainer.frame.size.height)/2), width: dtpickerWidth, height: self.vw_DatePickerContainer.frame.size.height)
   
        self.view.addSubview(self.vw_DatePickerContainer)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy hh:mm a"
        dateFormatter.locale = self.dtPicker.locale
        //"dd MMM YYYY hh:mm a"
        // HH:mm:ss z
        if(self.btnNotiDateTime.title(for: .normal) != "Select Date/Time")
        {
            let date = dateFormatter.date(from: self.btnNotiDateTime.title(for: .normal)!)
            dateFormatter.dateFormat =  "yyyy-MM-dd hh:mm a"
            let yourDate = dateFormatter.string(from: date!)
           
            print(yourDate)
            self.dtPicker.date = dateFormatter.date(from: yourDate)!
        }
        else
        {
            self.dtPicker.date = Date()
        }
        self.CurrentDateSelection = "DateTime"
    }
    
    @IBAction func btnNotiFamDocDateTimeClicked(_ sender: Any)
    {
                
        self.view.endEditing(true)
        self.vw_clearBG.isHidden = false
        self.vw_header.isUserInteractionEnabled = false
        let wd = UIScreen.main.bounds.size.width
        
        self.vw_DatePickerContainer.frame = CGRect(x: (wd - dtpickerWidth)/2, y: ((UIScreen.main.bounds.size.height - self.vw_DatePickerContainer.frame.size.height)/2), width: dtpickerWidth, height: self.vw_DatePickerContainer.frame.size.height)
   
        self.view.addSubview(self.vw_DatePickerContainer)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy hh:mm a"
        dateFormatter.locale = self.dtPicker.locale
        //"dd MMM YYYY hh:mm a"
        // HH:mm:ss z
        if(self.btnDateOfNotiFamDoc.title(for: .normal) != "Select Date/Time")
        {
            let date = dateFormatter.date(from: self.btnDateOfNotiFamDoc.title(for: .normal)!)
            dateFormatter.dateFormat =  "yyyy-MM-dd hh:mm a"
            let yourDate = dateFormatter.string(from: date!)
           
            print(yourDate)
            self.dtPicker.date = dateFormatter.date(from: yourDate)!
        }
        else
        {
            self.dtPicker.date = Date()
        }
        self.CurrentDateSelection = "NotiFamDocDateTime"
    }
    
    @IBAction func btnNotiOtherDateTimeClicked(_ sender: Any)
    {
                
        self.view.endEditing(true)
        self.vw_clearBG.isHidden = false
        self.vw_header.isUserInteractionEnabled = false
        let wd = UIScreen.main.bounds.size.width
        
        self.vw_DatePickerContainer.frame = CGRect(x: (wd - dtpickerWidth)/2, y: ((UIScreen.main.bounds.size.height - self.vw_DatePickerContainer.frame.size.height)/2), width: dtpickerWidth, height: self.vw_DatePickerContainer.frame.size.height)
   
        self.view.addSubview(self.vw_DatePickerContainer)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy hh:mm a"
        dateFormatter.locale = self.dtPicker.locale
        //"dd MMM YYYY hh:mm a"
        // HH:mm:ss z
        if(self.btnDateOfNotiOther.title(for: .normal) != "Select Date/Time")
        {
            let date = dateFormatter.date(from: self.btnDateOfNotiOther.title(for: .normal)!)
            dateFormatter.dateFormat =  "yyyy-MM-dd hh:mm a"
            let yourDate = dateFormatter.string(from: date!)
           
            print(yourDate)
            self.dtPicker.date = dateFormatter.date(from: yourDate)!
        }
        else
        {
            self.dtPicker.date = Date()
        }
        self.CurrentDateSelection = "NotiOtherDateTime"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
            print("in disappear")
    }
    
    
    @IBAction func btnBack_Clicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
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
        formatter.dateFormat = "yyyy-MM-dd hh:mm a"
        
        let myString = formatter.string(from: self.dtPicker.date)
        let yourDate = formatter.date(from: myString)
        formatter.dateFormat = "dd MMM YYYY hh:mm a"
        let selectedDate = formatter.string(from: yourDate!)
        
        if(self.CurrentDateSelection == "Incident")
        {
            self.btnDateOfInc.setTitle(selectedDate, for: .normal)
        }
        else if(self.CurrentDateSelection == "Discovery")
        {
            self.btnDateOfDisc.setTitle(selectedDate, for: .normal)
        }
        else if(self.CurrentDateSelection == "NotifiedResident")
        {
            self.btnDateOfNotiRes.setTitle(selectedDate, for: .normal)
        }
        else if(self.CurrentDateSelection == "NotiFamDocDateTime")
        {
            self.btnDateOfNotiFamDoc.setTitle(selectedDate, for: .normal)
        }
        else if(self.CurrentDateSelection == "NotiOtherDateTime")
        {
            self.btnDateOfNotiOther.setTitle(selectedDate, for: .normal)
        }
        else
        {
            self.btnNotiDateTime.setTitle(selectedDate, for: .normal)
        }
             
    }
    
    @IBAction func btnSubmitClicked(_ sender: Any)
    {
        if(self.btnIncInvResident.isSelected == false && self.btnIncInvVisitor.isSelected == false && self.btnIncInvStaff.isSelected == false && self.btnOtherIncInvolved.isSelected == false)
        {
            self.showMessageAlert(message: "Please select Incident involved.")
        }
        else if(self.btnOtherIncInvolved.isSelected == true && self.txt_OtherIncInvolved.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0)
        {
            self.showMessageAlert(message: "Please enter other Incident involved.")
        }
        else if(self.btnDateOfInc.title(for: .normal) == "Select Date/Time")
        {
            self.showMessageAlert(message: "Please select Date/Time of Incident.")
        }
        else if(self.txtLocOfInc.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0)
        {
            self.showMessageAlert(message: "Please enter location of Incident.")
        }
        else if(self.txtWitnessedBy.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0)
        {
            self.showMessageAlert(message: "Please enter witnessed by.")
        }
        else if(self.btnDateOfDisc.title(for: .normal) == "Select Date/Time")
        {
            self.showMessageAlert(message: "Please select Date/Time of Discovery.")
        }
        else if(self.txtLocOfDisc.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0)
        {
            self.showMessageAlert(message: "Please enter location of Discovery.")
        }
        else if(self.txtDiscoveredBy.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0)
        {
            self.showMessageAlert(message: "Please enter discovered by.")
        }
        else if(self.btnOtherTypeOfInc.isSelected == true && self.txtOtherTypeOfInc.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0)
        {
            self.showMessageAlert(message: "Please enter other type of Incident.")
        }
        else if(self.btnWitnessYes.isSelected == true && self.txt_Witness_Name1.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0)
        {
            self.showMessageAlert(message: "Please enter witness Name.")
        }
        else if(self.btnWitnessYes.isSelected == true && self.txt_Witness_Position1.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0)
        {
            self.showMessageAlert(message: "Please enter witness Position.")
        }
        else if(self.btnOtherCondAtInc.isSelected == true && self.txt_OtherCondAtInc.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0)
        {
            self.showMessageAlert(message: "Please enter other condition at time of Incident.")
        }
        else if(self.btnOtherAmbulation.isSelected == true && self.txt_OtherAmbulation.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0)
        {
            self.showMessageAlert(message: "Please enter other Ambulation.")
        }
        else if(self.btnINIAssistantGM.isSelected == true && self.txtINIAssistantGM.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0)
        {
            self.showMessageAlert(message: "Please enter INITIAL for Assistant General Manager.")
        }
        else if(self.btnINIGM.isSelected == true && self.txtINIGM.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0)
        {
            self.showMessageAlert(message: "Please enter INITIAL for General Manager.")
        }
        else if(self.btnINIRiskMangCm.isSelected == true && self.txtINIRiskMangCm.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0)
        {
            self.showMessageAlert(message: "Please enter INITIAL for Risk Management Committee.")
        }
        else if(self.btnOtherInformOfInc.isSelected == true && self.txtOtherInformOfInc.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0)
        {
            self.showMessageAlert(message: "Please enter other for Informed of Incident.")
        }
        else if(self.btnOtherInformOfInc.isSelected == true && self.txtINIOther.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0)
        {
            self.showMessageAlert(message: "Please enter INITIAL for other.")
        }
        else if((self.txtNotiFamDoc.text?.trimmingCharacters(in: .whitespacesAndNewlines).count)! > 0 && self.btnDateOfNotiFamDoc.title(for: .normal) == "Select Date/Time")
        {
            self.showMessageAlert(message: "Please select Date/Time of notification to family doctor.")
        }
        else if((self.txtNotiOther.text?.trimmingCharacters(in: .whitespacesAndNewlines).count)! > 0 && self.btnDateOfNotiOther.title(for: .normal) == "Select Date/Time")
        {
            self.showMessageAlert(message: "Please select Date/Time of notification to other.")
        }
        else if(self.btnNotiResidentYes.isSelected == true && self.txtNotiResName.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0)
        {
            self.showMessageAlert(message: "Please enter Resident's responsible party Name.")
        }
        else if(self.btnNotiResidentYes.isSelected == true && self.btnDateOfNotiRes.title(for: .normal) == "Select Date/Time")
        {
            self.showMessageAlert(message: "Please select Date/Time of notification of Resident's responsible party.")
        }
        else if(self.txtNotiCompletedBy.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0)
        {
            self.showMessageAlert(message: "Please enter Completed By.")
        }
        else if(self.txtNotiPosition.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0)
        {
            self.showMessageAlert(message: "Please enter Position.")
        }
        else if(self.btnNotiDateTime.title(for: .normal) == "Select Date/Time")
        {
            self.showMessageAlert(message: "Please select Date/Time of Notification.")
        }
        else
        {
            if(self.calledFrom == "Edit")
            {
                if(AppDelegate.sharedDelegate().UserRole == "concierge" || AppDelegate.sharedDelegate().UserRole == "nurse" || self.vw_FollowUp.isHidden == true)
                {
                    self.callEditFormService()
                }
                else
                {
                    if(self.txtIssue.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0 || self.txtFindings.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0 || self.txtSolutions.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0 || self.txtActionPlan.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0 || self.txtFollowUp.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0)
                    {
                        let alert = UIAlertController(title: "", message: "Follow Up form is not completely filled. Do you still want to submit it?", preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
                            self.callEditFormService()
                        }))
                        
                        alert.addAction(UIAlertAction(title: "No", style: .default, handler: { (action) in
                        }))
                        
                        self.present(alert, animated: true)
                    }
                    else
                    {
                        self.callEditFormService()
                    }
                }
            }
            else
            {
                if(self.TotalAddedSize > self.MaxTotalUploadFilesSizeInMB)
                {
                    self.showMessageAlert(message: self.MessageMaximumFileSize)
                }
                else
                {
                    if(AppDelegate.sharedDelegate().UserRole == "concierge" || AppDelegate.sharedDelegate().UserRole == "nurse" || self.vw_FollowUp.isHidden == true)
                    {
                        self.callSubmitFormService()
                    }
                    else
                    {
                        if(self.txtIssue.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0 || self.txtFindings.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0 || self.txtSolutions.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0 || self.txtActionPlan.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0 || self.txtFollowUp.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0)
                        {
                            let alert = UIAlertController(title: "", message: "Follow Up form is not completely filled. Do you still want to submit it?", preferredStyle: .alert)
                            
                            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
                                self.callSubmitFormService()
                            }))
                            
                            alert.addAction(UIAlertAction(title: "No", style: .default, handler: { (action) in
                            }))
                            
                            self.present(alert, animated: true)
                        }
                        else
                        {
                            self.callSubmitFormService()
                        }
                    }
                }
            }
            //self.showMessageAlert(message: "validation passed.")
        }
        
    }
    
    func callEditFormService()
    {
        
        let dictItem = self.setValuesAsParameters()
  
        let json: JSON = JSON(dictItem)
        print("string converted object is \(json.rawString()!)")
        

        self.view.isUserInteractionEnabled = false
        self.act_indicator.startAnimating()
        
           
        let para = ["form_id" : self.form_id, "data" : json.rawString()!] as [String : Any]
        
        NetworkUtilities.shared.makePOSTRequest(with: API.baseURL + "edit-form-phase1", parameters: para) { (response) in
            
            
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
                    previewPDFVC.isAllowFollowUp = response.result["isFollowUpIncomplete"].intValue
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
    
    func setValuesAsParameters() -> [String : AnyObject]
    {
        var inc_invl_resident = 0
        var inc_invl_visitor = 0
        var inc_invl_staff = 0
        var inc_invl_other = 0
        var ArIncInvolved : [String] = []
        if(self.btnIncInvResident.isSelected){ArIncInvolved.append("Resident")
            inc_invl_resident = 1}
        if(self.btnIncInvVisitor.isSelected){ArIncInvolved.append("Visitor")
            inc_invl_visitor = 1}
        if(self.btnIncInvStaff.isSelected){ArIncInvolved.append("Staff")
            inc_invl_staff = 1}
        if(self.btnOtherIncInvolved.isSelected){ArIncInvolved.append("\(self.txt_OtherIncInvolved.text!)")
            inc_invl_other = 1}
        
        var type_of_inc_fall = 0
        var type_of_inc_resAbase = 0
        var type_of_inc_fire = 0
        var type_of_inc_treatment = 0
        var type_of_inc_security = 0
        var type_of_inc_lossOfProp = 0
        var type_of_inc_elopement = 0
        var type_of_inc_choking = 0
        var type_of_inc_death = 0
        var type_of_inc_aggresiveBeh = 0
        var type_of_inc_other = 0
        var ArTypeOfInc : [String] = []
        if(self.btnTypeOfIncFall.isSelected){ArTypeOfInc.append("Fall")
            type_of_inc_fall = 1}
        if(self.btnTypeOfIncResidentAbase.isSelected){ArTypeOfInc.append("Resident Abase")
            type_of_inc_resAbase = 1}
        if(self.btnTypeOfIncFire.isSelected){ArTypeOfInc.append("Fire")
            type_of_inc_fire = 1}
        if(self.btnTypeOfIncTreatment.isSelected){ArTypeOfInc.append("Treatment")
            type_of_inc_treatment = 1}
        if(self.btnTypeOfIncSecurity.isSelected){ArTypeOfInc.append("Security")
            type_of_inc_security = 1}
        if(self.btnTypeOfIncLossOfProperty.isSelected){ArTypeOfInc.append("Loss Of Property")
            type_of_inc_lossOfProp = 1}
        if(self.btnTypeOfIncElopement.isSelected){ArTypeOfInc.append("Elopement")
            type_of_inc_elopement = 1}
        if(self.btnTypeOfIncChoking.isSelected){ArTypeOfInc.append("Choking")
            type_of_inc_choking = 1}
        if(self.btnTypeOfIncDeath.isSelected){ArTypeOfInc.append("Death")
            type_of_inc_death = 1}
        if(self.btnTypeOfIncAggressiveBehavior.isSelected){ArTypeOfInc.append("Aggressive Behavior")
            type_of_inc_aggresiveBeh = 1}
        if(self.btnOtherTypeOfInc.isSelected){ArTypeOfInc.append("\(self.txtOtherTypeOfInc.text!)")
            type_of_inc_other = 1}
        
        var fall_assess_mediChange = 0
        var fall_assess_cardMedi = 0
        var fall_assess_visDef = 0
        var fall_assess_moodAltMedi = 0
        var fall_assess_relocation = 0
        var fall_assess_tempIllness = 0
        var ArFallAssessment : [String] = []
        if(self.btnFallAsMediChange.isSelected){ArFallAssessment.append("Medication Change")
            fall_assess_mediChange = 1}
        if(self.btnFallAsCardMedi.isSelected){ArFallAssessment.append("Cardiac Medications")
            fall_assess_cardMedi = 1}
        if(self.btnFallAsVisualDef.isSelected){ArFallAssessment.append("Visual Deficit")
            fall_assess_visDef = 1}
        if(self.btnFallAsMoodAltMed.isSelected){ArFallAssessment.append("Mood Altering Medication")
            fall_assess_moodAltMedi = 1}
        if(self.btnFallAsReloc.isSelected){ArFallAssessment.append("Relocation")
            fall_assess_relocation = 1}
        if(self.btnFallAsTempIllness.isSelected){ArFallAssessment.append("Temporary Illness")
            fall_assess_tempIllness = 1}
        
        var condition_at_inc_oriented = 0
        var condition_at_inc_disOriented = 0
        var condition_at_inc_sedated = 0
        var condition_at_inc_other = 0
        var ArConditionIncident : [String] = []
        if(self.btnCondOriented.isSelected){ArConditionIncident.append("Oriented")
            condition_at_inc_oriented = 1}
        if(self.btnCondDisoriented.isSelected){ArConditionIncident.append("Disoriented")
            condition_at_inc_disOriented = 1}
        if(self.btnCondSedated.isSelected){ArConditionIncident.append("Sedated")
            condition_at_inc_sedated = 1}
        if(self.btnOtherCondAtInc.isSelected){ArConditionIncident.append("\(self.txt_OtherCondAtInc.text!)")
            condition_at_inc_other = 1}
        
        var ambulation_unlimited = 0
        var ambulation_limited = 0
        var ambulation_reqAssist = 0
        var ambulation_wheelChair = 0
        var ambulation_walker = 0
        var ambulation_other = 0
        var ArAmbulation : [String] = []
        if(self.btnAmbuUnlimited.isSelected){ArAmbulation.append("Unlimited")
            ambulation_unlimited = 1}
        if(self.btnAmbuLimited.isSelected){ArAmbulation.append("Limited")
            ambulation_limited = 1}
        if(self.btnAmbuReqAssistance.isSelected){ArAmbulation.append("Required assistance")
            ambulation_reqAssist = 1}
        if(self.btnAmbuWheelchair.isSelected){ArAmbulation.append("Wheelchair")
            ambulation_wheelChair = 1}
        if(self.btnAmbuWalker.isSelected){ArAmbulation.append("Walker")
            ambulation_walker = 1}
        if(self.btnOtherAmbulation.isSelected){ArAmbulation.append("\(self.txt_OtherAmbulation.text!)")
            ambulation_other = 1}
        
        var informed_of_inc_AGM = 0
        var informed_of_inc_GM = 0
        var informed_of_inc_RMC = 0
        var informed_of_inc_other = 0
        var ArInfOfIncident : [String] = []
        if(self.btnINIAssistantGM.isSelected){ArInfOfIncident.append("Assistant General Manager")
            informed_of_inc_AGM = 1}
        if(self.btnINIGM.isSelected){ArInfOfIncident.append("General Manager")
            informed_of_inc_GM = 1}
        if(self.btnINIRiskMangCm.isSelected){ArInfOfIncident.append("Risk Management Committee")
            informed_of_inc_RMC = 1}
        if(self.btnOtherInformOfInc.isSelected){ArInfOfIncident.append("\(self.txtOtherInformOfInc.text!)")
            informed_of_inc_other = 1}
        
        let incident_dt = self.btnDateOfInc.title(for: .normal)!.prefix(11)
        let incident_tm = self.btnDateOfInc.title(for: .normal)!.suffix(8)
        let discovery_dt = self.btnDateOfDisc.title(for: .normal)!.prefix(11)
        let discovery_tm = self.btnDateOfDisc.title(for: .normal)!.suffix(8)
        let completed_dt = self.btnNotiDateTime.title(for: .normal)!.prefix(11)
        let completed_tm = self.btnNotiDateTime.title(for: .normal)!.suffix(8)
                               
        var dictItem = [
            "incident_involved" : ArIncInvolved.joined(separator: ","),
            "inc_invl_resident" : inc_invl_resident,
            "inc_invl_visitor" : inc_invl_visitor,
            "inc_invl_staff" : inc_invl_staff,
            "inc_invl_other" : inc_invl_other,
            "incident_date" : self.btnDateOfInc.title(for: .normal)!,
            "incident_dt" : incident_dt,
            "incident_tm" : incident_tm,
            "incident_location" : self.txtLocOfInc.text!,
            "witnessed_by" : self.txtWitnessedBy.text!,
            "discovery_date" : self.btnDateOfDisc.title(for: .normal)!,
            "discovery_dt" : discovery_dt,
            "discovery_tm" : discovery_tm,
            "discovery_location" : self.txtLocOfDisc.text!,
            "discovered_by" : self.txtDiscoveredBy.text!,
            "type_of_incident" : ArTypeOfInc.joined(separator: ","),
            "type_of_inc_fall" : type_of_inc_fall,
            "type_of_inc_resAbase" : type_of_inc_resAbase,
            "type_of_inc_fire" : type_of_inc_fire,
            "type_of_inc_treatment" : type_of_inc_treatment,
            "type_of_inc_security" : type_of_inc_security,
            "type_of_inc_lossOfProp" : type_of_inc_lossOfProp,
            "type_of_inc_elopement" : type_of_inc_elopement,
            "type_of_inc_choking" : type_of_inc_choking,
            "type_of_inc_death" : type_of_inc_death,
            "type_of_inc_aggresiveBeh" : type_of_inc_aggresiveBeh,
            "type_of_inc_other" : type_of_inc_other,
            "safety_fob" : self.safetyFobVal,
            "safety_callbell" : self.safetyCallBellVal,
            "safety_caution" : self.safetyCautionVal,
            "safety_other" : self.txtOtherSafetyDevices.text!,
            "other_witnesses" : (self.btnWitnessYes.isSelected == true) ? "Yes" : "No",
            "condition_at_incident" : ArConditionIncident.joined(separator: ","),
            "condition_at_inc_oriented" : condition_at_inc_oriented,
            "condition_at_inc_disOriented" : condition_at_inc_disOriented,
            "condition_at_inc_sedated" : condition_at_inc_sedated,
            "condition_at_inc_other" : condition_at_inc_other,
            "fall_assessment" : ArFallAssessment.joined(separator: ","),
            "fall_assess_mediChange" : fall_assess_mediChange,
            "fall_assess_cardMedi" : fall_assess_cardMedi,
            "fall_assess_visDef" : fall_assess_visDef,
            "fall_assess_moodAltMedi" : fall_assess_moodAltMedi,
            "fall_assess_relocation" : fall_assess_relocation,
            "fall_assess_tempIllness" : fall_assess_tempIllness,
            "ambulation" : ArAmbulation.joined(separator: ","),
            "ambulation_unlimited" : ambulation_unlimited,
            "ambulation_limited" : ambulation_limited,
            "ambulation_reqAssist" : ambulation_reqAssist,
            "ambulation_wheelChair" : ambulation_wheelChair,
            "ambulation_walker" : ambulation_walker,
            "ambulation_other" : ambulation_other,
            "fire_alarm_pulled" : self.FireAlarmPulledVal,
            "fire_false_alarm" : self.FireFalseAlarmVal,
            "fire_extinguisher_used" : self.FireExtiVal,
            "fire_personal_injury" : self.FirePerInjuryVal,
            "fire_property_damage" : self.FirePropDamageVal,
            "factual_description" : self.txtFactual.text!,
            "informed_of_incident" : ArInfOfIncident.joined(separator: ","),
            "informed_of_inc_AGM" : informed_of_inc_AGM,
            "informed_of_inc_GM" : informed_of_inc_GM,
            "informed_of_inc_RMC" : informed_of_inc_RMC,
            "informed_of_inc_other" : informed_of_inc_other,
            "notified_family_doctor" : self.txtNotiFamDoc.text!,
            "notified_other" : self.txtNotiOther.text!,
            "notified_resident_responsible_party" : (self.btnNotiResidentYes.isSelected == true) ? "Yes" : "No",
            "completed_by" : self.txtNotiCompletedBy.text!,
            "completed_position" : self.txtNotiPosition.text!,
            "completed_date" : self.btnNotiDateTime.title(for: .normal)!,
            "completed_dt" : completed_dt,
            "completed_tm" : completed_tm,
            "followUp_issue" : self.txtIssue.text!,
            "followUp_findings" : self.txtFindings.text!,
            "followUp_possible_solutions" : self.txtSolutions.text!,
            "followUp_action_plan" : self.txtActionPlan.text!,
            "followUp_examine_result" : self.txtFollowUp.text!
        ] as [String : AnyObject]
        
        if(self.btnOtherIncInvolved.isSelected == true)
        {
            dictItem["inc_invl_other_text"] = self.txt_OtherIncInvolved.text! as AnyObject
        }
        
        if(self.btnOtherTypeOfInc.isSelected == true)
        {
            dictItem["type_of_inc_other_text"] = self.txtOtherTypeOfInc.text! as AnyObject
        }
        
        if(self.btnOtherCondAtInc.isSelected == true)
        {
            dictItem["condition_at_inc_other_text"] = self.txt_OtherCondAtInc.text! as AnyObject
        }
        
        if(self.btnOtherAmbulation.isSelected == true)
        {
            dictItem["ambulation_other_text"] = self.txt_OtherAmbulation.text! as AnyObject
        }
        
        if(self.btnOtherInformOfInc.isSelected == true)
        {
            dictItem["informed_of_inc_other_text"] = self.txtOtherInformOfInc.text! as AnyObject
        }
        
        if(self.btnWitnessYes.isSelected == true)
        {
            dictItem["witness_name1"] = self.txt_Witness_Name1.text! as AnyObject
            dictItem["witness_position1"] = self.txt_Witness_Position1.text! as AnyObject
            dictItem["witness_name2"] = self.txt_Witness_Name2.text! as AnyObject
            dictItem["witness_position2"] = self.txt_Witness_Position2.text! as AnyObject
        }
        
        if(self.btnNotiResidentYes.isSelected == true)
        {
            dictItem["notified_resident_name"] = self.txtNotiResName.text! as AnyObject
            dictItem["notified_resident_date"] = self.btnDateOfNotiRes.title(for: .normal)! as AnyObject
            dictItem["notified_resident_dt"] = self.btnDateOfNotiRes.title(for: .normal)!.prefix(11) as AnyObject
            dictItem["notified_resident_tm"] = self.btnDateOfNotiRes.title(for: .normal)!.suffix(8) as AnyObject
        }
        
        if(self.btnDateOfNotiFamDoc.title(for: .normal) != "Select Date/Time")
        {
            dictItem["notified_family_doctor_date"] = self.btnDateOfNotiFamDoc.title(for: .normal)! as AnyObject
            dictItem["notified_family_doctor_dt"] = self.btnDateOfNotiFamDoc.title(for: .normal)!.prefix(11) as AnyObject
            dictItem["notified_family_doctor_tm"] = self.btnDateOfNotiFamDoc.title(for: .normal)!.suffix(8) as AnyObject
        }
        
        if(self.btnDateOfNotiOther.title(for: .normal) != "Select Date/Time")
        {
            dictItem["notified_other_date"] = self.btnDateOfNotiOther.title(for: .normal)! as AnyObject
            dictItem["notified_other_dt"] = self.btnDateOfNotiOther.title(for: .normal)!.prefix(11) as AnyObject
            dictItem["notified_other_tm"] = self.btnDateOfNotiOther.title(for: .normal)!.suffix(8) as AnyObject
        }
        
        if(self.btnINIAssistantGM.isSelected == true)
        {
            dictItem["initial_assistant_gm"] = self.txtINIAssistantGM.text! as AnyObject
        }
        
        if(self.btnINIGM.isSelected == true)
        {
            dictItem["initial_gm"] = self.txtINIGM.text! as AnyObject
        }
        
        if(self.btnINIRiskMangCm.isSelected == true)
        {
            dictItem["initial_risk_mng_committee"] = self.txtINIRiskMangCm.text! as AnyObject
        }
        
        if(self.btnOtherInformOfInc.isSelected == true)
        {
            dictItem["initial_other"] = self.txtINIOther.text! as AnyObject
        }
        
        return dictItem
    }
    
    func callSubmitFormService()
    {
        
        let dictItem = self.setValuesAsParameters()
  
        let json: JSON = JSON(dictItem)
        print("string converted object is \(json.rawString()!)")
        

        self.view.isUserInteractionEnabled = false
        self.act_indicator.startAnimating()
        
           
        let para : [String : Any] = ["form_type" : "1", "data" : json.rawString()!] as [String : Any]
        
        var imgParams : [String : Any] = [:]
        var videoParams : [String : Any] = [:]
        let documentParams : [String : Any] = [:]
        var videoThumbParams : [String : Any] = [:]

        for kIndx in 0..<self.CapturedImages.count
        {
            if(kIndx == 0)
            {
               imgParams["Img_\(UUID().uuidString)HHSR$Image.jpg"] = self.CapturedImages[kIndx]
            }
            else
            {
               imgParams["Img_\(UUID().uuidString)HHSR$Image\(kIndx).jpg"] = self.CapturedImages[kIndx]
            }
        }
        for kIndx in 0..<self.SelectedImages.count
        {
            imgParams["Img_\(UUID().uuidString)HHSR$\(self.SelectedImageNames[kIndx])"] = self.SelectedImages[kIndx]
        }
        
        for kIndx in 0..<self.CapturedVideos.count
        {
            if(kIndx == 0)
            {
                videoParams["Vid_\(UUID().uuidString)HHSR$Video.mov"] = self.CapturedVideos[kIndx]
                videoThumbParams["VidThumb_\(UUID().uuidString)HHSR$Image.jpg"] = self.CapturedVidThumbs[kIndx].jpegData(compressionQuality:1)
            }
            else
            {
                videoParams["Vid_\(UUID().uuidString)HHSR$Video\(kIndx).mov"] = self.CapturedVideos[kIndx]
                videoThumbParams["VidThumb_\(UUID().uuidString)HHSR$Image\(kIndx).jpg"] = self.CapturedVidThumbs[kIndx].jpegData(compressionQuality:1)
            }
        }
        for kIndx in 0..<self.SelectedVideos.count
        {
            videoParams["Vid_\(UUID().uuidString)HHSR$\(self.SelectedVideoNames[kIndx])"] = self.SelectedVideos[kIndx]
            videoThumbParams["VidThumb_\(UUID().uuidString)HHSR$VideoThumbImage\(kIndx).jpg"] = self.SelectedVidThumbs[kIndx].jpegData(compressionQuality:1)
        }
        
        
        //API.general_form_submit_api
        //NetworkUtilities.shared.makePOSTRequest(with: API.baseURL + "demo-form-submit", parameters: para) { (response) in
        NetworkUtilities.shared.makePOSTwithMultipartFormDataRequest(with: API.baseURL + "general-form-submit-phase1", fromWhere: "", parameters: para, imageParameters: imgParams, VideoParameters : videoParams, DocumentParameters: documentParams, thumbImageParameters: videoThumbParams, ImgData: nil, VideoData: nil) { (response) in
            
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
                    let idx = AppDelegate.sharedDelegate().arFormList.firstIndex(where: { $0.FormId == 1 })
                    previewPDFVC.isAllowPrint = AppDelegate.sharedDelegate().arFormList[idx!].IsPrintAllowed
                    previewPDFVC.isAllowMail = AppDelegate.sharedDelegate().arFormList[idx!].IsMailAllowed
                    previewPDFVC.isAllowFollowUp = response.result["isFollowUpIncomplete"].intValue
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
    
    func callAddAttachmentService()
    {
              
        self.view.isUserInteractionEnabled = false
        self.act_indicator.startAnimating()
                   
        let para : [String : Any] = ["form_id" : "\(self.form_id)"] as [String : Any]
        
        var imgParams : [String : Any] = [:]
        var videoParams : [String : Any] = [:]
        let documentParams : [String : Any] = [:]
        var videoThumbParams : [String : Any] = [:]

        if(self.CapturedImage != nil)
        {
           imgParams["Img_\(UUID().uuidString)HHSR$Image.jpg"] = self.CapturedImage
            self.CapturedImage = nil
        }
     
        for kIndx in 0..<self.SelectedImages.count
        {
            imgParams["Img_\(UUID().uuidString)HHSR$\(self.SelectedImageNames[kIndx])"] = self.SelectedImages[kIndx]
        }
        self.SelectedImages.removeAll()
        self.SelectedImageNames.removeAll()
        
        if(self.CapturedVideo != nil)
        {
           videoParams["Vid_\(UUID().uuidString)HHSR$Video.mov"] = self.CapturedVideo
           videoThumbParams["VidThumb_\(UUID().uuidString)HHSR$Image.jpg"] = self.CapturedVidThumb!.jpegData(compressionQuality:1)
           self.CapturedVideo = nil
           self.CapturedVidThumb = nil
        }

        for kIndx in 0..<self.SelectedVideos.count
        {
            videoParams["Vid_\(UUID().uuidString)HHSR$\(self.SelectedVideoNames[kIndx])"] = self.SelectedVideos[kIndx]
            videoThumbParams["VidThumb_\(UUID().uuidString)HHSR$VideoThumbImage\(kIndx).jpg"] = self.SelectedVidThumbs[kIndx].jpegData(compressionQuality:1)
        }
        self.SelectedVideos.removeAll()
        self.SelectedVideoNames.removeAll()
        self.SelectedVidThumbs.removeAll()
        
        NetworkUtilities.shared.makePOSTwithMultipartFormDataRequest(with: API.baseURL + "add-form-attachment-phase1", fromWhere: "", parameters: para, imageParameters: imgParams, VideoParameters : videoParams, DocumentParameters: documentParams, thumbImageParameters: videoThumbParams, ImgData: nil, VideoData: nil) { (response) in
            
            print("api is \(API.baseURL + "add-form-attachment") para are \(para)")
            
            if(response.error == nil)
            {
                self.view.isUserInteractionEnabled = true
                self.act_indicator.stopAnimating()
                if(response.result[MainResponseCodeConstant.keyResponseCode].intValue == MainResponseCodeConstant.keyResponseCodeOne)
                {
                    print(response.result)
                    
                    self.arEditAttachments =
                    (response.result["attachments"].arrayValue.compactMap(clsAttachment.init))
                    
                    self.TotalAddedSize = self.arEditAttachments.map({ Double($0.MediaSize) * 0.001 }).reduce(0, +)
                    
                    self.lblAttachmentCount.setTitleColor(UIColor.ColorCodes.themeBlkColor, for: .normal)
                    self.cns_tblAttachmentHeight.constant = 100
                    if(self.arEditAttachments.count == 1)
                    {
                        self.lblAttachmentCount.setTitle("1 Attachment", for: .normal)
                    }
                    else
                    {
                        self.lblAttachmentCount.setTitle("\(self.arEditAttachments.count) Attachments", for: .normal)
                    }
                    
                    self.tblAttachmentList.reloadData()
                    self.showMessageAlert(message:"Attachment(s) Uploaded Successfully.")
                    
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationNamesConstant.keyAttachmentUpdated), object: nil, userInfo: [PushNotificationKeysConstant.keyFormId:  self.form_id, PushNotificationKeysConstant.keyFormPDFURL : response.result["new_form_link"].stringValue])
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
    
    @IBAction func btnOtherWitness_Clicked(_ sender: Any)
    {
        let btn = sender as! UIButton
        if(btn.tag == 0)
        {
            self.btnWitnessYes.isSelected = true
            self.btnWitnessNo.isSelected = false
            self.vw_Name1.isHidden = false
            self.vw_Name2.isHidden = false
            self.vw_Position1.isHidden = false
            self.vw_Position2.isHidden = false
        }
        else
        {
            self.btnWitnessYes.isSelected = false
            self.btnWitnessNo.isSelected = true
            self.vw_Name1.isHidden = true
            self.vw_Name2.isHidden = true
            self.vw_Position1.isHidden = true
            self.vw_Position2.isHidden = true
        }
    }
    
    @IBAction func btnNotiResident_Clicked(_ sender: Any)
    {
        let btn = sender as! UIButton
        if(btn.tag == 0)
        {
            self.btnNotiResidentYes.isSelected = true
            self.btnNotiResidentNo.isSelected = false
            self.vw_NotiResident_Name.isHidden = false
            self.vw_NotiResident_Date.isHidden = false
        }
        else
        {
            self.btnNotiResidentYes.isSelected = false
            self.btnNotiResidentNo.isSelected = true
            self.vw_NotiResident_Name.isHidden = true
            self.vw_NotiResident_Date.isHidden = true
        }
    }
    
    @IBAction func btnSafetyFob_Clicked(_ sender: Any)
    {
        let btn = sender as! UIButton
        if(btn.isSelected == true)
        {
        }
        else
        {
            self.stk_Fob.subviews.forEach({
                let btn_all = $0.subviews[0] as! UIButton
                btn_all.isSelected = false
            })
            btn.isSelected = true
            if(btn.tag == 0)
            {
                self.safetyFobVal = "Yes"
            }
            else if(btn.tag == 1)
            {
                self.safetyFobVal = "No"
            }
            else
            {
                self.safetyFobVal = "N/A"
            }
        }
    }
    
    @IBAction func btnSafetyCallbell_Clicked(_ sender: Any)
    {
        let btn = sender as! UIButton
        if(btn.isSelected == true)
        {
        }
        else
        {
            self.stk_CallBell.subviews.forEach({
                let btn_all = $0.subviews[0] as! UIButton
                btn_all.isSelected = false
            })
            btn.isSelected = true
            if(btn.tag == 0)
            {
                self.safetyCallBellVal = "Yes"
            }
            else if(btn.tag == 1)
            {
                self.safetyCallBellVal = "No"
            }
            else
            {
                self.safetyCallBellVal = "N/A"
            }
        }
    }
    
    @IBAction func btnSafetyCaution_Clicked(_ sender: Any)
    {
        let btn = sender as! UIButton
        if(btn.isSelected == true)
        {
        }
        else
        {
            self.stk_Caution.subviews.forEach({
                let btn_all = $0.subviews[0] as! UIButton
                btn_all.isSelected = false
            })
            btn.isSelected = true
            if(btn.tag == 0)
            {
                self.safetyCautionVal = "Yes"
            }
            else if(btn.tag == 1)
            {
                self.safetyCautionVal = "No"
            }
            else
            {
                self.safetyCautionVal = "N/A"
            }
        }
    }
    
    @IBAction func btnFireAlarmPulled_Clicked(_ sender: Any)
    {
        let btn = sender as! UIButton
        if(btn.isSelected == true){}
        else
        {
            self.stk_FireAlarmPulled.subviews.forEach({
                let btn_all = $0.subviews[0] as! UIButton
                btn_all.isSelected = false
            })
            btn.isSelected = true
            self.FireAlarmPulledVal = (btn.tag == 0) ? "Yes" : "No"
        }
    }
    
    @IBAction func btnFireFalseAlarm_Clicked(_ sender: Any)
    {
        let btn = sender as! UIButton
        if(btn.isSelected == true){}
        else
        {
            self.stk_FireFalseAlarm.subviews.forEach({
                let btn_all = $0.subviews[0] as! UIButton
                btn_all.isSelected = false
            })
            btn.isSelected = true
            self.FireFalseAlarmVal = (btn.tag == 0) ? "Yes" : "No"
        }
    }
    
    @IBAction func btnFireExti_Clicked(_ sender: Any)
    {
        let btn = sender as! UIButton
        if(btn.isSelected == true){}
        else
        {
            self.stk_FireExti.subviews.forEach({
                let btn_all = $0.subviews[0] as! UIButton
                btn_all.isSelected = false
            })
            btn.isSelected = true
            self.FireExtiVal = (btn.tag == 0) ? "Yes" : "No"
        }
    }
    
    @IBAction func btnFirePerInjury_Clicked(_ sender: Any)
    {
        let btn = sender as! UIButton
        if(btn.isSelected == true){}
        else
        {
            self.stk_FirePerInjury.subviews.forEach({
                let btn_all = $0.subviews[0] as! UIButton
                btn_all.isSelected = false
            })
            btn.isSelected = true
            self.FirePerInjuryVal = (btn.tag == 0) ? "Yes" : "No"
        }
    }
    
    @IBAction func btnFirePropDamage_Clicked(_ sender: Any)
    {
        let btn = sender as! UIButton
        if(btn.isSelected == true){}
        else
        {
            self.stk_FirePropDamage.subviews.forEach({
                let btn_all = $0.subviews[0] as! UIButton
                btn_all.isSelected = false
            })
            btn.isSelected = true
            self.FirePropDamageVal = (btn.tag == 0) ? "Yes" : "No"
        }
    }
    
    @IBAction func btnChkMark_FollowUp_Clicked(_ sender: Any)
    {
        let btn = sender as! UIButton
        btn.isSelected = !btn.isSelected

        self.vw_FollowUp.isHidden = !(btn.isSelected == true)
    }
    
    @IBAction func btnChkMark_Clicked(_ sender: Any)
    {
        let btn = sender as! UIButton
        btn.isSelected = !btn.isSelected
        
        let val = (btn.isSelected == true) ? false : true
        
        if(btn == self.btnOtherIncInvolved)
        {
            self.vw_OtherIncInvolved.isHidden = val
        }
        else if(btn == self.btnOtherTypeOfInc)
        {
            self.txtOtherTypeOfInc.isHidden = val
        }
//        if(btn == self.btnOtherSafetyDevices)
//        {
//            self.txtOtherSafetyDevices.isHidden = val
//        }
        else if(btn == self.btnOtherCondAtInc)
        {
            self.vw_OtherCondAtInc.isHidden = val
        }
        else if(btn == self.btnOtherAmbulation)
        {
            self.vw_OtherAmbulation.isHidden = val
        }
        else if(btn == self.btnOtherInformOfInc)
        {
            self.txtOtherInformOfInc.isHidden = val
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
                    
                    self.arEditAttachments = 
                    (response.result["attachments"].arrayValue.compactMap(clsAttachment.init))
                    
                    self.TotalAddedSize = self.arEditAttachments.map({ Double($0.MediaSize) * 0.001 }).reduce(0, +)
                    
                    if(self.arEditAttachments.count == 0)
                    {
                        self.lblAttachmentCount.setTitle("No Attachment", for: .normal)
                        self.lblAttachmentCount.setTitleColor(UIColor.ColorCodes.addPrjLightGrayColor, for: .normal)
                        self.cns_tblAttachmentHeight.constant = 0
                    }
                    else if(self.arEditAttachments.count == 1)
                    {
                        self.lblAttachmentCount.setTitle("1 Attachment", for: .normal)
                        self.cns_tblAttachmentHeight.constant = 100
                        self.lblAttachmentCount.setTitleColor(UIColor.ColorCodes.themeBlkColor, for: .normal)
                    }
                    else
                    {
                        self.lblAttachmentCount.setTitle("\(self.arEditAttachments.count) Attachments", for: .normal)
                        self.cns_tblAttachmentHeight.constant = 100
                        self.lblAttachmentCount.setTitleColor(UIColor.ColorCodes.themeBlkColor, for: .normal)
                    }
                                        
                    self.tblAttachmentList.reloadData()
                    
                    let form_detail = response.result["form_data"].dictionaryValue
                    if((form_detail["incident_date"]?.exists()) != nil)
                    {
                        self.btnDateOfInc.setTitle(form_detail["incident_date"]?.stringValue, for: .normal)
                    }
                    if((form_detail["discovery_date"]?.exists()) != nil)
                    {
                        self.btnDateOfDisc.setTitle(form_detail["discovery_date"]?.stringValue, for: .normal)
                    }
                    if((form_detail["incident_location"]?.exists()) != nil)
                    {
                        self.txtLocOfInc.text = form_detail["incident_location"]?.stringValue
                    }
                    if((form_detail["witnessed_by"]?.exists()) != nil)
                    {
                        self.txtWitnessedBy.text = form_detail["witnessed_by"]?.stringValue
                    }
                    if((form_detail["discovery_location"]?.exists()) != nil)
                    {
                        self.txtLocOfDisc.text = form_detail["discovery_location"]?.stringValue
                    }
                    if((form_detail["discovered_by"]?.exists()) != nil)
                    {
                        self.txtDiscoveredBy.text = form_detail["discovered_by"]?.stringValue
                    }
                    if((form_detail["incident_involved"]?.exists()) != nil)
                    {
                        let langs = form_detail["incident_involved"]?.stringValue.components(separatedBy: ",")
                        if(langs!.contains("Resident"))
                        {
                            self.btnIncInvResident.isSelected = true
                        }
                        if(langs!.contains("Visitor"))
                        {
                            self.btnIncInvVisitor.isSelected = true
                        }
                        if(langs!.contains("Staff"))
                        {
                            self.btnIncInvStaff.isSelected = true
                        }
                        langs?.forEach({
                            if($0 != "Resident" && $0 != "Visitor" && $0 != "Staff" && $0.count > 0)
                            {
                                self.btnOtherIncInvolved.isSelected = true
                                self.txt_OtherIncInvolved.text = $0
                                self.vw_OtherIncInvolved.isHidden = false
                            }
                        })
                    }
                    
                    if((form_detail["type_of_incident"]?.exists()) != nil)
                    {
                        let langs = form_detail["type_of_incident"]?.stringValue.components(separatedBy: ",")
                        if(langs!.contains("Fall"))
                        {
                            self.btnTypeOfIncFall.isSelected = true
                        }
                        if(langs!.contains("Resident Abase"))
                        {
                            self.btnTypeOfIncResidentAbase.isSelected = true
                        }
                        if(langs!.contains("Fire"))
                        {
                            self.btnTypeOfIncFire.isSelected = true
                        }
                        if(langs!.contains("Treatment"))
                        {
                            self.btnTypeOfIncTreatment.isSelected = true
                        }
                        if(langs!.contains("Security"))
                        {
                            self.btnTypeOfIncSecurity.isSelected = true
                        }
                        if(langs!.contains("Loss Of Property"))
                        {
                            self.btnTypeOfIncLossOfProperty.isSelected = true
                        }
                        if(langs!.contains("Elopement"))
                        {
                            self.btnTypeOfIncElopement.isSelected = true
                        }
                        if(langs!.contains("Choking"))
                        {
                            self.btnTypeOfIncChoking.isSelected = true
                        }
                        if(langs!.contains("Death"))
                        {
                            self.btnTypeOfIncDeath.isSelected = true
                        }
                        if(langs!.contains("Aggressive Behavior"))
                        {
                            self.btnTypeOfIncAggressiveBehavior.isSelected = true
                        }
                        langs?.forEach({
                            if($0 != "Fall" && $0 != "Resident Abase" && $0 != "Fire" && $0 != "Treatment" && $0 != "Security" && $0 != "Loss Of Property" && $0 != "Elopement" && $0 != "Choking" && $0 != "Death" && $0 != "Aggressive Behavior" && $0.count > 0)
                            {
                                self.btnOtherTypeOfInc.isSelected = true
                                self.txtOtherTypeOfInc.text = $0
                                self.txtOtherTypeOfInc.isHidden = false
                            }
                        })
                    }
                    
                    
                    if((form_detail["informed_of_incident"]?.exists()) != nil)
                    {
                        let langs = form_detail["informed_of_incident"]?.stringValue.components(separatedBy: ",")
                        if(langs!.contains("Assistant General Manager"))
                        {
                            self.btnINIAssistantGM.isSelected = true
                            self.txtINIAssistantGM.text = form_detail["initial_assistant_gm"]?.stringValue
                        }
                        if(langs!.contains("General Manager"))
                        {
                            self.btnINIGM.isSelected = true
                            self.txtINIGM.text = form_detail["initial_gm"]?.stringValue
                        }
                        if(langs!.contains("Risk Management Committee"))
                        {
                            self.btnINIRiskMangCm.isSelected = true
                            self.txtINIRiskMangCm.text = form_detail["initial_risk_mng_committee"]?.stringValue
                        }
                        langs?.forEach({
                            if($0 != "Assistant General Manager" && $0 != "General Manager" && $0 != "Risk Management Committee" && $0.count > 0)
                            {
                                self.btnOtherInformOfInc.isSelected = true
                                self.txtOtherInformOfInc.text = $0
                                self.txtOtherInformOfInc.isHidden = false
                                self.txtINIOther.text = form_detail["initial_other"]?.stringValue
                            }
                        })
                    }
                    
                    if((form_detail["safety_fob"]?.exists()) != nil)
                    {
                        self.safetyFobVal = form_detail["safety_fob"]!.stringValue
                        var selectedIndex = 0
                        if(self.safetyFobVal == "No"){ selectedIndex = 1 }
                        else if(self.safetyFobVal == "N/A"){ selectedIndex = 2 }
                        var i = 0
                        self.stk_Fob.subviews.forEach({
                            let btn_all = $0.subviews[0] as! UIButton
                            if(i == selectedIndex)
                            {
                                btn_all.isSelected = true
                            }
                            else
                            {
                                btn_all.isSelected = false
                            }
                            i = i + 1
                        })
                    }
                    
                    if((form_detail["safety_callbell"]?.exists()) != nil)
                    {
                        self.safetyCallBellVal = form_detail["safety_callbell"]!.stringValue
                        var selectedIndex = 0
                        if(self.safetyCallBellVal == "No"){ selectedIndex = 1 }
                        else if(self.safetyCallBellVal == "N/A"){ selectedIndex = 2 }
                        var i = 0
                        self.stk_CallBell.subviews.forEach({
                            let btn_all = $0.subviews[0] as! UIButton
                            if(i == selectedIndex)
                            {
                                btn_all.isSelected = true
                            }
                            else
                            {
                                btn_all.isSelected = false
                            }
                            i = i + 1
                        })
                    }
                    
                    if((form_detail["safety_caution"]?.exists()) != nil)
                    {
                        self.safetyCautionVal = form_detail["safety_caution"]!.stringValue
                        var selectedIndex = 0
                        if(self.safetyCautionVal == "No"){ selectedIndex = 1 }
                        else if(self.safetyCautionVal == "N/A"){ selectedIndex = 2 }
                        var i = 0
                        self.stk_Caution.subviews.forEach({
                            let btn_all = $0.subviews[0] as! UIButton
                            if(i == selectedIndex)
                            {
                                btn_all.isSelected = true
                            }
                            else
                            {
                                btn_all.isSelected = false
                            }
                            i = i + 1
                        })
                    }
                    
                    if((form_detail["safety_other"]?.exists()) != nil)
                    {
                        self.txtOtherSafetyDevices.text = form_detail["safety_other"]?.stringValue
                    }
                    
                    if((form_detail["other_witnesses"]?.exists()) != nil)
                    {
                        if(form_detail["other_witnesses"]?.stringValue == "Yes")
                        {
                            self.btnWitnessYes.isSelected = true
                            self.btnWitnessNo.isSelected = false
                            self.txt_Witness_Name1.text = form_detail["witness_name1"]?.stringValue
                            self.txt_Witness_Position1.text = form_detail["witness_position1"]?.stringValue
                            self.txt_Witness_Name2.text = form_detail["witness_name2"]?.stringValue
                            self.txt_Witness_Position2.text = form_detail["witness_position2"]?.stringValue
                            
                            self.vw_Name1.isHidden = false
                            self.vw_Name2.isHidden = false
                            self.vw_Position1.isHidden = false
                            self.vw_Position2.isHidden = false
                        }
                        else
                        {
                            self.btnWitnessYes.isSelected = false
                            self.btnWitnessNo.isSelected = true
                        }
                    }
                    
                    if((form_detail["condition_at_incident"]?.exists()) != nil)
                    {
                        let langs = form_detail["condition_at_incident"]?.stringValue.components(separatedBy: ",")
                        
                        print("lang is \(langs) for conditions")
                        if(langs!.contains("Oriented"))
                        {
                            self.btnCondOriented.isSelected = true
                        }
                        if(langs!.contains("Disoriented"))
                        {
                            self.btnCondDisoriented.isSelected = true
                        }
                        if(langs!.contains("Sedated"))
                        {
                            self.btnCondSedated.isSelected = true
                        }
                        langs?.forEach({
                            if($0 != "Oriented" && $0 != "Disoriented" && $0 != "Sedated" && $0.count > 0)
                            {
                                print("0 option value is \($0) and count is \($0.count)")
                                self.btnOtherCondAtInc.isSelected = true
                                self.txt_OtherCondAtInc.text = $0
                                self.vw_OtherCondAtInc.isHidden = false
                            }
                        })
                    }
                    
                    if((form_detail["fall_assessment"]?.exists()) != nil)
                    {
                        let langs = form_detail["fall_assessment"]?.stringValue.components(separatedBy: ",")
                        if(langs!.contains("Medication Change"))
                        {
                            self.btnFallAsMediChange.isSelected = true
                        }
                        if(langs!.contains("Cardiac Medications"))
                        {
                            self.btnFallAsCardMedi.isSelected = true
                        }
                        if(langs!.contains("Visual Deficit"))
                        {
                            self.btnFallAsVisualDef.isSelected = true
                        }
                        if(langs!.contains("Mood Altering Medication"))
                        {
                            self.btnFallAsMoodAltMed.isSelected = true
                        }
                        if(langs!.contains("Relocation"))
                        {
                            self.btnFallAsReloc.isSelected = true
                        }
                        if(langs!.contains("Temporary Illness"))
                        {
                            self.btnFallAsTempIllness.isSelected = true
                        }
                    }
                    
                    if((form_detail["ambulation"]?.exists()) != nil)
                    {
                        let langs = form_detail["ambulation"]?.stringValue.components(separatedBy: ",")
                        if(langs!.contains("Unlimited"))
                        {
                            self.btnAmbuUnlimited.isSelected = true
                        }
                        if(langs!.contains("Limited"))
                        {
                            self.btnAmbuLimited.isSelected = true
                        }
                        if(langs!.contains("Required assistance"))
                        {
                            self.btnAmbuReqAssistance.isSelected = true
                        }
                        if(langs!.contains("Wheelchair"))
                        {
                            self.btnAmbuWheelchair.isSelected = true
                        }
                        if(langs!.contains("Walker"))
                        {
                            self.btnAmbuWalker.isSelected = true
                        }
                        langs?.forEach({
                            if($0 != "Unlimited" && $0 != "Limited" && $0 != "Required assistance" && $0 != "Wheelchair" && $0 != "Walker" && $0.count > 0)
                            {
                                self.btnOtherAmbulation.isSelected = true
                                self.txt_OtherAmbulation.text = $0
                                self.vw_OtherAmbulation.isHidden = false
                            }
                        })
                    }
                    
                    if((form_detail["fire_alarm_pulled"]?.exists()) != nil)
                    {
                        self.FireAlarmPulledVal = form_detail["fire_alarm_pulled"]!.stringValue
                        var selectedIndex = 0
                        if(self.FireAlarmPulledVal == "No"){ selectedIndex = 1 }
                        var i = 0
                        self.stk_FireAlarmPulled.subviews.forEach({
                            let btn_all = $0.subviews[0] as! UIButton
                            if(i == selectedIndex)
                            {
                                btn_all.isSelected = true
                            }
                            else
                            {
                                btn_all.isSelected = false
                            }
                            i = i + 1
                        })
                    }
                    
                    if((form_detail["fire_false_alarm"]?.exists()) != nil)
                    {
                        self.FireFalseAlarmVal = form_detail["fire_false_alarm"]!.stringValue
                        var selectedIndex = 0
                        if(self.FireFalseAlarmVal == "No"){ selectedIndex = 1 }
                        var i = 0
                        self.stk_FireFalseAlarm.subviews.forEach({
                            let btn_all = $0.subviews[0] as! UIButton
                            if(i == selectedIndex)
                            {
                                btn_all.isSelected = true
                            }
                            else
                            {
                                btn_all.isSelected = false
                            }
                            i = i + 1
                        })
                    }
                    
                    if((form_detail["fire_extinguisher_used"]?.exists()) != nil)
                    {
                        self.FireExtiVal = form_detail["fire_extinguisher_used"]!.stringValue
                        var selectedIndex = 0
                        if(self.FireExtiVal == "No"){ selectedIndex = 1 }
                        var i = 0
                        self.stk_FireExti.subviews.forEach({
                            let btn_all = $0.subviews[0] as! UIButton
                            if(i == selectedIndex)
                            {
                                btn_all.isSelected = true
                            }
                            else
                            {
                                btn_all.isSelected = false
                            }
                            i = i + 1
                        })
                    }
                    
                    if((form_detail["fire_personal_injury"]?.exists()) != nil)
                    {
                        self.FirePerInjuryVal = form_detail["fire_personal_injury"]!.stringValue
                        var selectedIndex = 0
                        if(self.FirePerInjuryVal == "No"){ selectedIndex = 1 }
                        var i = 0
                        self.stk_FirePerInjury.subviews.forEach({
                            let btn_all = $0.subviews[0] as! UIButton
                            if(i == selectedIndex)
                            {
                                btn_all.isSelected = true
                            }
                            else
                            {
                                btn_all.isSelected = false
                            }
                            i = i + 1
                        })
                    }
                    
                    if((form_detail["fire_property_damage"]?.exists()) != nil)
                    {
                        self.FirePropDamageVal = form_detail["fire_property_damage"]!.stringValue
                        var selectedIndex = 0
                        if(self.FirePropDamageVal == "No"){ selectedIndex = 1 }
                        var i = 0
                        self.stk_FirePropDamage.subviews.forEach({
                            let btn_all = $0.subviews[0] as! UIButton
                            if(i == selectedIndex)
                            {
                                btn_all.isSelected = true
                            }
                            else
                            {
                                btn_all.isSelected = false
                            }
                            i = i + 1
                        })
                    }
                    
                    if((form_detail["factual_description"]?.exists()) != nil)
                    {
                        self.txtFactual.text = form_detail["factual_description"]?.stringValue
                    }
                    
                    if((form_detail["notified_family_doctor"]?.exists()) != nil)
                    {
                        self.txtNotiFamDoc.text = form_detail["notified_family_doctor"]?.stringValue
                    }
                    
                    if((form_detail["notified_family_doctor_date"]?.exists()) != nil)
                    {
                        self.btnDateOfNotiFamDoc.setTitle(form_detail["notified_family_doctor_date"]?.stringValue, for: .normal)
                    }
                    
                    if((form_detail["notified_other"]?.exists()) != nil)
                    {
                        self.txtNotiOther.text = form_detail["notified_other"]?.stringValue
                    }
                    
                    if((form_detail["notified_other_date"]?.exists()) != nil)
                    {
                        self.btnDateOfNotiOther.setTitle(form_detail["notified_other_date"]?.stringValue, for: .normal)
                    }
                    
                    if((form_detail["notified_resident_responsible_party"]?.exists()) != nil)
                    {
                        if(form_detail["notified_resident_responsible_party"]?.stringValue == "Yes")
                        {
                            self.btnNotiResidentYes.isSelected = true
                            self.btnNotiResidentNo.isSelected = false
                            self.txtNotiResName.text = form_detail["notified_resident_name"]?.stringValue
                            self.btnDateOfNotiRes.setTitle(form_detail["notified_resident_date"]?.stringValue, for: .normal)
                            
                            self.vw_NotiResident_Date.isHidden = false
                            self.vw_NotiResident_Name.isHidden = false
                        }
                        else
                        {
                            self.btnNotiResidentYes.isSelected = false
                            self.btnNotiResidentNo.isSelected = true
                        }
                    }
                
                    if((form_detail["completed_by"]?.exists()) != nil)
                    {
                        self.txtNotiCompletedBy.text = form_detail["completed_by"]?.stringValue
                    }
                    if((form_detail["completed_position"]?.exists()) != nil)
                    {
                        self.txtNotiPosition.text = form_detail["completed_position"]?.stringValue
                    }
                    if((form_detail["completed_date"]?.exists()) != nil)
                    {
                        self.btnNotiDateTime.setTitle(form_detail["completed_date"]?.stringValue, for: .normal)
                    }
                    if((form_detail["followUp_issue"]?.exists()) != nil)
                    {
                        self.txtIssue.text = form_detail["followUp_issue"]?.stringValue
                    }
                    if((form_detail["followUp_findings"]?.exists()) != nil)
                    {
                        self.txtFindings.text = form_detail["followUp_findings"]?.stringValue
                    }
                    if((form_detail["followUp_possible_solutions"]?.exists()) != nil)
                    {
                        self.txtSolutions.text = form_detail["followUp_possible_solutions"]?.stringValue
                    }
                    if((form_detail["followUp_action_plan"]?.exists()) != nil)
                    {
                        self.txtActionPlan.text = form_detail["followUp_action_plan"]?.stringValue
                    }
                    if((form_detail["followUp_examine_result"]?.exists()) != nil)
                    {
                        self.txtFollowUp.text = form_detail["followUp_examine_result"]?.stringValue
                    }
                    
                    if(AppDelegate.sharedDelegate().UserRole == "concierge" || AppDelegate.sharedDelegate().UserRole == "nurse")
                    {}
                    else if(self.isFollowUpIncomplete)
                    {
                        DispatchQueue.main.asyncAfter(deadline: .now() +  0.1) {
                            //self.scl_view.setContentOffset(CGPoint(x: 0, y: 800), animated: true)
                            //self.scl_view.scrollToView(view: self.stk_followUp, animated: true)
                            let childStartPoint = self.stk_followUp.superview!.convert(self.stk_followUp.frame.origin, to: self.scl_view)
                            
                            self.scl_view.setContentOffset(CGPoint(x: 0, y: childStartPoint.y - 5), animated: true)
                        }
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
    
    
    @IBAction func btnAttachmentClicked(_ sender: Any)
    {
        if(self.lblAttachmentCount.title(for: .normal) == "\(self.maximumAllowedAttachments) Attachments")
        {
            self.showMessageAlert(message: self.MessageMaximumAttachments)
            return
        }
        
         let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
         
         let cmAction  = UIAlertAction(title: "Camera", style: .default , handler:{ (UIAlertAction)in
                
                if (UIImagePickerController.isSourceTypeAvailable(.camera))
                {
                    self.imagePicker.allowsEditing = false
                    self.imagePicker.sourceType = .camera
                    self.imagePicker.mediaTypes = [kUTTypeImage, kUTTypeMovie] as [String]
                    self.present(self.imagePicker, animated: true, completion: nil)
                }
         
            })
         alert.addAction(cmAction)
         
         alert.addAction(UIAlertAction(title: "Photo & Video Library", style: .default , handler:{ (UIAlertAction)in
//             self.imagePicker.allowsEditing = false
//             self.imagePicker.sourceType = .photoLibrary
//             self.imagePicker.mediaTypes = [kUTTypeImage, kUTTypeMovie] as [String]
//             self.present(self.imagePicker, animated: true, completion: nil)
            
            self.customImagePicker.selectedAssets.removeAll()
            self.customImagePicker.reloadCollectionView()
             
            if(self.calledFrom == "Edit")
            {
                self.customImagePicker.configure.maxSelectedAssets = 7 - self.arEditAttachments.count
            }
            else
            {
                if(self.lblAttachmentCount.title(for: .normal) != "No Attachment")
                {
                    let cnt  = Int(self.lblAttachmentCount.title(for: .normal)!.split(separator: " ")[0])
                    self.customImagePicker.configure.maxSelectedAssets = (self.maximumAllowedAttachments - cnt!)
                    //+ self.selectedAssets.count
                }
                else
                {
                    self.customImagePicker.configure.maxSelectedAssets = self.maximumAllowedAttachments
                }
            }
                        
               self.present(self.customImagePicker, animated: true, completion: nil)
         }))
        
         
         alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in
             print("User click Dismiss button")
         }))
         
        DispatchQueue.main.async
        {
            if ( UIDevice.current.model.range(of: "iPad") != nil)
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
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
           let mediaType = info[UIImagePickerController.InfoKey.mediaType] as AnyObject
           
           if mediaType as! String == kUTTypeImage as String
           {
               if (info[UIImagePickerController.InfoKey.originalImage] as? UIImage) != nil
               {
                    let capturedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
                   if(self.calledFrom == "Edit")
                   {
                       self.CapturedImage = (capturedImage.scaleAndRotateImages()!.jpegData(compressionQuality:
                      1)!)
                       
                       if(self.TotalAddedSize + Double((self.CapturedImage!.count/1000000)) > self.MaxTotalUploadFilesSizeInMB)
                       {
                           self.showMessageAlert(message: self.MessageMaximumFileSize)
                       }
                       else
                       {
                           self.TotalAddedSize = self.TotalAddedSize + Double((self.CapturedImage!.count/1000000))
                           self.callAddAttachmentService()
                       }
                   }
                   else
                   {
                       self.arAttachmentMappingContainer.insert(("CapturedImages","\(self.CapturedImages.count)"),at: 0)
                       self.CapturedImages.append(capturedImage.scaleAndRotateImages()!.jpegData(compressionQuality:1)!)
                       
                       self.TotalAddedSize = self.TotalAddedSize + Double((self.CapturedImages.last!.count/1000000))
                       print("image selected 1")
                   
                       if(self.lblAttachmentCount.title(for: .normal) != "No Attachment")
                       {
                             let atCount = Int(self.lblAttachmentCount.title(for: .normal)?.split(separator: " ")[0] ?? "0")
                             let newCount = atCount! + 1
                             self.lblAttachmentCount.setTitle("\(newCount) Attachments", for: .normal)
                             self.lblAttachmentCount.setTitleColor(UIColor.ColorCodes.themeBlkColor, for: .normal)
                       }
                       else
                       {
                              self.lblAttachmentCount.setTitle("1 Attachment", for: .normal)
                              self.lblAttachmentCount.setTitleColor(UIColor.ColorCodes.themeBlkColor, for: .normal)
                       }
                       self.cns_tblAttachmentHeight.constant = 100
                       self.tblAttachmentList.reloadData()
                   }
               }
           }
           else if mediaType as! String == kUTTypeMovie as String
           {
               let videoURL = info[UIImagePickerController.InfoKey.mediaURL] as? URL
               print("VIDEO URL: \(videoURL!)")
            
               let uploadURL = URL.init(fileURLWithPath: "\(NSTemporaryDirectory())\(NSUUID().uuidString).mov")
                    
                self.compressVideo(videoURL, outputURL: uploadURL, handler: {completion  in

                        if completion?.status == .completed {
                            //  selected_Video_compress_Data = Data(contentsOf: uploadURL)
                            do {
                                
                                if(self.calledFrom == "Edit")
                                {
                                    self.CapturedVideo = uploadURL

                                    let asset = AVAsset(url: videoURL!)
                                    let imageGenerator = AVAssetImageGenerator(asset: asset)
                                    imageGenerator.appliesPreferredTrackTransform = true
                                    let time = CMTimeMake(value: 0, timescale: 1)
                                    let imageRef = try imageGenerator.copyCGImage(at: time, actualTime: nil)
                                    self.CapturedVidThumb = UIImage(cgImage:imageRef).scaleAndRotateImages()!
                                    
                                    let dt = try Data(contentsOf: uploadURL)
                                    print("File size after compression: \(Double(dt.count / 1048576)) mb")

                                    DispatchQueue.main.async {
                                      
                                      if(self.TotalAddedSize + Double(dt.count/1000000) > self.MaxTotalUploadFilesSizeInMB)
                                      {
                                          self.showMessageAlert(message: self.MessageMaximumFileSize)
                                      }
                                      else
                                      {
                                          self.TotalAddedSize = self.TotalAddedSize + Double((dt.count/1000000))
                                          self.callAddAttachmentService()
                                      }
                                    }
                                }
                                else
                                {
                                    
                                    let asset = AVAsset(url: videoURL!)
                                    let imageGenerator = AVAssetImageGenerator(asset: asset)
                                    imageGenerator.appliesPreferredTrackTransform = true
                                    let time = CMTimeMake(value: 0, timescale: 1)
                                    let imageRef = try imageGenerator.copyCGImage(at: time, actualTime: nil)
                                    self.arAttachmentMappingContainer.insert(("CapturedVideos","\(self.CapturedVidThumbs.count)"),at: 0)
                                    self.CapturedVidThumbs.append(UIImage(cgImage:imageRef).scaleAndRotateImages()!)
                                    self.CapturedVideos.append(uploadURL)
                                    
                                    //self.CapturedImages.append(capturedImage.scaleAndRotateImages()!.jpegData(compressionQuality:1)!)
                                    
                                    let dt = try Data(contentsOf: uploadURL)
                                    self.TotalAddedSize = self.TotalAddedSize + Double((dt.count/1000000))
                                    print("File size after compression: \(Double(dt.count / 1048576)) mb")
                                    
                                    DispatchQueue.main.async {
                                        if(self.lblAttachmentCount.title(for: .normal) != "No Attachment")
                                        {
                                            let atCount = Int(self.lblAttachmentCount.title(for: .normal)?.split(separator: " ")[0] ?? "0")
                                            let newCount = atCount! + 1
                                            self.lblAttachmentCount.setTitle("\(newCount) Attachments", for: .normal)
                                            self.lblAttachmentCount.setTitleColor(UIColor.ColorCodes.themeBlkColor, for: .normal)
                                        }
                                        else
                                        {
                                            self.lblAttachmentCount.setTitle("1 Attachment", for: .normal)
                                            self.lblAttachmentCount.setTitleColor(UIColor.ColorCodes.themeBlkColor, for: .normal)
                                        }
                                        self.cns_tblAttachmentHeight.constant = 100
                                        self.tblAttachmentList.reloadData()
                                    }
                                }

                              }catch{

                            }

                        } else {}

                })
           }
       
       self.dismiss(animated: true, completion: nil)
   }
   
   func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
       self.dismiss(animated: true, completion: nil)
   }
    
    
    func dismissPhotoPicker(withPHAssets: [PHAsset]) {
        
        // if you want to used phasset.
         self.selectedAssets = withPHAssets
        
        let manager = PHImageManager.default()
        let options = PHImageRequestOptions()
        options.version = .original
        options.isSynchronous = true
        
        var isVideoSelected = false
        self.SelectedAssetsSize = 0.0
        
        for ast in withPHAssets
        {
            if(ast.mediaType == .image)
            {
                   manager.requestImageData(for: ast, options: options) { data, _, _, _ in
            
                       if(self.calledFrom == "Edit")
                       {
                           let fname = ast.value(forKey: "filename") as! String
                           self.SelectedImageNames.append(fname)//.deletingPathExtension
                           self.SelectedImages.append(UIImage(data: data!)!.resized(withMaxVal: 640)!.jpegData(compressionQuality:
                                              1)!)
                           self.SelectedAssetsSize = self.SelectedAssetsSize + Double((data!.count/1000000))
                       }
                       else
                       {
                           
                           self.arAttachmentMappingContainer.insert(("SelectedImages","\(self.SelectedImages.count)"),at: 0)
                           let fname = ast.value(forKey: "filename") as! String
                           self.SelectedImageNames.append(fname)
                           self.SelectedImages.append(UIImage(data: data!)!.resized(withMaxVal: 640)!.jpegData(compressionQuality: 1)!)
                           self.TotalAddedSize = self.TotalAddedSize + Double((data!.count/1000000))
                           
                           if(self.lblAttachmentCount.title(for: .normal) != "No Attachment")
                           {
                               let atCount = Int(self.lblAttachmentCount.title(for: .normal)?.split(separator: " ")[0] ?? "0")
                               let newCount = atCount! + 1
                               
                               //let newCount = self.CapturedImages.count + self.SelectedImages.count + self.selectedAssets.count + self.SelectedDocuments.count
                               self.lblAttachmentCount.setTitle("\(newCount) Attachments", for: .normal)
                               self.lblAttachmentCount.setTitleColor(UIColor.ColorCodes.themeBlkColor, for: .normal)
                           }
                           else // if(self.selectedAssets.count == 1)
                           {
                               self.lblAttachmentCount.setTitle("1 Attachment", for: .normal)
                               self.lblAttachmentCount.setTitleColor(UIColor.ColorCodes.themeBlkColor, for: .normal)
                           }
                           self.cns_tblAttachmentHeight.constant = 100
                           self.tblAttachmentList.reloadData()
                           // }
                       }
                   }
            }
            else if(ast.mediaType == .video)
            {
                isVideoSelected = true
                
                let options: PHVideoRequestOptions = PHVideoRequestOptions()
                options.version = .original
                let fname = ast.value(forKey: "filename") as! String
                
                PHImageManager.default().requestAVAsset(forVideo: ast, options: options, resultHandler: {(asset: AVAsset?, audioMix: AVAudioMix?, info: [AnyHashable : Any]?) -> Void in
                   if let urlAsset = asset as? AVURLAsset
                   {
                        let localVideoUrl: URL = urlAsset.url as URL
                       
                         self.VideoCompressionStatus.append((localVideoUrl, false))
                    
                    
                            let uploadURL = URL.init(fileURLWithPath: "\(NSTemporaryDirectory())\(NSUUID().uuidString).mov")
                    
                            self.compressVideo(localVideoUrl, outputURL: uploadURL, handler: {completion  in

                                if completion?.status == .completed {
                                    //  selected_Video_compress_Data = Data(contentsOf: uploadURL)
                                    do {
                                        
                                        if(self.calledFrom == "Edit")
                                        {
                                            let fltRes = self.VideoCompressionStatus.enumerated().filter({ $0.element.0 == localVideoUrl }).map({ $0.offset })
                                            self.VideoCompressionStatus[fltRes[0]].1 = true
                                            
                                            let asset = AVAsset(url: localVideoUrl)
                                            let imageGenerator = AVAssetImageGenerator(asset: asset)
                                            imageGenerator.appliesPreferredTrackTransform = true
                                            let time = CMTimeMake(value: 0, timescale: 1)
                                            let imageRef = try imageGenerator.copyCGImage(at: time, actualTime: nil)
                                            self.SelectedVidThumbs.append(UIImage(cgImage:imageRef))
                                                                                       
                                            self.SelectedVideos.append(uploadURL)
                                            self.SelectedVideoNames.append(fname)//.deletingPathExtension
                                        
                                            let dt = try Data(contentsOf: uploadURL)
                                            self.SelectedAssetsSize = self.SelectedAssetsSize + Double((dt.count/1000000))
                                            print("File size AFTER compression: \(Double(dt.count / 1048576)) mb")
                                        }
                                        else
                                        {
                                            
                                            let asset = AVAsset(url: localVideoUrl)
                                            let imageGenerator = AVAssetImageGenerator(asset: asset)
                                            imageGenerator.appliesPreferredTrackTransform = true
                                            let time = CMTimeMake(value: 0, timescale: 1)
                                            let imageRef = try imageGenerator.copyCGImage(at: time, actualTime: nil)
                                            self.arAttachmentMappingContainer.insert(("SelectedVideos","\(self.SelectedVidThumbs.count)"),at: 0)
                                            self.SelectedVidThumbs.append(UIImage(cgImage:imageRef))
                                            self.SelectedVideos.append(uploadURL)
                                            self.SelectedVideoNames.append(fname)
                                            self.SelectedOriginalVideos.append(localVideoUrl)
                                            
                                            let dt = try Data(contentsOf: uploadURL)
                                            self.TotalAddedSize = self.TotalAddedSize + Double((dt.count/1000000))
                                            print("File size AFTER compression: \(Double(dt.count / 1048576)) mb")
                                            
                                            DispatchQueue.main.async {
                                                if(self.lblAttachmentCount.title(for: .normal) != "No Attachment")
                                                {
                                                    let atCount = Int(self.lblAttachmentCount.title(for: .normal)?.split(separator: " ")[0] ?? "0")
                                                    //let newCount = self.CapturedImages.count + self.SelectedImages.count + self.selectedAssets.count + self.SelectedDocuments.count
                                                    let newCount = atCount! + 1
                                                    self.lblAttachmentCount.setTitle("\(newCount) Attachments", for: .normal)
                                                    self.lblAttachmentCount.setTitleColor(UIColor.ColorCodes.themeBlkColor, for: .normal)
                                                }
                                                else //if(self.selectedAssets.count == 1)
                                                {
                                                    self.lblAttachmentCount.setTitle("1 Attachment", for: .normal)
                                                    self.lblAttachmentCount.setTitleColor(UIColor.ColorCodes.themeBlkColor, for: .normal)
                                                }
                                                self.cns_tblAttachmentHeight.constant = 100
                                                self.tblAttachmentList.reloadData()
                                            }
                                        }
                                }catch{}
                            } else {}
                         })
                      // }
                    } else {}
               })
            }
        }
        
        if(self.calledFrom == "Edit")
        {
            self.view.isUserInteractionEnabled = false
            self.act_indicator.startAnimating()
        
            if(isVideoSelected)
            {
                self.CheckVideosAreCompressed()
            }
            else
            {
                  if(self.TotalAddedSize + self.SelectedAssetsSize > self.MaxTotalUploadFilesSizeInMB)
                  {
                      self.view.isUserInteractionEnabled = true
                      self.act_indicator.stopAnimating()
                      self.showMessageAlert(message: self.MessageMaximumFileSize)
                  }
                  else
                  {
                        self.TotalAddedSize = self.TotalAddedSize + self.SelectedAssetsSize
                        self.callAddAttachmentService()
                  }
            }
        }
    }
    
    @objc func CheckVideosAreCompressed()
    {
        let cnt = self.VideoCompressionStatus.filter({ $0.1 == true })
        if(cnt.count == self.VideoCompressionStatus.count && self.VideoCompressionStatus.count>0)
        {
             if(self.TotalAddedSize + self.SelectedAssetsSize > self.MaxTotalUploadFilesSizeInMB)
             {
                 self.view.isUserInteractionEnabled = true
                 self.act_indicator.stopAnimating()
                 self.showMessageAlert(message: self.MessageMaximumFileSize)
             }
             else
             {
                   self.TotalAddedSize = self.TotalAddedSize + SelectedAssetsSize
                   self.VideoCompressionStatus.removeAll()
                   self.callAddAttachmentService()
             }
        }
        else
        {
            self.perform(#selector(CheckVideosAreCompressed), with: nil, afterDelay: 1)
        }
    }


    func photoPickerDidCancel() {
        // cancel
    }

    func dismissComplete() {
        // picker dismiss completion
    }
    
    func didExceedMaximumNumberOfSelection(picker: TLPhotosPickerViewController) {
        let alert = UIAlertController(title: "Selection Limit", message: self.MessageMaximumAttachments, preferredStyle: .alert)
        //"You can select only upto 5 medias."
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        picker.present(alert, animated: true, completion: nil)
        //self.showMessageAlert("Selection Limit", message: "You can select only upto 5 medias.")
    }
    
    
    func compressVideo(_ inputURL: URL?, outputURL: URL?, handler completion: @escaping (AVAssetExportSession?) -> Void) {
         var urlAsset: AVURLAsset? = nil
         if let inputURL = inputURL {
             urlAsset = AVURLAsset(url: inputURL, options: nil)
         }
         var exportSession: AVAssetExportSession? = nil
         if let urlAsset = urlAsset {
             exportSession = AVAssetExportSession(asset: urlAsset, presetName: AVAssetExportPresetMediumQuality)
         }
         exportSession?.outputURL = outputURL
         exportSession?.outputFileType = .mov
         exportSession?.shouldOptimizeForNetworkUse = true
         exportSession?.exportAsynchronously(completionHandler: {
             print("compress compress sucessfully")
             completion(exportSession)
             print("compress sucessfully")
             if let outputURL = outputURL {
                 print("compress outputURL \(outputURL)")
             }

             if exportSession?.status == .completed {
                 print("expoet completed")
             }

         })
     }
    
}
