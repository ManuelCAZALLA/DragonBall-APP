//
//  SceneDelegate.swift
//  DragonBall-APP
//
//  Created by Manuel Cazalla Colmenero on 21/9/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else {
            return
        }
        let windows = UIWindow(windowScene: scene)
        let loginViewController = LoginViewController()
        let navigationControler = UINavigationController(rootViewController: loginViewController)
        windows.rootViewController = navigationControler
        windows.makeKeyAndVisible()
        self.window = windows
    }

    
}

