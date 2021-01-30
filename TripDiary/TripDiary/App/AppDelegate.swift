//
//  AppDelegate.swift
//  TripDiary
//
//  Created by 이운형 on 2021/01/09.
//

import UIKit

@objcMembers
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        sleep(3)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        
        let mainViewController = MainViewController.instantiate()
        mainViewController.logInViewController = getLogInViewController()
        
        window?.rootViewController = UINavigationController(rootViewController: mainViewController)
        window?.makeKeyAndVisible()
        
        return true
    }
}

extension AppDelegate {
    private func getLogInViewController() -> LogInViewController {
        let logInViewController = LogInViewController.instantiate()
        logInViewController.completionCallback = { [weak self] (completionType) in
            switch completionType {
            case .loginComplete:
                // Todo: show TabBarController
                print("Should show tabBar")
                self?.showMainTabBarController()
            }
        }
        
        return logInViewController
    }
    
    private func showMainTabBarController() {
        let view = getLogInViewController()
        window?.switchRootViewController(to: view,
                                         animated: true,
                                         duration: 0.3,
                                         options: .transitionCrossDissolve,
                                         nil)
    }
}

// MARK: - UIWindow Extensions
extension UIWindow {
    func switchRootViewController(to viewController: UIViewController,
                                  animated: Bool = true,
                                  duration: TimeInterval = 0.5,
                                  options: UIView.AnimationOptions = .transitionFlipFromRight,
                                  _ completion: (() -> Void)? = nil) {
        
        guard animated else {
            rootViewController = viewController
            completion?()
            return
        }
        
        UIView.transition(with: self, duration: duration, options: options, animations: {
            let oldState = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            self.rootViewController = viewController
            UIView.setAnimationsEnabled(oldState)
        }, completion: { _ in
            completion?()
        })
    }
}
