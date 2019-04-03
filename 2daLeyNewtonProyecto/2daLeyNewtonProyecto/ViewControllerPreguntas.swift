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
    @IBOutlet weak var imgImage: UIImageView!
    @IBOutlet weak var btOption: UIButton!
    
    var relativeFontConstant: CGFloat = 0.04
    var errorCase: Bool!
    
    var problema: Problema!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Esconder la imagen de correcto/incorrecto
        imgImage.isHidden = true
        
        // Muestra la pregunta
        lbPregunta.isHidden = false
        
        // Se pone que no hay error
        errorCase = false
        
        // Ajustar el tamaño del texto con respecto al tamaño de la altura del label
        lbPregunta.font = lbPregunta.font.withSize(self.view.frame.height * relativeFontConstant)
        
        // Obtener un tipo de problema
        problema = Problema(tipo: Int.random(in: 0 ... 2))
        // Muestra el texto del problema
        lbPregunta.text = problema.sTexto!
        print(problema.dRespuesta)
    }
    
    
    @IBAction func comprobarRespuesta(_ sender: Any) {

        // Revisa que el usuario no este con el texto
        // escondido
        if (errorCase == false){
            
            // Esconde el label
            lbPregunta.isHidden = true
            
            // Si la respuesta es correcta...
            if (Double(tfRespuesta.text!) == problema.dRespuesta){
                
                // Asigna la imagen de una flecha azul
                imgImage.image = UIImage(named: "Correcto")
            
            // En caso de que sea incorrecta
            }else{
                // Se activa la bandera error
                errorCase = true
                
                // Asigna la imagen de una flecha azul
                imgImage.image = UIImage(named: "Incorrecta")
                
                // Cambiar texto de boton
                btOption.titleLabel?.text = "Volver a Intentar"
            }
            
            // Muestra la imagen
            imgImage.isHidden = false
        }
        
        
    }
    
    
 
    @IBAction func opcionEspecial(_ sender: Any) {
        
        if(errorCase == true){
            imgImage.isHidden = true
            lbPregunta.isHidden = false
            errorCase = false
        }
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
