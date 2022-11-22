//
//  SceneDelegate.swift
//  Practice_MVVM_WorldClock
//
//  Created by eunbiiKim on 2022/11/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        self.window = UIWindow(windowScene: windowScene)
        
        self.window?.rootViewController = ViewController()
        self.window?.makeKeyAndVisible()
    }
}

