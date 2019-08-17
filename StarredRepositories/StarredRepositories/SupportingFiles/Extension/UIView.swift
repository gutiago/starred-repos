//
//  UIView.swift
//  StarredRepositories
//
//  Created by Gustavo Tiago on 17/08/19.
//  Copyright © 2019 Tiago. All rights reserved.
//

import UIKit

extension UIView {
    private static let kRotationAnimationKey = "rotation.animation.key"
    
    func rotate(duration: CFTimeInterval = 1) {
        if layer.animation(forKey: UIView.kRotationAnimationKey) == nil {
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
            
            rotationAnimation.byValue = Double.pi * 2.0
            rotationAnimation.duration = duration
            rotationAnimation.repeatCount = Float.greatestFiniteMagnitude
            
            layer.add(rotationAnimation, forKey: UIView.kRotationAnimationKey)
        }
    }
    
    func stopRotating() {
        if layer.animation(forKey: UIView.kRotationAnimationKey) != nil {
            layer.removeAnimation(forKey: UIView.kRotationAnimationKey)
        }
    }
}
