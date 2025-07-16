//
//  UIImageUtil.swift
//  AppPapple
//
//  Created by Christian Morante on 16/07/25.
//

import UIKit
extension UIImage {
    
    func resizedImage(named: String, size: CGSize) -> UIImage? {
        guard let image = UIImage(named: named) else { return nil }

        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        image.draw(in: CGRect(origin: .zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return resizedImage
    }

}
