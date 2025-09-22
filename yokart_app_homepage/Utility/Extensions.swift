//
//  Extensions.swift
//  yokart_app_homepage
//
//  Created by User on 18/09/25.
//

import UIKit

extension UIView {

    // Apply corners radius
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(
            roundedRect: self.bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        self.layer.mask = shapeLayer
    }
    
    // apply light shadow and border
    func applyLightShadowAndBorder(
         shadowColor: UIColor = .black,
         shadowOpacity: Float = 0.05,
         shadowOffset: CGSize = CGSize(width: 0, height: 2),
         shadowRadius: CGFloat = 4,
         borderColor: UIColor = UIColor.lightGray.withAlphaComponent(0.3),
         borderWidth: CGFloat = 0.5,
         cornerRadius: CGFloat = 8
     ) {
         // Shadow
         self.layer.shadowColor = shadowColor.cgColor
         self.layer.shadowOpacity = shadowOpacity
         self.layer.shadowOffset = shadowOffset
         self.layer.shadowRadius = shadowRadius
         self.layer.masksToBounds = false

         // Border
         self.layer.borderColor = borderColor.cgColor
         self.layer.borderWidth = borderWidth

         // Corner Radius
         self.layer.cornerRadius = cornerRadius
     }
}
