//
//  AppDelegate.swift
//  RakutenRanking
//
//  Created by mao takagai on 2018/03/12.
//  Copyright © 2018年 mao takagai. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let config = Realm.Configuration(
            schemaVersion: 0
            )
        Realm.Configuration.defaultConfiguration = config
        
        // StoryBoardを取得
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        // TabBarControllerを生成
        let tabBarController = setUpTabBarController(storyboard)
        // SlideMenuViewControllerのメイン画面、メニュー画面をセット
        let menuVC = setMenuViewController(storyboard)
        let viewController = SlideViewController(mainViewController: tabBarController, leftMenuViewController: menuVC)
        // アプリのrootViewControllerを設定する
        self.window?.rootViewController = viewController
        self.window?.makeKeyAndVisible()
        // アプリ全体のnavigationBarの設定
        setUpNavigationBar()
        
        return true
    }
    
    private func setUpTabBarController(_ storyboard: UIStoryboard) -> UITabBarController {
        // TabBarControllerの子ビューにviewControllersをセット
        let tabBarController = UITabBarController()
        var viewControllers: [UIViewController] = []
        viewControllers = createViewControllerArray(storyboard)
        tabBarController.setViewControllers(viewControllers, animated: false)
        // 起動時の表示を真ん中のランキング画面にする
        tabBarController.selectedIndex = 1
        
        return tabBarController
    }
    
    private func createViewControllerArray(_ storyboard: UIStoryboard) -> [UIViewController] {
        // ViewControllerを配列にまとめる
        var viewControllers: [UIViewController] = []
        // 1ページ目になるViewController
        let firstVC = storyboard.instantiateViewController(withIdentifier: "Config") as! ConfigViewController
        firstVC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(named: "Setting"), tag: 1)
        let first = UINavigationController(rootViewController: firstVC)
        viewControllers.append(first)
        // 2ページ目になるViewController
        let secondVC = storyboard.instantiateViewController(withIdentifier: "Main") as! ViewController
        secondVC.tabBarItem = UITabBarItem(title: "Rankings", image: UIImage(named: "Ranking"), tag: 2)
        let second = UINavigationController(rootViewController: secondVC)
        viewControllers.append(second)
        // 3ページ目になるViewController
        let thirdVC = storyboard.instantiateViewController(withIdentifier: "Favorite") as! FavoriteViewController
        thirdVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(named: "FavoriteList"), tag: 3)
        let third = UINavigationController(rootViewController: thirdVC)
        viewControllers.append(third)
        
        return viewControllers
    }
    
    private func setMenuViewController(_ storyboard: UIStoryboard) -> UINavigationController {
        // MenuViewControllerの生成
        let menuVC = storyboard.instantiateViewController(withIdentifier: "Menu") as! MenuViewController
        let menu = UINavigationController(rootViewController: menuVC)
        menu.navigationBar.barTintColor = .darkGray
        return menu
    }
    
    private func setUpNavigationBar() {
        // ナビゲーションバーの下の影を無くす
        UINavigationBar.appearance().shadowImage = UIImage()
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }


}

