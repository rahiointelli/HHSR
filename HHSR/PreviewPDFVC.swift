//
//  PreviewPDFVC.swift
//  HHSR
//
//  Created by Intelli on 2023-10-03.
//

import UIKit
import PDFKit

class PreviewPDFVC: UIViewController {
    
    @IBOutlet weak var act_indicator: UIActivityIndicatorView!
    @IBOutlet weak var pdf_view: PDFView!
    @IBOutlet weak var btnPrint: UIButton!
    @IBOutlet weak var btnMail: UIButton!
    @IBOutlet weak var btnAddFollowUp: UIButton!    
    
    var pdfURL : String = ""
    var urlData : NSData = NSData()
    var form_id = 0
    var isAllowPrint = 0
    var isAllowMail = 0
    var isAllowFollowUp = 0
    var CalledFrom : String = "List"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.displayPDF()
        
        self.btnMail.isHidden = (self.isAllowMail == 0) ? true : false
        self.btnPrint.isHidden = (self.isAllowPrint == 0) ? true : false
        
        if(AppDelegate.sharedDelegate().UserRole == "concierge" || AppDelegate.sharedDelegate().UserRole == "nurse")
        {
            self.btnAddFollowUp.isHidden = true
        }
        else
        {
            self.btnAddFollowUp.isHidden = (self.isAllowFollowUp == 0) ? true : false
        }

        // Do any additional setup after loading the view.
    }
    
    func displayPDF()
    {
        //"https://www.tutorialspoint.com/swift/swift_tutorial.pdf"
        guard let url = URL(string: self.pdfURL) else { return }
        do{
            self.urlData = try NSData(contentsOf: url)
            let pdfDocument = PDFDocument(data: self.urlData as Data)
            //PDFDocument(data: data)
            
            self.pdf_view.document = pdfDocument
            self.pdf_view.autoScales = true
            self.pdf_view.backgroundColor = .white
        }
        catch let err
        {
            print("error is \(err.localizedDescription)")
        }
    }
    
    
    @IBAction func btnBack_Clicked(_ sender: Any) {
        if(self.CalledFrom == "List")
        {
            self.navigationController?.popViewController(animated: false)
        }
        else
        {
           // let indx  = (self.navigationController?.viewControllers.count)! - 3
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationNamesConstant.keyRefreshFormList), object: nil, userInfo: nil)
            
            //for vc in self.navigationController?.viewControllers
            for indx in 0..<(self.navigationController?.viewControllers.count)!
            {
                let vc = self.navigationController?.viewControllers[indx]
                if (vc!.isKind(of: ListFormsVC.classForCoder()))
                {
                    self.navigationController?.popToViewController((self.navigationController?.viewControllers[indx])!, animated: false)
                    break;
                }
            }
            
           // self.navigationController?.popToViewController((self.navigationController?.viewControllers[indx])!, animated: false)
        }
    }
    
    @IBAction func btnFollowUpClicked(_ sender: Any)
    {
        let EditFormVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UnusalOccuranceVC") as! UnusalOccuranceVC
        EditFormVC.form_id = self.form_id
        EditFormVC.calledFrom = "Edit"
        if(self.isAllowFollowUp == 1)
        {
            EditFormVC.isFollowUpIncomplete = true
        }
        else
        {
            EditFormVC.isFollowUpIncomplete = false
        }
        self.navigationController?.pushViewController(EditFormVC, animated: false)
    }
    
    @IBAction func btnPrintClicked(_ sender: Any)
    {
        let printInfo = UIPrintInfo(dictionary:nil)
        printInfo.outputType = .general
        printInfo.jobName = "PDF Print"

        // Set up print controller
        let printController = UIPrintInteractionController.shared
        printController.printInfo = printInfo

        // Assign a UIImage version of my UIView as a printing iten
        printController.printingItem = self.urlData
        //NSData(contentsOf: URL(string: self.pdfURL)!)
     
        // Do it
        printController.present(animated: true, completionHandler: nil)
    }
    
    @IBAction func btnMailClicked(_ sender: Any)
    {
        let alert = UIAlertController(title: "Send Mail", message: "Enter Email Id", preferredStyle: .alert)
        alert.addTextField{ (textField : UITextField!) -> Void in
            textField.placeholder = "Email Id"
        }

        alert.addAction(UIAlertAction(title: "Send", style: .default, handler: { (action) in
            let email = alert.textFields![0] as UITextField
            print("entered email is \(email.text!)")
            if(email.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0)
            {
                self.showMessageAlert(message: "Please enter Email Id.")
            }
            else
            {
                self.callSendEmailService(mailId : email.text!)
            }
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
        }))
        
        self.present(alert, animated: true)
    }
    
    
    func callSendEmailService(mailId : String)
    {

        self.view.isUserInteractionEnabled = false
        self.act_indicator.startAnimating()
        
           
        let para = ["to_id" : mailId, "form_id" : self.form_id] as [String : Any]
        
        NetworkUtilities.shared.makePOSTRequest(with: API.baseURL + API.send_email_api, parameters: para) { (response) in
            
            
            print("api is \(API.baseURL + API.send_email_api) para are \(para)")
            
            if(response.error == nil)
            {
                self.view.isUserInteractionEnabled = true
                self.act_indicator.stopAnimating()
                if(response.result[MainResponseCodeConstant.keyResponseCode].intValue == MainResponseCodeConstant.keyResponseCodeOne)
                {
                    print(response.result)
                    self.showMessageAlert("Success", message: "Mail sent successfully.")
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
