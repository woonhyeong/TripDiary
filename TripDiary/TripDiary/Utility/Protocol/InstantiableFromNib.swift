//
//  InstantiableFromNib.swift
//  TripDiary
//
//  Created by 이운형 on 2021/01/13.
//

import UIKit

// MARK: - Reusable
public protocol Reusable: class {
}

extension Reusable where Self: UIView {
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
}

// MARK: - InstantiableFromnib
public protocol InstantiableFromNib: Reusable {
    static var instanceFromNib: Self? { get }
}

extension InstantiableFromNib where Self: UIView {
    public static var instanceFromNib: Self? {
        let bundle = Bundle(for: Self.self)
        let nib = UINib(nibName: self.reuseIdentifier, bundle: bundle)
        
        return nib.instantiate(withOwner: nil, options: nil).first as? Self
    }
}
