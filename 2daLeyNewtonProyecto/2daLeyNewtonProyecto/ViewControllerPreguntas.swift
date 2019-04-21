//
//  ViewControllerPreguntas.swift
//  2daLeyNewtonProyecto
//
//  Created by Alumno on 2/27/19.
//  Copyright © 2019 itesm. All rights reserved.
//

import UIKit

class ViewControllerPreguntas: UIViewController {
    
    // Outlets de labels necesarios
    @IBOutlet weak var lbPregunta: UILabel!
    @IBOutlet weak var lbTitulo: UILabel!
    @IBOutlet weak var lbIngresa: UILabel!
    
    // Outlets de los botones
    @IBOutlet weak var btOption: UIButton!
    @IBOutlet weak var btReintentar: UIButton!
    @IBOutlet weak var btFormula: UIButton!
    
    // Outlet del textfield
    @IBOutlet weak var tfRespuesta: UITextField!
    @IBOutlet weak var imgImage: UIImageView!
    
    // Variables para los tamaños de las font
    var FontPregunta: CGFloat!
    var FontLabel: CGFloat!
    
    // Para ver si ya cometio un error
    var errorCase: Bool!
    
    // Objeto tipo problema
    var problema: Problema!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Ajustar font de los labels
        ajustarFontSize()
        
        // Mostrar/Ocultar componentes
        setInicial()
        
        // Seleccionar tipo de problema
        selecProblema()
        
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
                
                // Mostrar boton de reintentar
                btReintentar.isHidden = false
                
                // Ocultar boton de Formula
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
    
    
    // MARK: - Set Componentes
    
    // Funcion para mostrar lo necesario del problema
    func setInicial(){
        // Esconder la imagen de correcto/incorrecto
        imgImage.isHidden = true
        
        // Muestra la pregunta
        lbPregunta.isHidden = false
        
        // Esconder el boton de reintentar
        btReintentar.isHidden = true
        
        // Mostrar boton
        btFormula.isHidden = false
        
        // Se pone que no hay error
        errorCase = false
    }
    
    
    // MARK: - Ajuste de Fonts
    
    // Función para ajustar el FontSize dependiendo del tamaño de la pantalla
    func ajustarFontSize(){
        
        // Calcular el tamaño de font para el problema
        FontPregunta = (self.view.frame.height * 0.04) / 896.0
        
        // Calcular el tamaño de font para los labels
        FontLabel = (self.view.frame.width * 0.07) / 414.0
        
        // Ajustar el tamaño del texto con respecto al tamaño de la altura del label
        lbPregunta.font = lbPregunta.font.withSize(self.view.frame.height * FontPregunta)
        
        // Ajustar font size del label
        lbTitulo.font = lbTitulo.font.withSize(self.view.frame.width * FontLabel)
        
        // Ajustar font size del label
        lbIngresa.font = lbIngresa.font.withSize(self.view.frame.width * FontLabel)
    }
    
    
    // MARK: - Problema
    
    // Para elegir un problema y mostrarlo
    func selecProblema(){
        
        // Obtener un tipo de problema
        problema = Problema(tipo: Int.random(in: 0 ... 2))
        
        // Muestra el texto del problema
        lbPregunta.text = problema.sTexto!
        
        print(problema.dRespuesta)
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
