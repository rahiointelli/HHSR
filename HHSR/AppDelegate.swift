//
//  AppDelegate.swift
//  DiningApp
//
//  Created by Intelli on 2022-10-07.
//

import UIKit
import IQKeyboardManagerSwift
import Firebase

var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var RoomId : String = ""
    var RoomName : String = ""
    var Occupancy : Int = 1
    var ResidentName : String = ""
    var LanguagePref : Int = 0
    var LanguagePrefCode : String = "en"
    var LastMenuDate : Date = Date()
    var UserRole : String = "user"
    var guidelineText : String = ""
    var isPrintPermissionAsked : String = ""
    var arRoomList : [clsRoom] = []
    var lastMenuDate : String = ""
    var arFormList : [clsForms] = []
    var arLoggedBy : [String] = []
    
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

}

