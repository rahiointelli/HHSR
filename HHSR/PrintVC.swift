//
//  CategorySelectionVC.swift
//  iEduGame
//
//  Created by Intelli on 2021-09-22.
//

import UIKit

class PrintVC: UIViewController, UITableViewDelegate, UITableViewDataSource, Epos2PtrReceiveDelegate{ //, Epos2PrinterSettingDelegate 
    
    var printer: Epos2Printer?
    //12
    var valuePrinterSeries: Epos2PrinterSeries =  EPOS2_TM_T88 //EPOS2_TM_T88
    var valuePrinterModel: Epos2ModelLang = EPOS2_MODEL_ANK

    @IBOutlet weak var act_indicator: UIActivityIndicatorView!
    @IBOutlet weak var lblRoomName : UILabel!
    @IBOutlet weak var tblOrderData : UITableView!
    @IBOutlet weak var cns_btnSubmitWidth: NSLayoutConstraint!
    @IBOutlet weak var tblHeader : UIView!
    @IBOutlet weak var lblTextureText : UILabel!
    @IBOutlet weak var lblTextureSpace : UILabel!
    @IBOutlet weak var stck_texture : UIStackView!
    @IBOutlet weak var tblTop: NSLayoutConstraint!
    @IBOutlet weak var btnPrint: UIButton!
    @IBOutlet weak var imgTest: UIImageView!
    @IBOutlet weak var lblDate : UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblMemberName : UILabel!
    @IBOutlet weak var lblCurrentDateTime : UILabel!
    @IBOutlet weak var vwTextureTop: UIView!
    @IBOutlet weak var vwTextureBottom: UIView!
    @IBOutlet weak var vwTitleBottom: UIView!
    @IBOutlet weak var cns_tblTop: NSLayoutConstraint!
    
    var selectedRoomName : String = ""
    var selectedRoomID : Int = 0
    var selectedDate = Date()
    var currentSelectedIndex =    0
       
    var data : [clsCombinedPrintItems] = []
    var allData : [clsCombinedPrintItems] = []
    var items : [clsPrintItems] = []
    var specialInstText = ""
    var splInstCount = 0
    var logData = UIImage()
    var scrWd = 0.0
    var printPaperWidth = 515.0 //80 * 3.779528 //320.0
    var isForGuest = 0
    var IsTrayForBrk = 0
    var IsTrayForLunch = 0
    var IsTrayForDinner = 0
    var IsEscortForBrk = 0
    var IsEscortForLunch = 0
    var IsEscortForDinner = 0
    var extraServiceCount = 0
    var extraServiceValue = ""
    var indx = 0
    var allDtCount  = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnBack.isHidden = true
        self.lblDate.text = self.selectedDate.toString(dateFormat: "MMMM d, yyyy")
        print("stack view is \(self.stck_texture)")
        self.view.backgroundColor = .white
        self.tblOrderData.backgroundColor = .white
        
       // self.printPaperWidth = UIScreen.main.bounds.size.width
        self.scrWd = UIScreen.main.bounds.size.width
        self.vwTextureTop.createDottedLine(width: 1.0, color: UIColor.black.cgColor, maxX : self.scrWd - 24)
        self.vwTextureBottom.createDottedLine(width: 1.0, color: UIColor.black.cgColor, maxX : self.scrWd - 24)
        
        let img = ((AppDelegate.sharedDelegate().LanguagePref == 0) ? UIImage(named: "btn_print") : UIImage(named: "btn_print_cn"))
        self.btnPrint.setBackgroundImage(img, for: .normal)
              
        if(UIDevice.current.userInterfaceIdiom == .pad)
        {            
            self.cns_btnSubmitWidth.constant = (UIScreen.main.bounds.size.width * 20.0) / 59.0
        }
        else
        {
            self.cns_btnSubmitWidth.constant = (UIScreen.main.bounds.size.width * 30.0) / 59.0
        }

      //  self.lblRoomName.text = "\(self.selectedRoomName)"
        
        self.tblOrderData.register(UINib(nibName: "TblPrintCell", bundle: nil), forCellReuseIdentifier: "TblPrintCell")
                       
        self.CallPrintService()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        
        print("called view appear")
//        super.viewWillAppear(animated)
//
//        if #available(iOS 13.0, *)
//        {
//            let tag = 184824
//             if let statusBar = UIApplication.shared.keyWindow?.viewWithTag(tag) {
//                statusBar.backgroundColor = UIColor.white
//             } else {
//                 let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
//                 statusBarView.tag = tag
//
//                 UIApplication.shared.keyWindow?.addSubview(statusBarView)
//                 statusBarView.backgroundColor = UIColor.white
//             }
//
//        }
//        else
//        {
//              if let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
//              {
//                   statusBar.backgroundColor = UIColor.white
//              }
//        }
   }
    
