//
//  Color+named.swift
//  TripDiary
//
//  Created by 이운형 on 2021/01/12.
//

import UIKit

extension UIColor {
    public class var mainGreen: UIColor { named("mainGreen")}
    
    fileprivate static func named(_ colorName: String) -> UIColor {
        return UIColor(named: colorName, in: TripDiaryBase.bundle, compatibleWith: nil)!
    }
}
