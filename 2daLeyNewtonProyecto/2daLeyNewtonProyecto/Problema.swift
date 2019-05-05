//
//  Problema.swift
//  2daLeyNewtonProyecto
//
//  Created by Noé Campos on 3/27/19.
//  Copyright © 2019 itesm. All rights reserved.
//

import UIKit

class Problema: NSObject {
    
    var sTexto: String!
    var dMasa: Int!
    var dEmpuje: Double!
    var dFriccion: Double!
    var dFNeta: Double!
    var dAceleracion: Double!
    var dRespuesta: Double!
    var imgFormula: UIImage!
    
    init(tipo: Int) {
        super.init()
        
        // Obtener los valores
        setValores()

        // Dependiendo el tipo de problema, se pone el texto
        definirProblema(tipo: tipo)
        
        // Se sustituyen los tags
        sustituirTags()
    }
    
    // Funcion para generar los valores que se usaran en el problema
    func setValores(){
        // Se genera una aceleracion
        if(Int.random(in: 0...2) == 0){
            dAceleracion = Double.random(in: 2.0 ..< 9.0)
        }else{
            dAceleracion = Double.random(in: -9.0 ..< -2.0)
        }
        // Se redondea
        dAceleracion = Double(round( 100 * dAceleracion ) / 100)
        
        // Se obtiene una masa
        dMasa = Int.random(in: 40 ..< 200)
        
        // Se calcula y redonde la fuerza neta
        dFNeta = Double(dMasa) * dAceleracion
        dFNeta = Double(round( 100 * dFNeta) / 100)
        
        // Se genera y redondea la friccion
        dFriccion = Double.random(in: 1 ..< 100)
        dFriccion = Double(round( 100 * dFriccion) / 100)
        
        // Se calcula la fuerza de empuje
        if(dFNeta < 0){
            dEmpuje = dFNeta - dFriccion
        }else{
            dEmpuje = dFNeta + dFriccion
        }
        dEmpuje = Double(round( 100 * dEmpuje) / 100)
        
    }
    
    // Para establecer el texto, formula y respuesta basandose en el tipo de problema
    func definirProblema(tipo: Int){
        switch tipo {
        case 1:
            sTexto = "Un objecto con una masa de <m>kg es empujado con una fuerza de <e>N y la fuerza de friccion es de <f>N. Calcula la aceleración."
            imgFormula = UIImage(named: "Formula_Aceleracion")
            dRespuesta = dAceleracion
            
        case 2:
            sTexto = "Calcula la fuerza neta que se le aplica a un objeto con una masa de <m>kg y una aceleración de <a>m/s"
            imgFormula = UIImage(named: "Formula_Fuerza")
            dRespuesta = Double(dFNeta)
            
        default:
            sTexto = "Calcula la masa de un objeto al que se le aplica una fuerza neta de <f> con una aceleración de <a>m/s"
            imgFormula = UIImage(named: "Formula_Masa")
            dRespuesta = Double(dMasa)
        }
    }
    
    // Sustituir los tags por los valores
    func sustituirTags() {
        // Quitar las posibles tags del texto y poner los valores correspondientes
        sTexto = sTexto.replacingOccurrences(of: "<m>", with: String(dMasa))
        sTexto = sTexto.replacingOccurrences(of: "<e>", with: String(dEmpuje))
        sTexto = sTexto.replacingOccurrences(of: "<f>", with: String(dFriccion))
        sTexto = sTexto.replacingOccurrences(of: "<a>", with: String(dAceleracion))
    }
    
}
