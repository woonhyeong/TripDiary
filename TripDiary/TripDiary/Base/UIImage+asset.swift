//
//  UIImage+asset.swift
//  TripDiary
//
//  Created by 이운형 on 2021/01/12.
//

import UIKit

extension UIImage {
    enum AssetIdentifier: String {
        case leftBackButton
    }
    
    convenience init?(assetIdentifier: AssetIdentifier?) {
        guard let assetIdentifier = assetIdentifier else { return nil }
        
        self.init(named: assetIdentifier.rawValue, in: TripDiaryBase.bundle, compatibleWith: nil)
    }
}
