//
//  UIViewAnimation.swift
//  2daLeyNewtonProyecto
//
//  Created by user152643 on 4/21/19.
//  Copyright © 2019 itesm. All rights reserved.
//

import UIKit
import Foundation

extension UIView {

    // Funcion para efecto de FadeIn
    func fadeIn(_ duration: TimeInterval = 0.25, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: completion)
    }
    
    // Funcion de animacion para hacer el efecto de FadeOut
    func fadeOut(_ duration: TimeInterval = 0.25, delay: TimeInterval = 0.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 0.0
        }, completion: completion)
    }
}
