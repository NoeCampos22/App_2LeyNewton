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
    
    @IBOutlet weak var btOption: UIButton!
    @IBOutlet weak var btReintentar: UIButton!
    @IBOutlet weak var btFormula: UIButton!
    
    
    @IBOutlet weak var tfRespuesta: UITextField!
    @IBOutlet weak var imgImage: UIImageView!
    
    var relativeFontConstant: CGFloat = 0.04
    var errorCase: Bool!
    var iTipo: Int!
    
    var problema: Problema!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Esconder la imagen de correcto/incorrecto
        imgImage.isHidden = true
        
        // Muestra la pregunta
        lbPregunta.isHidden = false
        
        // Se pone que no hay error
        errorCase = false
        
        // Esconder el boton de reintentar
        btReintentar.isHidden = true
        
        // Mostrar boton
        btFormula.isHidden = false
        
        // Ajustar el tamaño del texto con respecto al tamaño de la altura del label
        lbPregunta.font = lbPregunta.font.withSize(self.view.frame.height * relativeFontConstant)
        
        // Obtener el tipo de problema
        iTipo = Int.random(in: 0 ... 2)
        
        // Obtener un tipo de problema
        problema = Problema(tipo: iTipo)
        // Muestra el texto del problema
        lbPregunta.text = problema.sTexto!
        print(problema.dRespuesta)
    }
    
    
    // Revisar que la respuesa escrita sea correcta
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
                
                //
                btReintentar.isHidden = false
                
                btFormula.isHidden = true
            }
            
            // Muestra la imagen
            imgImage.isHidden = false
        }
    }
    
    
    // Para volver a mostrar el problema y reintentar solucionarlo
    @IBAction func reintentar(_ sender: Any) {
            imgImage.isHidden = true    // Esconder imagen
            lbPregunta.isHidden = false // Mostrar texto
            btReintentar.isHidden = true// Esconder boton
            btFormula.isHidden = false  // Mostrar boton
            errorCase = false           // Quitar error
    }
    
    
    
    // Cambiar de problema
    @IBAction func siguienteProblema(_ sender: Any) {
        // Mientras que no este en zona de error
        if(!errorCase){
            // Mostrar otro problema
            viewDidLoad()
        }
    }
    
    // Boton para mostrar la imagen de la formula correspondiente
    @IBAction func mostrarFormulas(_ sender: Any) {
        lbPregunta.isHidden = !lbPregunta.isHidden
        imgImage.image = problema.imgFormula
        imgImage.isHidden = !imgImage.isHidden
    }
    
    // Para quitar el teclado de la pantalla
    @IBAction func quitarTeclado(){
        view.endEditing(true);
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
