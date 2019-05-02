//
//  UIViewAnimation.swift
//  2daLeyNewtonProyecto
//
//  Created by Noe Campos on 4/21/19.
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
    
    // Para crear el efecto de fondo gradiente
    func setFondoGradiente(colorUno: UIColor!, colorDos: UIColor!){
        
        let capaGradiante = CAGradientLayer()
        
        capaGradiante.frame = bounds
        capaGradiante.colors = [colorUno.cgColor, colorDos.cgColor]
        capaGradiante.locations = [0.0, 1.0]
        capaGradiante.startPoint = CGPoint(x: 0.0, y: 1.0)
        capaGradiante.endPoint = CGPoint(x: 0.0, y: 0.0)
        
        layer.insertSublayer(capaGradiante, at: 0)
    }
    
    // Para dar las esquinas redondeadas en un view
    func esquinasRedondas(radio: CGFloat!){
        layer.cornerRadius = radio;
        layer.masksToBounds = true;
    }

}
