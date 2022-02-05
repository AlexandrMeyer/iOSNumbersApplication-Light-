//
//  SceneDelegate.swift
//  iOSNumbersApplication(Light)
//
//  Created by Александр on 17/01/2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate, UISplitViewControllerDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        
        let splitVC = UISplitViewController(style: .doubleColumn)
        splitVC.viewControllers = [
            UINavigationController(rootViewController: MasterTableViewController()),
            UINavigationController(rootViewController: DetailViewController())
        ]
        splitVC.maximumPrimaryColumnWidth = splitVC.view.frame.width
        splitVC.preferredPrimaryColumnWidthFraction = 1/2
        
        let firstItem = MasterTableViewController().numbers.first
        DetailViewController().number = firstItem
        window?.rootViewController = splitVC
    }
}

