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
    @IBOutlet weak var btFormula: UIButton!
    
    // Outlet del textfield
    @IBOutlet weak var tfRespuesta: UITextField!
    @IBOutlet weak var imgImage: UIImageView!
    
    // Variables para los tamaños de las font
    var FontPregunta: CGFloat!
    var FontLabel: CGFloat!
    
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
            
                // Si la respuesta es correcta...
                if (Double(tfRespuesta.text!) == problema.dRespuesta){
                    
                    // Asigna la imagen de una flecha azul
                    imgImage.image = UIImage(named: "Correcto")
                    
                    // Se oculta la pregunta
                    self.lbPregunta.fadeOut(completion:{
                        (finished: Bool) -> Void in
                        // Se muestra la formula
                        self.imgImage.fadeIn()
                        // Esperar dos segundos
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                            // Ocultar la imagen
                            self.imgImage.fadeOut()
                            self.viewDidLoad()
                        }
                    })
                // En caso de que sea incorrecta
                }else{
                    
                    // Asigna la imagen de una flecha azul
                    imgImage.image = UIImage(named: "Incorrecta")
                    
                    // Se oculta la pregunta
                    self.lbPregunta.fadeOut(completion:{
                        (finished: Bool) -> Void in
                        // Se muestra la formula
                        self.imgImage.fadeIn()
                        
                        // Esperar 2 segundos
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            // Esconder la imagen
                            self.imgImage.fadeOut()
                            // Mostrar la pregunta
                            self.lbPregunta.fadeIn()
                            // Borrar contenido del textfield
                            self.tfRespuesta.text = ""
                        }
                    })
        }
    }
    
    // Cambiar de problema
    @IBAction func siguienteProblema(_ sender: Any) {
            // Mostrar otro problema
            viewDidLoad()
    }
    
    // Boton para mostrar la imagen de la formula correspondiente
    @IBAction func mostrarFormulas(_ sender: Any) {
        // Se guarda la imagen de la formula
        imgImage.image = problema.imgFormula!
        
        // Si la pregunta se muestra
        if(lbPregunta.alpha == 1.0){
            // Se oculta y
            self.lbPregunta.fadeOut(completion:{
                (finished: Bool) -> Void in
                // Se muestra la formula
                self.imgImage.fadeIn()
            })
        // Si la formula es la que se muestra...
        }else{
            // Se oculta y
            self.imgImage.fadeOut(completion:{
                (finished: Bool) -> Void in
                // Se muestra la pregunta
                self.lbPregunta.fadeIn()
            })
        }
    }
    
    // Para quitar el teclado de la pantalla
    @IBAction func quitarTeclado(){
        view.endEditing(true);
    }
    
    
    // MARK: - Set Componentes
    
    // Funcion para mostrar lo necesario del problema
    func setInicial(){
        // Esconder la imagen de correcto/incorrecto
        imgImage.alpha = 0.0
        
        // Esconder la pregunta
        lbPregunta.alpha = 0
        
        // Para luego mostrarla
        lbPregunta.fadeIn()
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
