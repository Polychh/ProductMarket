//
//  PMTabBarController.swift
//  ProductMarket
//
//  Created by Polina on 21.12.2023.
//

import UIKit

final class PMTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarAppearence()
        generateTabBar()
    }
    
    private func generateTabBar(){
        let main = generateVC(viewController: MainViewController(), title: "Главная", vcTitle: "Эко Маркет", image: UIImage(named: "main"))
        let basket = generateVC(viewController: BasketViewController(), title: "Корзина", vcTitle: "Корзина", image: UIImage(named: "basket"))
        let history = generateVC(viewController: HistoryViewController(), title:  "История", vcTitle: "История заказов", image: UIImage(named: "history"))
        let info = generateVC(viewController: InfoViewController(), title: "Инфо", vcTitle: "Инфо", image: UIImage(named: "info"))
        self.setViewControllers([main, basket, history, info], animated: true)
    }
    
    private func generateVC(viewController: UIViewController, title: String, vcTitle: String, image: UIImage?) -> UINavigationController{
        let nav = UINavigationController(rootViewController: viewController)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        nav.viewControllers.first?.navigationItem.title = vcTitle
        nav.navigationBar.titleTextAttributes =  [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24)]
        return nav
    }
    
    private func setTabBarAppearence(){
        self.tabBar.layer.borderWidth = 0.5
        self.tabBar.layer.borderColor = UIColor.lightGray.cgColor
        self.tabBar.backgroundColor = .white
        self.tabBar.tintColor = Const.colorGreen
    }
}
