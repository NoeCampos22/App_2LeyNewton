//
//  ViewControllerPreguntas.swift
//  2daLeyNewtonProyecto
//
//  Created by Alumno on 2/27/19.
//  Copyright © 2019 itesm. All rights reserved.
//

import UIKit

class ViewControllerPreguntas: UIViewController {
    
    
    @IBOutlet weak var lbPregunta: UILabel!
    @IBOutlet weak var tfRespuesta: UITextField!
    
    var problema: Problema!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        problema = Problema(tipo: Int.random(in: 0 ... 2))
        lbPregunta.text = problema.sTexto!
        print(problema.dFNeta)
        print(problema.dAceleracion)
    }
    
    
    @IBAction func comprobarRespuesta(_ sender: Any) {
        if (Double(tfRespuesta.text!) == problema.dRespuesta){
            print("Surve")
        }
    }
    
    
 
    @IBAction func verFormula(_ sender: Any) {
    }
    
    
    
    @IBAction func siguienteProblema(_ sender: Any) {
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
