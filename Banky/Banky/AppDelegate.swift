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
    let mainViewController = MainViewController()
    var hasOnboarded = false
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
        onboardingViewController.delegate = self
        loginViewController.delegate = self
        
        displayLogin()
        registerForNotifications()
        return true
    }
    
    private func displayLogin() {
        //FIX: - REMOVE THE Mainview controller and uncomment `setRootViewController(loginViewController)`
//        setRootViewController(loginViewController)
        prepMainView()
        setRootViewController(mainViewController)

    }
    
    
    private func displayNextScreen() {
        if LocalState.hasOnboarded {
            prepMainView()
            setRootViewController(mainViewController)
        } else {
            setRootViewController(onboardingViewController)
        }
    }
    
    private func prepMainView() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = K.colors.appColor
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactScrollEdgeAppearance = appearance
        UINavigationBar.appearance().isTranslucent = false
    }
    
    private func registerForNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(didLogout), name: .logout, object: nil)
    }

}


extension AppDelegate: LoginViewControllerDelegate {
    func didLogin() {
        displayNextScreen()
    }
}

// logut action
extension AppDelegate {
    @objc
    func didLogout() {
        setRootViewController(loginViewController)
    }
}

extension AppDelegate: OnboardingContainerViewControllerDelgate {
    func didFinishOnboarding() {
        LocalState.hasOnboarded = true
        prepMainView()
        setRootViewController(mainViewController)
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
