//
//  CommonUtility.swift
//  Richmond Sentinel
//
//  Created by Intelli on 2019-02-13.
//  Copyright © 2019 Intelli. All rights reserved.
//

import UIKit
import AVFoundation

class CommonUtility: NSObject
{
     static let shared = CommonUtility()
    
    func setStatusBarAppearance()
    {
        print("inside function")
        if #available(iOS 13.0, *)
        {
            let tag = 184824
//             if let statusBar = UIApplication.shared.keyWindow?.viewWithTag(tag) {
//                statusBar.backgroundColor = UIColor.ColorCodes.statusbar
//             } else {
            
            if #available(iOS 13.0, *) {
                let window = UIApplication.shared.windows.first
                let topPadding = window?.safeAreaInsets.top
                let statusBarView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: topPadding ?? 0.0))
                statusBarView.tag = tag
                
                UIApplication.shared.keyWindow?.addSubview(statusBarView)
                statusBarView.backgroundColor = UIColor.ColorCodes.statusbar
            }
            else
            {
                let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
                statusBarView.tag = tag
                
                UIApplication.shared.keyWindow?.addSubview(statusBarView)
                statusBarView.backgroundColor = UIColor.ColorCodes.statusbar
            }
//             }
            
        }
        else
        {
              if let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
              {
                   statusBar.backgroundColor = UIColor.ColorCodes.statusbar
              }
        }
    }
    
    func setPrintPermissionStatus(str : String)
    {
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: str)
        UserDefaults.standard.set(encodedData, forKey: UserDefaultKey.keyPrintPermissionStatus)
        UserDefaults.standard.synchronize()
    }
    
    func getPrintPermissionStatus() -> String
    {
        if UserDefaults.standard.object(forKey: UserDefaultKey.keyPrintPermissionStatus) == nil{
            let encodedData = NSKeyedArchiver.archivedData(withRootObject:  "")
            UserDefaults.standard.set(encodedData, forKey: UserDefaultKey.keyPrintPermissionStatus)
            UserDefaults.standard.synchronize()
        }
        let decoded = UserDefaults.standard.object(forKey: UserDefaultKey.keyPrintPermissionStatus) as? Data
        let decodedData =  try? (NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decoded!) as! String)
        //NSKeyedUnarchiver.unarchiveObject(with: decoded! ) as! String
        return decodedData!
    }
    
    func setRoomId(str : String)
    {
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: str)
        UserDefaults.standard.set(encodedData, forKey: UserDefaultKey.keyRoomId)
        UserDefaults.standard.synchronize()
    }
    
    func getRoomId() -> String
    {
        if UserDefaults.standard.object(forKey: UserDefaultKey.keyRoomId) == nil{
            let encodedData = NSKeyedArchiver.archivedData(withRootObject:  "")
            UserDefaults.standard.set(encodedData, forKey: UserDefaultKey.keyRoomId)
            UserDefaults.standard.synchronize()
        }
        let decoded = UserDefaults.standard.object(forKey: UserDefaultKey.keyRoomId) as? Data
        let decodedData =  try? (NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decoded!) as! String)
        //NSKeyedUnarchiver.unarchiveObject(with: decoded! ) as! String
        return decodedData!
    }
    
    func setRoomName(str : String)
    {
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: str)
        UserDefaults.standard.set(encodedData, forKey: UserDefaultKey.keyRoomName)
        UserDefaults.standard.synchronize()
    }
    
    func getRoomName() -> String
    {
        if UserDefaults.standard.object(forKey: UserDefaultKey.keyRoomName) == nil{
            let encodedData = NSKeyedArchiver.archivedData(withRootObject:  "")
            UserDefaults.standard.set(encodedData, forKey: UserDefaultKey.keyRoomName)
            UserDefaults.standard.synchronize()
        }
        let decoded = UserDefaults.standard.object(forKey: UserDefaultKey.keyRoomName) as? Data
        let decodedData =  try? (NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decoded!) as! String)
        return decodedData!
    }
    
    func setLoggedBy(str : String)
    {
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: str)
        UserDefaults.standard.set(encodedData, forKey: UserDefaultKey.keyLoggedBy)
        UserDefaults.standard.synchronize()
    }
    
    func getLoggedBy() -> String
    {
        if UserDefaults.standard.object(forKey: UserDefaultKey.keyLoggedBy) == nil{
            let encodedData = NSKeyedArchiver.archivedData(withRootObject:  "")
            UserDefaults.standard.set(encodedData, forKey: UserDefaultKey.keyLoggedBy)
            UserDefaults.standard.synchronize()
        }
        let decoded = UserDefaults.standard.object(forKey: UserDefaultKey.keyLoggedBy) as? Data
        let decodedData =  try? (NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decoded!) as! String)
        return decodedData!
    }
    
    func setUserTimeZone(str : String)
    {
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: str)
        UserDefaults.standard.set(encodedData, forKey: UserDefaultKey.keyUserTimeZone)
        UserDefaults.standard.synchronize()
    }
    
    func getUserTimeZone() -> String
    {
        if UserDefaults.standard.object(forKey: UserDefaultKey.keyUserTimeZone) == nil{
            let encodedData = NSKeyedArchiver.archivedData(withRootObject:  "")
            UserDefaults.standard.set(encodedData, forKey: UserDefaultKey.keyUserTimeZone)
            UserDefaults.standard.synchronize()
        }
        let decoded = UserDefaults.standard.object(forKey: UserDefaultKey.keyUserTimeZone) as? Data
        let decodedData =  try? (NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decoded!) as! String)
        return decodedData!
    }
  
    func setAPIToken(str : String)
    {
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: str)
        UserDefaults.standard.set(encodedData, forKey: UserDefaultKey.keyAPIToken)
        UserDefaults.standard.synchronize()
    }
    
    func getAPIToken() -> String
    {
        if UserDefaults.standard.object(forKey: UserDefaultKey.keyAPIToken) == nil{
            let encodedData = NSKeyedArchiver.archivedData(withRootObject: "")
            UserDefaults.standard.set(encodedData, forKey: UserDefaultKey.keyAPIToken)
            UserDefaults.standard.synchronize()
        }
        let decoded = UserDefaults.standard.object(forKey: UserDefaultKey.keyAPIToken) as? Data
        let decodedData =  try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decoded!) as? String
        //NSKeyedUnarchiver.unarchiveObject(with: decoded! ) as! String
        return decodedData!
    }
    
    func showErrorAlertOnWindow(_ title: String = "Error", message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
        }))
        
        
        if #available(iOS 13.0, *) {
            let sceneDelegate = UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate
            DispatchQueue.main.async {
                sceneDelegate.window?.rootViewController?.present(alert, animated: true, completion: nil)
            }
         //presentedViewController!
        } else {
            DispatchQueue.main.async {
                AppDelegate.sharedDelegate().window?.rootViewController?.present(alert, animated: true, completion: nil)
            }
        }
        
        
    }
    
    func generateVideoThumb(url : URL) -> CGImage?
    {
         let asset = AVAsset(url: url)
         let imageGenerator = AVAssetImageGenerator(asset: asset)
         imageGenerator.appliesPreferredTrackTransform = true
         let time = CMTimeMake(value: 0, timescale: 1)
        do {
            return try imageGenerator.copyCGImage(at: time, actualTime: nil)
        }catch{ return nil}
    }
    
     func setAPNsDeviceToken(str : String)
     {
          let encodedData = NSKeyedArchiver.archivedData(withRootObject: str)
          UserDefaults.standard.set(encodedData, forKey: UserDefaultKey.keyAPNsDeviceToken)
          UserDefaults.standard.synchronize()
     }
      
     func getAPNsDeviceToken() -> String
     {
          if UserDefaults.standard.object(forKey: UserDefaultKey.keyAPNsDeviceToken) == nil{
              let encodedData = NSKeyedArchiver.archivedData(withRootObject: "")
              UserDefaults.standard.set(encodedData, forKey: UserDefaultKey.keyAPNsDeviceToken)
              UserDefaults.standard.synchronize()
          }
          let decoded = UserDefaults.standard.object(forKey: UserDefaultKey.keyAPNsDeviceToken) as? Data
          let decodedData =  try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decoded!) as? String
              //NSKeyedUnarchiver.unarchiveObject(with: decoded! ) as! String
          return decodedData!
     }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}
