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
    
    var relativeFontConstant: CGFloat = 0.03
    
    var problema: Problema!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lbPregunta.font = lbPregunta.font.withSize(self.view.frame.height * relativeFontConstant)
        
        problema = Problema(tipo: Int.random(in: 0 ... 2))
        lbPregunta.text = problema.sTexto!
        print(problema.dRespuesta)
    }
    
    
    @IBAction func comprobarRespuesta(_ sender: Any) {
        if (Double(tfRespuesta.text!) == problema.dRespuesta){
            lbPregunta.text = "Correcto!"
        }
    }
    
    
 
    @IBAction func verFormula(_ sender: Any) {
    }
    
    
    
    @IBAction func siguienteProblema(_ sender: Any) {
        viewDidLoad()
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
