//
//  ViewController.swift
//  iEduGame
//
//  Created by Intelli on 2021-09-22.
//

import UIKit
import SwiftyGif

class SplashScreenVC: UIViewController {
    

    @IBOutlet weak var img_View: UIImageView!
    @IBOutlet weak var img_top: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.tblScores.register(UINib(nibName: "LeaderBoardTblCell", bundle: nil), forCellReuseIdentifier: "LeaderBoardTblCell")

//        // Do any additional setup after loading the view.
       
        let lyr = CAGradientLayer()
        lyr.frame = self.view.bounds
        lyr.type = .radial
        lyr.colors = [UIColor(red: 0/255, green: 128/255, blue: 255/255, alpha: 1.0).cgColor, UIColor(red: 15/255, green: 82/255, blue: 186/255, alpha: 1.0).cgColor, UIColor(red: 16/255, green: 52/255, blue: 166/255, alpha: 1.0).cgColor, UIColor(red: 17/255, green: 30/255, blue: 108/255, alpha: 1.0).cgColor, UIColor(red: 0/255, green: 0/255, blue: 128/255, alpha: 1.0).cgColor]
        //[UIColor(red: 26/255, green: 55/255, blue: 117/255, alpha: 1.0).cgColor, UIColor(red: 15/255, green: 31/255, blue: 58/255, alpha: 1.0).cgColor]
//        [UIColor.red.cgColor,
//                      UIColor.yellow.cgColor,
//                      UIColor.green.cgColor,
//                      UIColor.blue.cgColor]
        lyr.locations = [0, 0.30, 0.50, 0.80, 1.0]// [ 0, 0.1, 0.2, 1 ]
        lyr.startPoint = CGPoint(x: 0.5, y: 0.5)
        lyr.endPoint = CGPoint(x: 1, y: 0.8)
      //  self.view.layer.insertSublayer(lyr, at: 0)
       
        do {
        let gif = try UIImage(gifName: "splash.gif")
        self.img_View.setGifImage(gif, loopCount: 1)
        }
        catch {
           print(error)
       }
        
        if(AppDelegate.sharedDelegate().RoomId == "")
        {
            let LoginVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            DispatchQueue.main.asyncAfter(deadline: .now() +  2.7) {
                self.navigationController?.pushViewController(LoginVC, animated: false)
            }
        }
        else
        {
            print("splash view loaded")
            self.CallProfileService()
//            let catVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CategorySelectionVC") as! CategorySelectionVC
//            DispatchQueue.main.asyncAfter(deadline: .now() +  2.7) {
//                self.navigationController?.pushViewController(catVC, animated: false)
//            }
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        let remaining_space = (UIScreen.main.bounds.size.height/2) - (self.img_View.frame.size.height/2)
        self.img_top.constant = remaining_space * 0.83
        //UIScreen.main.bounds.size.height * 0.375
    }
    
    func CallProfileService()
    {
        self.view.isUserInteractionEnabled = false
        print("from profile")
        NetworkUtilities.shared.makePOSTRequest(with: API.baseURL + "get-user-data", parameters: nil) { (response) in

            if(response.error == nil)
            {
                self.view.isUserInteractionEnabled = true
                if(response.result[MainResponseCodeConstant.keyResponseCode].intValue == MainResponseCodeConstant.keyResponseCodeOne)
                {
                    print(response.result)
                    AppDelegate.sharedDelegate().arRoomList.removeAll()
                    AppDelegate.sharedDelegate().arRoomList.append(contentsOf: response.result[MainResponseCodeConstant.keyRoomsList].arrayValue.compactMap(clsRoom.init))
                    
                    AppDelegate.sharedDelegate().UserRole = response.result["role"].stringValue
                    AppDelegate.sharedDelegate().Occupancy = response.result["occupancy"].intValue
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd"
                    AppDelegate.sharedDelegate().LastMenuDate = formatter.date(from: response.result[MainResponseCodeConstant.keyLastMenuDate].stringValue)!
                    AppDelegate.sharedDelegate().LanguagePref = response.result["language"].intValue
                    if(AppDelegate.sharedDelegate().LanguagePref == 0)
                    {
                        AppDelegate.sharedDelegate().LanguagePrefCode = "en"
                        AppDelegate.sharedDelegate().guidelineText = response.result["guideline"].stringValue
                    }
                    else
                    {
                        AppDelegate.sharedDelegate().LanguagePrefCode = "zh-HK"
                        AppDelegate.sharedDelegate().guidelineText = response.result["guideline_cn"].stringValue
                    }
                                        
                    DispatchQueue.main.asyncAfter(deadline: .now() +  2.2) {
                        if(AppDelegate.sharedDelegate().UserRole == "superadmin" || AppDelegate.sharedDelegate().UserRole == "admin" || AppDelegate.sharedDelegate().UserRole == "concierge" || AppDelegate.sharedDelegate().UserRole == "nurse")
                        {
                            AppDelegate.sharedDelegate().arFormList.removeAll()
                            AppDelegate.sharedDelegate().arFormList.append(contentsOf: response.result["form_types"].arrayValue.compactMap(clsForms.init))
                            
//                            let SearchRoomVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchRoomVC") as! SearchRoomVC
//                            self.navigationController?.pushViewController(SearchRoomVC, animated: false)
                            let catVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CategorySelectionVC") as! CategorySelectionVC
                            self.navigationController?.pushViewController(catVC, animated: false)
                        }
                        else
                        {
                            let MealItemsVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MealItemsVC") as! MealItemsVC
                            MealItemsVC.selectedRoomName = AppDelegate.sharedDelegate().RoomName
                            MealItemsVC.selectedRoomID = Int(AppDelegate.sharedDelegate().RoomId)!
                            MealItemsVC.Occupancy = AppDelegate.sharedDelegate().Occupancy
                            MealItemsVC.lastMenuDate = AppDelegate.sharedDelegate().LastMenuDate
                            self.navigationController?.pushViewController(MealItemsVC, animated: false)
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

}

