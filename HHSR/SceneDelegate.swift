//
//  SceneDelegate.swift
//  DiningApp
//
//  Created by Intelli on 2022-10-07.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        print("from scene del")
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        let vc = StoryBoardConstant.MAIN_STORYBOARD.instantiateViewController(withIdentifier: "SplashScreenVC") as! SplashScreenVC
        let NavVc = UINavigationController(rootViewController: vc)
        NavVc.isNavigationBarHidden = true
        self.window?.rootViewController = NavVc
        self.window?.makeKeyAndVisible()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            CommonUtility.shared.setStatusBarAppearance()
         }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationNamesConstant.keyAppEnteredBg), object: nil, userInfo: nil)
        self.window?.endEditing(true)
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
