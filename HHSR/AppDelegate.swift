//
//  AppDelegate.swift
//  DiningApp
//
//  Created by Intelli on 2022-10-07.
//

import UIKit
import IQKeyboardManagerSwift
import Firebase
import UserNotifications

var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
    var RoomId : String = ""
    var RoomName : String = ""
    var Occupancy : Int = 1
    var ResidentName : String = ""
    var LanguagePref : Int = 0
    var LanguagePrefCode : String = "en"
    var LastMenuDate : Date = Date()
    var UserRole : String = "user"
    var brk_guidelineText : String = ""
    var lunch_guidelineText : String = ""
    var dinner_guidelineText : String = ""
    var isPrintPermissionAsked : String = ""
    var arRoomList : [clsRoom] = []
    var lastMenuDate : String = ""
    var arFormList : [clsForms] = []
    var arUserList : [clsUsers] = []
    var arLoggedBy : [String] = []
    var UserId : String = ""
    var showDining = 0
    var showIncident = 0
    var IsForkitchenSummary = false
    
    class func sharedDelegate() -> AppDelegate
    {
        return appDelegate
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        self.window = UIWindow(frame: UIScreen.main.bounds)
        IQKeyboardManager.shared.enable = true        
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = false
        UNUserNotificationCenter.current().delegate = self
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
                  if granted {
                      DispatchQueue.main.async {
                          UIApplication.shared.registerForRemoteNotifications()
                      }
                  } else {
                      print("Permission for push notifications denied.")
                  }
        }
        
        self.RoomId = CommonUtility.shared.getRoomId()
        self.RoomName = CommonUtility.shared.getRoomName()
        let allLoggedBy = CommonUtility.shared.getLoggedBy()
        if(allLoggedBy.count > 0)
        {
            self.arLoggedBy = allLoggedBy.components(separatedBy: "*arLog*") //split(separator: "*arLog*")
        }
        self.isPrintPermissionAsked = CommonUtility.shared.getPrintPermissionStatus()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            CommonUtility.shared.setStatusBarAppearance()
         }
        
        print("from app del")
        
        let vc = StoryBoardConstant.MAIN_STORYBOARD.instantiateViewController(withIdentifier: "SplashScreenVC") as! SplashScreenVC
        let NavVc = UINavigationController(rootViewController: vc)
        NavVc.isNavigationBarHidden = true
        self.window?.rootViewController = NavVc
        self.window?.makeKeyAndVisible()
        return true
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        self.refreshRoomList()
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        self.window?.endEditing(true)
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationNamesConstant.keyAppEnteredBg), object: nil, userInfo: nil)
    }
    
    func loadLoginPage()
    {
        let LoginVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
       // let vc = StoryBoardConstant.MAIN_STORYBOARD.instantiateViewController(withIdentifier: "SignUpSuccessVC")
        let NavVc = UINavigationController(rootViewController: LoginVC)
        NavVc.isNavigationBarHidden = true
        self.window?.rootViewController = NavVc
        self.window?.makeKeyAndVisible()
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken.map { String(format: "%02x", $0) }.joined()//"%02x" //%02.2hhx
        //print("Device Token: \(token)")
        
        let params : [String : Any] = ["token" : token]
        NetworkUtilities.shared.makePOSTRequest(with: API.baseURL + API.set_device_token_api, parameters: params) { (response) in
        
            if (response.error == nil)
            {
                if(response.result[MainResponseCodeConstant.keyResponseCode].intValue == MainResponseCodeConstant.keyResponseCodeOne)
                {
                    print("Device Token: \(token)")
                }
                else
                {
                   // CommonUtility.shared.showErrorAlertOnWindow(message: response.result[MainResponseCodeConstant.keyResponseText].stringValue)
                }
            }
            else
            {
//                 if(response.error!.localizedDescription == ErrorMsg.keyTurnOnAppCellularData)
//                 {
//                     CommonUtility.shared.showAppCellularDataAlertOnWindow(message: response.error!.localizedDescription)
//                 }
//                 else
//                 {
//                     CommonUtility.shared.showErrorAlertOnWindow(message: response.error!.localizedDescription)
//                 }
            }
        }
    }
    
    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register:", error.localizedDescription)
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationNamesConstant.keyAppBecameActive), object: nil, userInfo: nil)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping(UIBackgroundFetchResult) -> Void) {
        print("Did receive remote fetch completion")
        //CommonUtility.shared.showErrorAlertOnWindow(message: "Push received")
        self.refreshRoomList()
        completionHandler(.newData)
    }
    
    func refreshRoomList()
    {
        print("start room refresh")
       // let params : [String : Any] = ["token" : token]
        NetworkUtilities.shared.makeGETRequest(with: API.baseURL + "rooms-list") { (response) in
         
            if (response.error == nil)
            {
                if(response.result[MainResponseCodeConstant.keyResponseCode].intValue == MainResponseCodeConstant.keyResponseCodeOne)
                {
                    print("end room refresh")
                    AppDelegate.sharedDelegate().arRoomList.removeAll()
                    AppDelegate.sharedDelegate().arRoomList.append(contentsOf: response.result[MainResponseCodeConstant.keyRoomsList].arrayValue.compactMap(clsRoom.init))
                }
                else
                {
                    // CommonUtility.shared.showErrorAlertOnWindow(message: response.result[MainResponseCodeConstant.keyResponseText].stringValue)
                }
            }
            else
            {
                //                 if(response.error!.localizedDescription == ErrorMsg.keyTurnOnAppCellularData)
                //                 {
                //                     CommonUtility.shared.showAppCellularDataAlertOnWindow(message: response.error!.localizedDescription)
                //                 }
                //                 else
                //                 {
                //                     CommonUtility.shared.showErrorAlertOnWindow(message: response.error!.localizedDescription)
                //                 }
            }
        }
    }

}

