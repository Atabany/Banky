//
//  UIViewController + Utils.swift
//  Banky
//
//  Created by Mohamed Elatabany on 15/03/2022.
//


import UIKit

extension UIViewController {

    
//    func setStatusBar() {
//        let statusBarSize = UIApplication.shared.statusBarFrame.size
//        let frame = CGRect(origin: .zero, size: statusBarSize)
//        let statusBarView = UIView(frame: frame)
//        statusBarView.backgroundColor = K.colors.appColor
//        view.addSubview(statusBarView)
//    }
    
    func setTabBarImage(imageName: String, title: String) {
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: imageName, withConfiguration: configuration)
        tabBarItem = UITabBarItem(title: title, image: image, tag: 0)
    }
    
    
    func hideNavigationBarLine(_ navigationBar: UINavigationBar, color: UIColor) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.shadowImage = UIImage()
        appearance.shadowColor = .clear
        appearance.backgroundColor = color
        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.compactScrollEdgeAppearance = appearance
        UINavigationBar.appearance().isTranslucent = false
    }

    
    
}
