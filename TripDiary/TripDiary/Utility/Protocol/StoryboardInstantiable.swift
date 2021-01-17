//
//  StoryboardInstantiable.swift
//  TripDiary
//
//  Created by 이운형 on 2021/01/12.
//

import UIKit

public protocol StoryboardInstantiable where Self: UIViewController {
    static func instantiate() -> Self
}

extension StoryboardInstantiable {
    static func instantiate() -> Self {
        return UIStoryboard.instantiate(viewController: self)!
    }
}

extension UIStoryboard {
    public class func instantiate<T: UIViewController>(viewController: T.Type) -> T? {
        let bundle = Bundle(for: T.self)
        let className = String(describing: T.self)
        
        guard let viewController = UIStoryboard(name: className, bundle: bundle).instantiateInitialViewController() else { return nil }
        
        return viewController as? T
    }
}
