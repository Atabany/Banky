//
//  AppDelegate.swift
//  Banky
//
//  Created by Mohamed Elatabany on 13/03/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    
    let loginViewController = LoginViewController()
    let onboardingViewController = OnboardingContainerViewController()
    let homeVC = HomeVC()
    var hasOnboarded = false
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
        onboardingViewController.delegate = self
        loginViewController.delegate = self
        homeVC.delegate = self

        window?.rootViewController = homeVC
        
        return true
    }
    
}

extension AppDelegate: LoginViewControllerDelegate {
    func didLogin() {
        if LocalState.hasOnboarded {
            setRootViewController(homeVC)
        } else {
            setRootViewController(onboardingViewController)
        }
        
    }
}


extension AppDelegate: OnboardingContainerViewControllerDelgate {
    func didFinishOnboarding() {
        LocalState.hasOnboarded = true
        setRootViewController(homeVC)
    }
}


extension AppDelegate: LogoutDelegate {
    func didLogout() {
        setRootViewController(loginViewController)
    }
}


extension AppDelegate {
    func setRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard animated, let window = self.window else {
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            return
        }
        window.rootViewController = vc
        window.makeKeyAndVisible()

        UIView.transition(with: window ,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
    }

}
