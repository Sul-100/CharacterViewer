//
//  SceneDelegate.swift
//  CharacterViewer
//
//  Created by s on 12/16/19.
//  Copyright © 2019 Sultan Sultan. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate, UISplitViewControllerDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let window = window else { return }
         
        guard let splitViewController = window.rootViewController as? UISplitViewController else { return }
        guard let leftNavigationController = splitViewController.viewControllers.first as? UINavigationController else { return }
         // Get navCongroller for the HomeController
        guard let characterHomeViewController = leftNavigationController.viewControllers.last as? CharacterHomeViewController else {return}
        guard let detailsViewController = (splitViewController.viewControllers.last as? UINavigationController)?.topViewController as? CharacterDetailsViewController else {return}

         // Set the split view delegate as self
         splitViewController.delegate = self
         // Show both pages side by side on iPad portiat.
         splitViewController.preferredDisplayMode = .allVisible
         // set homeViewController Delegate as detailsViewController so we can pass data through the delegate method.
         characterHomeViewController.delegate = detailsViewController
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
           // We want to preset the HomeViewController as root view controller when the app Lunch. Otherwise, returning 'false' will set the 'DetialsViewController' as first view controller.
           return true
       }
}

