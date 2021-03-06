//
//  ViewControllerPreguntas.swift
//  2daLeyNewtonProyecto
//
//  Created by Noe Campos on 2/27/19.
//  Copyright © 2019 itesm. All rights reserved.
//

import UIKit

class ViewControllerPreguntas: UIViewController, UITextFieldDelegate{
    
    // Background Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var vwMiniView: UIView!
    @IBOutlet weak var lbBackGround: UILabel!
    
    // Outlets de labels necesarios
    @IBOutlet weak var lbPregunta: UILabel!
    @IBOutlet weak var lbTitulo: UILabel!
    @IBOutlet weak var lbIngresa: UILabel!
    
    // Outlets de los botones
    @IBOutlet weak var btRevisar: UIButton!
    @IBOutlet weak var btFormula: UIButton!
    @IBOutlet weak var btSiguiente: UIButton!
    @IBOutlet weak var btRegresar: UIButton!
    
    // Outlet del textfield
    @IBOutlet weak var tfRespuesta: UITextField!
    @IBOutlet weak var imgImage: UIImageView!
    
    // Variables para los tamaños de las font
    var FontPregunta: CGFloat!
    var FontLabel: CGFloat!
    var FontTitulo: CGFloat!
    
    // Objeto tipo problema
    var problema: Problema!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Poner propiedades de diseño
        setPropiedades()
        
        // Mostrar/Ocultar componentes
        setInicial()
        
        // Seleccionar tipo de problema
        selecProblema()
        
        // Agregar las notificaciones del teclado
        notificacionesTeclado()
    }
    
    // MARK: - IBActions

    // Revisar que la respuesa escrita sea correcta
    @IBAction func comprobarRespuesta(_ sender: Any) {
        
        // Si la respuesta es correcta...
        if (Double(tfRespuesta.text!) == problema.dRespuesta){
            // Asigna la imagen de una flecha azul
            imgImage.image = UIImage(named: "Correct")
                    
            // Se oculta la pregunta
            self.lbPregunta.fadeOut(completion:{
                (finished: Bool) -> Void in
                
                // Se muestra la formula
                self.imgImage.fadeIn()
                // Esperar dos segundos
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                    // Borrar contenido del textfield
                    self.tfRespuesta.text = ""
                    
                    // Ocultar la imagen
                    self.imgImage.fadeOut()
                    
                    // Mostrar/Ocultar componentes
                    self.setInicial()
                    
                    // Seleccionar tipo de problema
                    self.selecProblema()
                }
            })
        
        // En caso de que sea incorrecta
        }else{
            // Asigna la imagen de una flecha azul
            imgImage.image = UIImage(named: "Wrong")
                    
            // Se oculta la pregunta
            self.lbPregunta.fadeOut(completion:{
            (finished: Bool) -> Void in
            // Se muestra la formula
            self.imgImage.fadeIn()
                        
            // Esperar 2 segundos
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
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
        // Mostrar/Ocultar componentes
        setInicial()
        
        // Seleccionar tipo de problema
        selecProblema()
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
    
    // Paraa registrar las notificaciones y acciones
    func notificacionesTeclado() {
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWasShown(aNotification:)),
                                               name:UIResponder.keyboardWillShowNotification, object:nil)
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillBeHidden(aNotification:)),
                                               name:UIResponder.keyboardWillHideNotification, object:nil)
    }
    
    // Para subir el view cuando aparezca el teclado
    @IBAction func keyboardWasShown(aNotification : NSNotification) {
        
        let kbSize = (aNotification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue.size
        
        let contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = contentInset
        
        // Si el teclado oculta el textfieldo, sube el view
        var aRect: CGRect = scrollView.frame
        aRect.size.height -= kbSize.height
        if !aRect.contains(tfRespuesta.frame.origin) {
            scrollView.scrollRectToVisible(tfRespuesta.frame, animated: true)
        }
    }
    
    // Para bajar la view a la normalidad
    @IBAction func keyboardWillBeHidden(aNotification : NSNotification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
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
    
    // MARK: - Diseño
    
    // Para el diseño de la pantalla
    func setPropiedades(){
        
        // Poner el fondo con gradiente
        view.setFondoGradiente(colorUno: Colores.Sky, colorDos: Colores.Purple)
        vwMiniView.backgroundColor = UIColor.clear
        lbBackGround.backgroundColor = UIColor.clear
        
        // Redondear, dar color y opacidad al label
        lbPregunta.esquinasRedondas(radio: 30.0)
        lbPregunta.backgroundColor = Colores.MiniRed
        
        // Redondear imagen
        imgImage.esquinasRedondas(radio: 57.0)
        
        // Redondear, dar color y opacidad al textfield
        tfRespuesta.esquinasRedondas(radio: 15.0)
        tfRespuesta.layer.borderWidth = 1.0
        tfRespuesta.layer.borderColor = UIColor(white: 255.0, alpha: 0.30).cgColor
        tfRespuesta.backgroundColor = Colores.WhiteBackground
        
        // Dar color y opacidad a los botones
        btRevisar.backgroundColor = Colores.ObscureBlue
        btFormula.backgroundColor = Colores.ObscureBlue
        btSiguiente.backgroundColor = Colores.ObscureBlue
        btRegresar.backgroundColor = Colores.ObscureBlue
        
        // Redondear los botones
        btRevisar.esquinasRedondas(radio: 20)
        btFormula.esquinasRedondas(radio: 20)
        btRegresar.esquinasRedondas(radio: 20)
        btSiguiente.esquinasRedondas(radio: 20)
        
        // Size del font
        btRegresar.fontSize()
        btSiguiente.fontSize()
        btRevisar.fontSize()
        btFormula.fontSize()
    }
    
    // Que orientacion soporta
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    // Para que no rote la pantalla
    override var shouldAutorotate: Bool {
        return false
    }
}
