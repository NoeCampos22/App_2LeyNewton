//
//  Problema.swift
//  2daLeyNewtonProyecto
//
//  Created by Alumno on 3/27/19.
//  Copyright © 2019 itesm. All rights reserved.
//

import UIKit

class Problema: NSObject {
    
    var sTexto: String!
    var dMasa: Int!
    var dEmpuje: Int!
    var dFriccion: Int!
    var dFNeta: Int!
    var dAceleracion: Double!
    var dRespuesta: Double!
    var imgFormula: UIImage!
    
    init(tipo: Int) {
        super.init()
        
        dMasa = Int.random(in: 40 ..< 380)
        dEmpuje = Int.random(in: -400 ..< 400)
        dFriccion = Int.random(in: 0 ..< 188)
        
        calcularFuerzaneta()
        
        dAceleracion = Double(dFNeta) / Double(dMasa)
        dAceleracion = Double(round( 1000 * dAceleracion ) / 1000)
        
        definirProblema(tipo: tipo)
        
        sustituirTags()
    }
    
    func definirProblema(tipo: Int){
        switch tipo {
        case 1:
            sTexto = "Un objecto con una masa de <m>kg es empujado hacia la derecha con una fuerza de <e>N, mientras que la fuerza de friccion es de <f>N. Calcula la aceleración."
            imgFormula = UIImage(named: "Formula_Aceleracion")
            dRespuesta = dAceleracion
            
        case 2:
            sTexto = "Calcula la fuerza neta que se le aplica a un objeto con una masa de <m>kg y con una aceleración de <a>m/s"
            imgFormula = UIImage(named: "Formula_Fuerza")
            dRespuesta = Double(dFNeta)
            
        default:
            sTexto = "Calcula la masa de un objeto al que se le aplica una fuerza neta de <f> con una aceleración de <a>m/s"
            imgFormula = UIImage(named: "Formula_Masa")
            dRespuesta = Double(dMasa)
        }
    }
    
    func calcularFuerzaneta() {
        // Es un if para que la fuerza de rozamiento
        // siempre vaya contrario a la de empuje
        if (self.dEmpuje < 0) {
            dFNeta = dEmpuje + dFriccion
        }else{
            dFNeta = dEmpuje - dFriccion
        }
    }
    
    func sustituirTags() {
        // Quitar las posibles tags del texto y poner los valores correspondientes
        sTexto = sTexto.replacingOccurrences(of: "<m>", with: String(dMasa))
        sTexto = sTexto.replacingOccurrences(of: "<e>", with: String(dEmpuje))
        sTexto = sTexto.replacingOccurrences(of: "<f>", with: String(dFriccion))
        sTexto = sTexto.replacingOccurrences(of: "<a>", with: String(dAceleracion))
    }
    
}
