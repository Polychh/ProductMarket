//
//  SceneDelegate.swift
//  ProductMarket
//
//  Created by Polina on 21.12.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.makeKeyAndVisible()
        window.rootViewController = PMTabBarController()
        self.window = window
        //configureNavigationBar()
    }
    
    private func configureNavigationBar(){ // all two our NavigationBar have search in green color
        UINavigationBar.appearance().tintColor = .systemGreen
    }
}