//    override func viewWillDisappear(_ animated: Bool)
//    {
//        CommonUtility.shared.setStatusBarAppearance()
//    }
    
    override func viewDidLayoutSubviews() {
        //self.tblOrderData.tableHeaderView = self.tblHeader
    }

    @IBAction func btnBack_Clicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    func resizeImage(img : UIImage) -> UIImage
    {
        let hgt = (515.0 * img.size.height)/img.size.width
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(515.0, hgt), false, 1.0)
        img.draw(in: CGRect(origin: .zero, size: CGSizeMake(515.0, hgt)))
        let newImg = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImg!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.items.count > 0) ? (self.items.count + self.splInstCount + 1 + self.extraServiceCount) : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TblPrintCell", for: indexPath) as! TblPrintCell
        cell.selectionStyle = .none
        
        cell.vwDashedLine.createDottedLine(width: 1.0, color: UIColor.black.cgColor, maxX : self.scrWd - 24)
        
//        cell.cns_catTop.constant = 7
//        cell.cns_itemBottom.constant = 7
        cell.cns_itemTop.constant = 7
        
        if((self.extraServiceCount == 1 && self.splInstCount == 1 && (indexPath.row == self.items.count + 2)) || (self.extraServiceCount == 1 && self.splInstCount == 0 && (indexPath.row == self.items.count + 1)) || (self.extraServiceCount == 0 && self.splInstCount == 1 && (indexPath.row == self.items.count + 1)) || (self.extraServiceCount == 0 && self.splInstCount == 0 && (indexPath.row == self.items.count)))
        //if((indexPath.row == self.items.count + 1) || (indexPath.row == self.items.count && self.splInstCount == 0))
        {
            cell.lblOption.text = ""
            cell.lblItem.text = "\(self.lblCurrentDateTime.text!)"
            cell.lblItem.font = UIFont(name: "Helvetica", size: (UIDevice.current.userInterfaceIdiom == .pad) ? 23 : 18)
            cell.lblItem.textAlignment = .center
            cell.vwDashedLine.isHidden = true
            cell.lblItem.numberOfLines = 1
            
//            cell.cns_catTop.constant = 2
//            cell.cns_itemBottom.constant = 3
        }
        else if(self.extraServiceCount == 1 && ((self.splInstCount == 1 && (indexPath.row == self.items.count + 1)) || (self.splInstCount == 0 && (indexPath.row == self.items.count ))))
        {
            cell.lblOption.text = ""
            cell.lblItem.text = "\(self.extraServiceValue)"
            cell.lblItem.font = UIFont(name: "Helvetica-Bold", size: (UIDevice.current.userInterfaceIdiom == .pad) ? 24 : 19)
            cell.lblItem.textAlignment = .center
            cell.vwDashedLine.isHidden = false
            cell.lblItem.numberOfLines = 1
        }
        else if(self.splInstCount == 1 && (indexPath.row == self.items.count))
        {
            cell.lblOption.text = ""
            cell.vwDashedLine.isHidden = false
            cell.lblItem.text = "* \(self.specialInstText)"
            cell.lblItem.font = UIFont(name: "Helvetica", size: (UIDevice.current.userInterfaceIdiom == .pad) ? 38 : 33)
            cell.lblItem.textAlignment = .left
            cell.lblItem.numberOfLines = 0
        }
        else
        {
            cell.lblOption.text = ""
            cell.lblItem.numberOfLines = 1
            cell.lblItem.textAlignment = .left
            cell.lblItem.font = UIFont(name: "Helvetica", size: (UIDevice.current.userInterfaceIdiom == .pad) ? 47 : 42)
            cell.lblQuantity.font = UIFont(name: "Helvetica", size: (UIDevice.current.userInterfaceIdiom == .pad) ? 47 : 42)
            cell.lblOption.font = UIFont(name: "Helvetica", size: (UIDevice.current.userInterfaceIdiom == .pad) ? 47 : 42)
            var catName = self.items[indexPath.row].CatName
            if(self.items[indexPath.row].SubCatName.count > 0)
            {
                catName = self.items[indexPath.row].SubCatName!
                //"\(catName!) - \(self.items[indexPath.row].SubCatName!)"
            }
            
            
            if(((indexPath.row + 1) < self.items.count) && (self.items[indexPath.row + 1].CatName == "* PREFERENCE"))
            {
                print("got hidden........\(catName)")
                cell.vwDashedLine.isHidden = true
            }
            else
            {
                cell.vwDashedLine.isHidden = false
            }
           
            var itemName = self.items[indexPath.row].ItemName
            if(self.items[indexPath.row].ItemOptions.count > 0)
            {
                //itemName = "\(itemName!) - \(self.items[indexPath.row].ItemOptions!)"
                cell.lblOption.text = "- \(self.items[indexPath.row].ItemOptions!)"
            }
                        
            if(catName == "* PREFERENCE")
            {
                cell.cns_lblItem_Left.constant = 60
                cell.lblItem.numberOfLines = 0
                cell.cns_itemTop.constant = -7
                itemName = "- \(itemName!)"
                print("item name for preference is \(itemName)")
            }
            //if(self.data[self.indx].isForGuest == 1)
            if(self.isForGuest == 1) //&& self.items[indexPath.row].Quantity > 1
            {
                //itemName = "\(self.items[indexPath.row].Quantity!) X \(itemName!) "
                cell.lblQuantity.text = "X \(self.items[indexPath.row].Quantity!)"
                cell.cns_lblQuantity_Left.constant = 5
            }
            else
            {
                cell.lblQuantity.text = ""
                cell.cns_lblQuantity_Left.constant = 0
            }
            
            cell.lblItem.text = itemName
        }
               
        return cell
    }
    
    @IBAction func btnPrint_Clicked(_ sender: AnyObject)
    {
        if(self.extraServiceCount == 1)
        {
            let alert = UIAlertController(title: "Service Confirmation", message: "\(self.extraServiceValue) is selected for this order. Do you want to continue printing?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Print", style: .default, handler: { (action) in
                self.callPrintFunction()
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
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
        else
        {
            self.callPrintFunction()
        }
      
    }
    
    func callPrintFunction()
    {
        print("clicked print")
        self.imgTest.isHidden = true
//        self.imgTest.layer.borderWidth = 2.0
//        self.imgTest.layer.borderColor = UIColor.green.cgColor
//        self.imgTest.contentMode = .scaleToFill
//        self.imgTest.image = self.logData
    
         showIndicator("Please wait...");
         //textWarnings.text = ""
         let queue = OperationQueue()
         queue.addOperation({ [self] in
             if !runPrinterReceiptSequence() {
                 hideIndicator();
             }
             else
             {
                 if(self.data.count != self.allDtCount)
                 {
                     
                     let alert = UIAlertController(title: "Print More", message: "Do you want to view receipt for \(self.allData[0].RoomName!)?", preferredStyle: .alert)
                     alert.addAction(UIAlertAction(title: "View", style: .default, handler: { (action) in
                         
                         self.indx = self.indx + 1
                         self.data.append(self.allData[0])//self.indx
                         self.allData.remove(at: 0)
                         DispatchQueue.main.asyncAfter(deadline: .now() +  0.1) {
                             
                             self.setUpPrintData()
                             //                    self.lblRoomName.text = "\(self.printPaperWidth)"
                             //                    self.lblMemberName.text = "\(self.logData.size.width)"
                             //                    self.lblTextureText.text = "\((self.printPaperWidth/3.779528) * 72)"
                             //                    self.tblOrderData.reloadData()
                         }
                         
                     }))
                     alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
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
         })
    }
    
    func setUpPrintData()
    {
        self.IsTrayForBrk = self.data[self.indx].IsTrayForBrk
        self.IsTrayForLunch = self.data[self.indx].IsTrayForLunch
        self.IsTrayForDinner = self.data[self.indx].IsTrayForDinner
        self.IsEscortForBrk = self.data[self.indx].IsEscortForBrk
        self.IsEscortForLunch = self.data[self.indx].IsEscortForLunch
        self.IsEscortForDinner = self.data[self.indx].IsEscortForDinner
        self.isForGuest = self.data[self.indx].isForGuest
        
        self.items =  self.data[self.indx].Items
       // self.showMessageAlert(message: "item dt is \(self.items[0]) guest is \(self.data[self.indx].isForGuest!) name is \(self.items[0].ItemName!)")
        //if(self.data[self.indx].isForGuest == 0)
        if(self.isForGuest == 0)
        {
            //self.lblRoomName.text = "\(self.selectedRoomName) \(response.result["resident_name"].stringValue)"
            self.lblRoomName.text = "\(self.data[self.indx].RoomName!) \(self.data[self.indx].ResidentName!)"
        }
        else
        {
            self.lblRoomName.text = "\(self.data[self.indx].RoomName!)"
        }
      
        self.lblCurrentDateTime.text = Date().toString(dateFormat: "MMM d, yyyy - h:mm a")
       
//                    self.arrBreakfastItems = self.arrBreakfastItems.filter({ !$0.CatName.uppercased().contains("SOUP") && !$0.CatName.uppercased().contains("DESSERT")})
//                    self.arrLunchItems = self.arrLunchItems.filter({ !$0.CatName.uppercased().contains("SOUP") && !$0.CatName.uppercased().contains("DESSERT")})
//                    self.arrDinnerItems = self.arrDinnerItems.filter({ !$0.CatName.uppercased().contains("SOUP") && !$0.CatName.uppercased().contains("DESSERT")})
        
        
        if(self.data[self.indx].SpecialInst!.count  > 0)
        {
            self.splInstCount = 1
            self.specialInstText = self.data[self.indx].SpecialInst!
        }
        else
        {
            self.splInstCount = 0
            self.specialInstText = ""
        }
        
        if(self.data[self.indx].FoodTexture!.count > 0)
        {
//                        self.lblTextureSpace.isHidden = false
//                        self.vwTextureTop.isHidden = false
//                        self.lblTextureText.isHidden = false
            self.lblTextureText.text = self.data[self.indx].FoodTexture!.uppercased()
            
            self.tblOrderData.tableHeaderView = self.tblHeader
            //self.tblTop.constant = 8
        }
        else
        {
            self.vwTitleBottom.isHidden = false
            self.cns_tblTop.constant = 10
            self.vwTitleBottom.createDottedLine(width: 1.0, color: UIColor.black.cgColor, maxX : self.scrWd - 24)
        }
        
        print("stack view is \(self.stck_texture!)")
       
        if(self.currentSelectedIndex == 0)
        {
            if(self.IsTrayForBrk == 1 || self.IsEscortForBrk == 1)
            {
                self.extraServiceCount = 1
                self.extraServiceValue = (self.IsTrayForBrk == 1) ? "Tray Service" : ""
                if(self.IsEscortForBrk == 1)
                {
                    if(self.extraServiceValue.count > 0)
                    {
                        self.extraServiceValue = self.extraServiceValue + ", Escort Service"
                    }
                    else
                    {
                        self.extraServiceValue = "Escort Service"
                    }
                }
            }
            else
            {
                self.extraServiceCount = 0
                self.extraServiceValue = ""
            }
        }
        else if(self.currentSelectedIndex == 1)
        {
            if(self.IsTrayForLunch == 1 || self.IsEscortForLunch == 1)
            {
                self.extraServiceCount = 1
                self.extraServiceValue = (self.IsTrayForLunch == 1) ? "Tray Service" : ""
                if(self.IsEscortForLunch == 1)
                {
                    if(self.extraServiceValue.count > 0)
                    {
                        self.extraServiceValue = self.extraServiceValue + ", Escort Service"
                    }
                    else
                    {
                        self.extraServiceValue = "Escort Service"
                    }
                }
            }
            else
            {
                self.extraServiceCount = 0
                self.extraServiceValue = ""
            }
        }
        else
        {
            if(self.IsTrayForDinner == 1 || self.IsEscortForDinner == 1)
            {
                self.extraServiceCount = 1
                self.extraServiceValue = (self.IsTrayForDinner == 1) ? "Tray Service" : ""
                if(self.IsEscortForDinner == 1)
                {
                    if(self.extraServiceValue.count > 0)
                    {
                        self.extraServiceValue = self.extraServiceValue + ", Escort Service"
                    }
                    else
                    {
                        self.extraServiceValue = "Escort Service"
                    }
                }
            }
            else
            {
                self.extraServiceCount = 0
                self.extraServiceValue = ""
            }
        }
        
        let indexes = self.items.enumerated().filter({ $0.element.Preferences.count > 0 }).map({ $0.offset })
        
        let arPrefValue = self.items.filter({ $0.Preferences.count > 0 }).map({ $0.Preferences.joined(separator: "\n- ") })
                            
        for i in 0..<indexes.count
        {
            let item = clsPrintItems(catName: "* PREFERENCE", itemName: arPrefValue[i])
            self.items.insert(item, at: indexes[i]+1+i)
            print("Added items")
        }
        
        self.tblOrderData.reloadData()
       
        DispatchQueue.main.asyncAfter(deadline: .now() +  0.08) {
            let hgt = UIScreen.main.bounds.size.height - self.tblOrderData.frame.origin.y - self.tblOrderData.contentSize.height
            self.logData = self.resizeImage(img: self.view.captureSS(hgtToMinus: hgt))
            self.btnBack.isHidden = false
        }
    }
    
    func CallPrintService()
    {
        self.view.isUserInteractionEnabled = false
        self.act_indicator.startAnimating()
        
        var roomNm = self.selectedRoomName
        
        if(self.selectedRoomName.contains("A"))
        {
            if let i = self.selectedRoomName.firstIndex(of: "A"){
                let index : Int = self.selectedRoomName.distance(from: self.selectedRoomName.startIndex, to: i)
                roomNm = String(self.selectedRoomName.prefix(index))
            }
        }
        else if(self.selectedRoomName.contains("B"))
        {
            if let i = self.selectedRoomName.firstIndex(of: "B"){
                let index : Int = self.selectedRoomName.distance(from: self.selectedRoomName.startIndex, to: i)
                roomNm = String(self.selectedRoomName.prefix(index))
            }
        }
        else if(self.selectedRoomName.contains("G"))
        {
            if let i = self.selectedRoomName.firstIndex(of: "G"){
                let index : Int = self.selectedRoomName.distance(from: self.selectedRoomName.startIndex, to: i)
                roomNm = String(self.selectedRoomName.prefix(index))
            }
        }
        
        var meal_type = "breakfast"
        if(self.currentSelectedIndex == 1){meal_type = "lunch"}
        else if(self.currentSelectedIndex == 2){meal_type = "dinner"}

        //"room_id" : self.selectedRoomID
        //"is_for_guest" : self.isForGuest
        NetworkUtilities.shared.makePOSTRequest(with: API.baseURL + "print-combined-order-data", parameters: ["room_name" : roomNm, "date" : self.selectedDate.toString(dateFormat: "yyyy-MM-dd"), "meal_type" : meal_type]) { (response) in

            if(response.error == nil)
            {
                if(response.result[MainResponseCodeConstant.keyResponseCode].intValue == MainResponseCodeConstant.keyResponseCodeOne)
                {
                    print(response.result)
                                        
                    self.allData = response.result["Data"].arrayValue.compactMap(clsCombinedPrintItems.init)
                    self.allDtCount = self.allData.count
                    let idx = self.allData.firstIndex(where: { $0.RoomId == self.selectedRoomID && $0.isForGuest == self.isForGuest })
                    self.data.append(self.allData[idx!])
                    self.allData.remove(at: idx!)
                    self.setUpPrintData()
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
            
            if(AppDelegate.sharedDelegate().isPrintPermissionAsked == "")
            {
                DispatchQueue.main.asyncAfter(deadline: .now() +  0.5) { [self] in
                    
                    self.view.isUserInteractionEnabled = true
                    self.act_indicator.stopAnimating()
                    
                    if !self.connectPrinter() {
                        printer!.clearCommandBuffer()
                    }
                    AppDelegate.sharedDelegate().isPrintPermissionAsked = "asked"
                    CommonUtility.shared.setPrintPermissionStatus(str: "asked")
                }
            }
            else
            {
                self.view.isUserInteractionEnabled = true
                self.act_indicator.stopAnimating()
            }
            
//            let queue = OperationQueue()
//            queue.addOperation({ [self] in
//            })
            
//            while printer != nil {
//                return false
//            }
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        initializePrinterObject()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        finalizePrinterObject()
    }
    
//    func onGetPrinterSetting(_ code: Int32, type: Int32, value: Int32) {
//        print("code is \(code)")
//        if(code == EPOS2_CODE_SUCCESS.rawValue)
//        {
//            if(type == EPOS2_PRINTER_SETTING_PAPERWIDTH.rawValue)
//            {
//                self.showMessageAlert(message: "get width value is \(value)")
//                if(value == EPOS2_PRINTER_SETTING_PAPERWIDTH_58_0.rawValue)
//                {
//                    self.printPaperWidth = 58 * 3.779528
//                }
//                else if(value == EPOS2_PRINTER_SETTING_PAPERWIDTH_60_0.rawValue)
//                {
//                    self.printPaperWidth = 60 * 3.779528
//                }
//                else if(value == EPOS2_PRINTER_SETTING_PAPERWIDTH_70_0.rawValue)
//                {
//                    self.printPaperWidth = 70 * 3.779528
//                }
//                else if(value == EPOS2_PRINTER_SETTING_PAPERWIDTH_76_0.rawValue)
//                {
//                    self.printPaperWidth = 76 * 3.779528
//                }
//                else if(value == EPOS2_PRINTER_SETTING_PAPERWIDTH_80_0.rawValue)
//                {
//                    self.printPaperWidth = 80 * 3.779528
//                }
//            }
//        }
//    }
    
    func onSetPrinterSetting(_ code: Int32) {
        
    }
    
    func onPtrReceive(_ printerObj: Epos2Printer!, code: Int32, status: Epos2PrinterStatusInfo!, printJobId: String!) {
        
        let queue = OperationQueue()
        queue.addOperation({ [self] in
            self.disconnectPrinter()
            self.hideIndicator();
            MessageView.showResult(code, errMessage: makeErrorMessage(status))
            dispPrinterWarnings(status)
        })
    }
    
    func makeErrorMessage(_ status: Epos2PrinterStatusInfo?) -> String {
        let errMsg = NSMutableString()
        if status == nil {
            return ""
        }
    
        if status!.online == EPOS2_FALSE {
            errMsg.append(NSLocalizedString("err_offline", comment:""))
        }
        if status!.connection == EPOS2_FALSE {
            errMsg.append(NSLocalizedString("err_no_response", comment:""))
        }
        if status!.coverOpen == EPOS2_TRUE {
            errMsg.append(NSLocalizedString("err_cover_open", comment:""))
        }
        if status!.paper == EPOS2_PAPER_EMPTY.rawValue {
            errMsg.append(NSLocalizedString("err_receipt_end", comment:""))
        }
        if status!.paperFeed == EPOS2_TRUE || status!.panelSwitch == EPOS2_SWITCH_ON.rawValue {
            errMsg.append(NSLocalizedString("err_paper_feed", comment:""))
        }
        if status!.errorStatus == EPOS2_MECHANICAL_ERR.rawValue || status!.errorStatus == EPOS2_AUTOCUTTER_ERR.rawValue {
            errMsg.append(NSLocalizedString("err_autocutter", comment:""))
            errMsg.append(NSLocalizedString("err_need_recover", comment:""))
        }
        if status!.errorStatus == EPOS2_UNRECOVER_ERR.rawValue {
            errMsg.append(NSLocalizedString("err_unrecover", comment:""))
        }
    
        if status!.errorStatus == EPOS2_AUTORECOVER_ERR.rawValue {
            if status!.autoRecoverError == EPOS2_HEAD_OVERHEAT.rawValue {
                errMsg.append(NSLocalizedString("err_overheat", comment:""))
                errMsg.append(NSLocalizedString("err_head", comment:""))
            }
            if status!.autoRecoverError == EPOS2_MOTOR_OVERHEAT.rawValue {
                errMsg.append(NSLocalizedString("err_overheat", comment:""))
                errMsg.append(NSLocalizedString("err_motor", comment:""))
            }
            if status!.autoRecoverError == EPOS2_BATTERY_OVERHEAT.rawValue {
                errMsg.append(NSLocalizedString("err_overheat", comment:""))
                errMsg.append(NSLocalizedString("err_battery", comment:""))
            }
            if status!.autoRecoverError == EPOS2_WRONG_PAPER.rawValue {
                errMsg.append(NSLocalizedString("err_wrong_paper", comment:""))
            }
        }
        if status!.batteryLevel == EPOS2_BATTERY_LEVEL_0.rawValue {
            errMsg.append(NSLocalizedString("err_battery_real_end", comment:""))
        }
        if (status!.removalWaiting == EPOS2_REMOVAL_WAIT_PAPER.rawValue) {
            errMsg.append(NSLocalizedString("err_wait_removal", comment:""))
        }
        if (status!.unrecoverError == EPOS2_HIGH_VOLTAGE_ERR.rawValue ||
            status!.unrecoverError == EPOS2_LOW_VOLTAGE_ERR.rawValue) {
            errMsg.append(NSLocalizedString("err_voltage", comment:""));
        }
    
        return errMsg as String
    }
    
    func dispPrinterWarnings(_ status: Epos2PrinterStatusInfo?) {
        if status == nil {
            return
        }
        
        OperationQueue.main.addOperation({ [self] in
           // textWarnings.text = ""
        })
        let wanringMsg = NSMutableString()
        
        if status!.paper == EPOS2_PAPER_NEAR_END.rawValue {
            wanringMsg.append(NSLocalizedString("warn_receipt_near_end", comment:""))
        }
        
        if status!.batteryLevel == EPOS2_BATTERY_LEVEL_1.rawValue {
            wanringMsg.append(NSLocalizedString("warn_battery_near_end", comment:""))
        }
        
        if status!.paperTakenSensor == EPOS2_REMOVAL_DETECT_PAPER.rawValue {
            wanringMsg.append(NSLocalizedString("warn_detect_paper", comment:""))
        }
        
        if status!.paperTakenSensor == EPOS2_REMOVAL_DETECT_UNKNOWN.rawValue {
            wanringMsg.append(NSLocalizedString("warn_detect_unknown", comment:""))
        }
        
        OperationQueue.main.addOperation({ [self] in
           // textWarnings.text = wanringMsg as String
        })
        
    }
    
    @discardableResult
    func initializePrinterObject() -> Bool {
        printer = Epos2Printer(printerSeries: valuePrinterSeries.rawValue, lang: valuePrinterModel.rawValue)
        
        if printer == nil {
            return false
        }
        printer!.setReceiveEventDelegate(self)
       // printer!.getSetting(Int(EPOS2_PARAM_DEFAULT), type:EPOS2_PRINTER_SETTING_PAPERWIDTH.rawValue, delegate : self)
        return true
    }
    
    func finalizePrinterObject() {
        if printer == nil {
            return
        }

        printer!.setReceiveEventDelegate(nil)
        printer = nil
    }
    
    
    func runPrinterReceiptSequence() -> Bool {
        if !createReceiptData() {
            return false
        }
        
        if !printData() {
            return false
        }
        
        return true
    }
    
    
    func createReceiptData() -> Bool {
//        let barcodeWidth = 2
//        let barcodeHeight = 100
        
        var result = EPOS2_SUCCESS.rawValue
        
       // let textData: NSMutableString = NSMutableString()
         // UIImage(named: "store.png")
        //self.logData = self.view.toImage()
        
        if self.logData == nil {
            return false
        }

//        result = printer!.addTextAlign(EPOS2_ALIGN_CENTER.rawValue)
//        if result != EPOS2_SUCCESS.rawValue {
//            MessageView.showErrorEpos(result, method:"addTextAlign")
//            return false;
//        }
        
        //self.showMessageAlert(message: "print Paper Width is \(self.printPaperWidth) and image width is \(UIScreen.main.bounds.size.width)") //self.logData.size.width
        
        
        //let hgt = (printPaperWidth * self.logData.size.height)/self.logData.size.width
                
        result = printer!.add(self.logData, x: 0, y:0,
                              width:Int(self.logData.size.width),
                              height:Int(self.logData.size.height),
            color:EPOS2_COLOR_1.rawValue,
            mode:EPOS2_MODE_MONO.rawValue,
            halftone:EPOS2_HALFTONE_DITHER.rawValue,
            brightness:Double(EPOS2_PARAM_DEFAULT),
            compress:EPOS2_COMPRESS_AUTO.rawValue)
        
        if result != EPOS2_SUCCESS.rawValue {
            printer!.clearCommandBuffer()
            MessageView.showErrorEpos(result, method:"addImage")
            return false
        }

//        // Section 1 : Store information
//        result = printer!.addFeedLine(1)
//        if result != EPOS2_SUCCESS.rawValue {
//            printer!.clearCommandBuffer()
//            MessageView.showErrorEpos(result, method:"addFeedLine")
//            return false
//        }
//        
//        textData.append("THE STORE 123 (555) 555 – 5555\n")
//        textData.append("STORE DIRECTOR – John Smith\n")
//        textData.append("\n")
//        textData.append("7/01/07 16:58 6153 05 0191 134\n")
//        textData.append("ST# 21 OP# 001 TE# 01 TR# 747\n")
//        textData.append("------------------------------\n")
//        result = printer!.addText(textData as String)
//        if result != EPOS2_SUCCESS.rawValue {
//            printer!.clearCommandBuffer()
//            MessageView.showErrorEpos(result, method:"addText")
//            return false;
//        }
//        textData.setString("")
//        
//        // Section 2 : Purchaced items
//        textData.append("400 OHEIDA 3PK SPRINGF  9.99 R\n")
//        textData.append("410 3 CUP BLK TEAPOT    9.99 R\n")
//        textData.append("445 EMERIL GRIDDLE/PAN 17.99 R\n")
//        textData.append("438 CANDYMAKER ASSORT   4.99 R\n")
//        textData.append("474 TRIPOD              8.99 R\n")
//        textData.append("433 BLK LOGO PRNTED ZO  7.99 R\n")
//        textData.append("458 AQUA MICROTERRY SC  6.99 R\n")
//        textData.append("493 30L BLK FF DRESS   16.99 R\n")
//        textData.append("407 LEVITATING DESKTOP  7.99 R\n")
//        textData.append("441 **Blue Overprint P  2.99 R\n")
//        textData.append("476 REPOSE 4PCPM CHOC   5.49 R\n")
//        textData.append("461 WESTGATE BLACK 25  59.99 R\n")
//        textData.append("------------------------------\n")
//        
//        result = printer!.addText(textData as String)
//        if result != EPOS2_SUCCESS.rawValue {
//            printer!.clearCommandBuffer()
//            MessageView.showErrorEpos(result, method:"addText")
//            return false;
//        }
//        textData.setString("")
//
//        
//        // Section 3 : Payment infomation
//        textData.append("SUBTOTAL                160.38\n");
//        textData.append("TAX                      14.43\n");
//        result = printer!.addText(textData as String)
//        if result != EPOS2_SUCCESS.rawValue {
//            printer!.clearCommandBuffer()
//            MessageView.showErrorEpos(result, method:"addText")
//            return false
//        }
//        textData.setString("")
//        
//        result = printer!.addTextSize(2, height:2)
//        if result != EPOS2_SUCCESS.rawValue {
//            printer!.clearCommandBuffer()
//            MessageView.showErrorEpos(result, method:"addTextSize")
//            return false
//        }
//        
//        result = printer!.addText("TOTAL    174.81\n")
//        if result != EPOS2_SUCCESS.rawValue {
//            printer!.clearCommandBuffer()
//            MessageView.showErrorEpos(result, method:"addText")
//            return false;
//        }
//        
//        result = printer!.addTextSize(1, height:1)
//        if result != EPOS2_SUCCESS.rawValue {
//            printer!.clearCommandBuffer()
//            MessageView.showErrorEpos(result, method:"addTextSize")
//            return false;
//        }
//        
//        result = printer!.addFeedLine(1)
//        if result != EPOS2_SUCCESS.rawValue {
//            printer!.clearCommandBuffer()
//            MessageView.showErrorEpos(result, method:"addFeedLine")
//            return false;
//        }
//        
//        textData.append("CASH                    200.00\n")
//        textData.append("CHANGE                   25.19\n")
//        textData.append("------------------------------\n")
//        result = printer!.addText(textData as String)
//        if result != EPOS2_SUCCESS.rawValue {
//            printer!.clearCommandBuffer()
//            MessageView.showErrorEpos(result, method:"addText")
//            return false
//        }
//        textData.setString("")
//        
//        // Section 4 : Advertisement
//        textData.append("Purchased item total number\n")
//        textData.append("Sign Up and Save !\n")
//        textData.append("With Preferred Saving Card\n")
//        result = printer!.addText(textData as String)
//        if result != EPOS2_SUCCESS.rawValue {
//            printer!.clearCommandBuffer()
//            MessageView.showErrorEpos(result, method:"addText")
//            return false;
//        }
//        textData.setString("")
//        
//        result = printer!.addFeedLine(2)
//        if result != EPOS2_SUCCESS.rawValue {
//            printer!.clearCommandBuffer()
//            MessageView.showErrorEpos(result, method:"addFeedLine")
//            return false
//        }
//        
//        result = printer!.addBarcode("01209457",
//            type:EPOS2_BARCODE_CODE39.rawValue,
//            hri:EPOS2_HRI_BELOW.rawValue,
//            font:EPOS2_FONT_A.rawValue,
//            width:barcodeWidth,
//            height:barcodeHeight)
//        if result != EPOS2_SUCCESS.rawValue {
//            printer!.clearCommandBuffer()
//            MessageView.showErrorEpos(result, method:"addBarcode")
//            return false
//        }
//        
        result = printer!.addCut(EPOS2_CUT_FEED.rawValue)
        if result != EPOS2_SUCCESS.rawValue {
            printer!.clearCommandBuffer()
            MessageView.showErrorEpos(result, method:"addCut")
            return false
        }
        
        return true
    }
    
    func printData() -> Bool {
        if printer == nil {
            return false
        }
        
        if !connectPrinter() {
            printer!.clearCommandBuffer()
            return false
        }
        
        let result = printer!.sendData(Int(EPOS2_PARAM_DEFAULT))
        if result != EPOS2_SUCCESS.rawValue {
            printer!.clearCommandBuffer()
            MessageView.showErrorEpos(result, method:"sendData")
            printer!.disconnect()
            return false
        }
        
        return true
    }
    
    func connectPrinter() -> Bool {
        var result: Int32 = EPOS2_SUCCESS.rawValue
        
        if printer == nil {
            return false
        }
        //
        //251 //192.168.10.226
        //Note: This API must be used from background thread only
        result = printer!.connect("TCP:50:57:9C:F4:9B:1F", timeout:Int(EPOS2_PARAM_DEFAULT))
        if result != EPOS2_SUCCESS.rawValue {
            
            if(AppDelegate.sharedDelegate().isPrintPermissionAsked == "")
            {
                print(" ==========  Error for first Time print \(result)")
            }
            else
            {
                MessageView.showErrorEpos(result, method:"connect")
            }
            return false
        }
        
        return true
    }
    
//    class fileprivate func getEposErrorText(_ error : Int32) -> String {
//        var errText = ""
//        switch (error) {
//        case EPOS2_SUCCESS.rawValue:
//            errText = "SUCCESS"
//            break
//        case EPOS2_ERR_PARAM.rawValue:
//            errText = "ERR_PARAM"
//            break
//        case EPOS2_ERR_CONNECT.rawValue:
//            errText = "ERR_CONNECT"
//            break
//        case EPOS2_ERR_TIMEOUT.rawValue:
//            errText = "ERR_TIMEOUT"
//            break
//        case EPOS2_ERR_MEMORY.rawValue:
//            errText = "ERR_MEMORY"
//            break
//        case EPOS2_ERR_ILLEGAL.rawValue:
//            errText = "ERR_ILLEGAL"
//            break
//        case EPOS2_ERR_PROCESSING.rawValue:
//            errText = "ERR_PROCESSING"
//            break
//        case EPOS2_ERR_NOT_FOUND.rawValue:
//            errText = "ERR_NOT_FOUND"
//            break
//        case EPOS2_ERR_IN_USE.rawValue:
//            errText = "ERR_IN_USE"
//            break
//        case EPOS2_ERR_TYPE_INVALID.rawValue:
//            errText = "ERR_TYPE_INVALID"
//            break
//        case EPOS2_ERR_DISCONNECT.rawValue:
//            errText = "ERR_DISCONNECT"
//            break
//        case EPOS2_ERR_ALREADY_OPENED.rawValue:
//            errText = "ERR_ALREADY_OPENED"
//            break
//        case EPOS2_ERR_ALREADY_USED.rawValue:
//            errText = "ERR_ALREADY_USED"
//            break
//        case EPOS2_ERR_BOX_COUNT_OVER.rawValue:
//            errText = "ERR_BOX_COUNT_OVER"
//            break
//        case EPOS2_ERR_BOX_CLIENT_OVER.rawValue:
//            errText = "ERR_BOXT_CLIENT_OVER"
//            break
//        case EPOS2_ERR_UNSUPPORTED.rawValue:
//            errText = "ERR_UNSUPPORTED"
//            break
//        case EPOS2_ERR_FAILURE.rawValue:
//            errText = "ERR_FAILURE"
//            break
//        default:
//            errText = String(format:"%d", error)
//            break
//        }
//        return errText
//    }
    
    func disconnectPrinter() {
        var result: Int32 = EPOS2_SUCCESS.rawValue
        
        if printer == nil {
            return
        }
        
        //Note: This API must be used from background thread only
        result = printer!.disconnect()
        if result != EPOS2_SUCCESS.rawValue {
            DispatchQueue.main.async(execute: {
                MessageView.showErrorEpos(result, method:"disconnect")
            })
        }

        printer!.clearCommandBuffer()
    }
}

extension UIViewController {
    public func showIndicator(_ msg: String?) {
        if msg == nil {
            return
        }
        OperationQueue.main.addOperation({ [self] in
            let alertController = UIAlertController(title: "", message: msg, preferredStyle: .alert)
            if #available(iOS 13.0, *) {
                let view = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
                view.center = CGPoint(x: 60, y: 30)
                alertController.view.addSubview(view)
                view.startAnimating()
                present(alertController, animated: true)
                view.setNeedsDisplay()
            } else {
                // Fallback on earlier versions
            }
           
        })
    }
    public func hideIndicator() {
        OperationQueue.main.addOperation({ [self] in
            dismiss(animated: true)
            view.setNeedsDisplay()
        })
    }
}

