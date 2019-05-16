//
//  ViewControllerSimulacion.swift
//  2daLeyNewtonProyecto
//
//  Created by Noe Campos y Mariana Villegas on 2/27/19.
//  Copyright © 2019 itesm. All rights reserved.
//
import UIKit

class ViewControllerSimulacion: UIViewController, UITextFieldDelegate {

    // Background Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var vwMiniView: UIView!
    @IBOutlet weak var lbBackGround: UILabel!
    
    // Steppers
    @IBOutlet weak var stpEmpuje: UIStepper!
    @IBOutlet weak var stpMasa: UIStepper!
    
    // Slider
    @IBOutlet weak var slCoefFric: UISlider!
    
    // Boton
    @IBOutlet weak var btRegresar: UIButton!
    
    // Imagenes
    @IBOutlet weak var imgObjeto: UIImageView!
    @IBOutlet weak var imgMonito: UIImageView!
    @IBOutlet weak var imgBack1: UIImageView!
    @IBOutlet weak var imgBack2: UIImageView!
    @IBOutlet weak var imgBack3: UIImageView!
    
    // Labels
    @IBOutlet weak var lbResultados: UILabel!
    @IBOutlet weak var lbCoeficiente: UILabel!
    
    // Textfields
    @IBOutlet weak var tfAplicada: UITextField!
    @IBOutlet weak var tfMasa: UITextField!
    
    // Arreglo de asssets
    var spritesWalk: [UIImage] = [UIImage(named: "Walk (1)")!, UIImage(named: "Walk (2)")!, UIImage(named: "Walk (3)")!, UIImage(named: "Walk (4)")!, UIImage(named: "Walk (5)")!, UIImage(named: "Walk (6)")!, UIImage(named: "Walk (7)")!, UIImage(named: "Walk (8)")!, UIImage(named: "Walk (9)")!, UIImage(named: "Walk (10)")!, UIImage(named: "Walk (11)")!, UIImage(named: "Walk (12)")!, UIImage(named: "Walk (13)")!, UIImage(named: "Walk (14)")!, UIImage(named: "Walk (15)")!]
    
    var spritesRun: [UIImage] = [UIImage(named: "Run (1)")!, UIImage(named: "Run (2)")!, UIImage(named: "Run (3)")!, UIImage(named: "Run (4)")!, UIImage(named: "Run (5)")!, UIImage(named: "Run (6)")!, UIImage(named: "Run (7)")!, UIImage(named: "Run (8)")!, UIImage(named: "Run (9)")!, UIImage(named: "Run (10)")!, UIImage(named: "Run (11)")!, UIImage(named: "Run (12)")!, UIImage(named: "Run (13)")!, UIImage(named: "Run (14)")!, UIImage(named: "Run (15)")!]
    
    var spritesIdle: [UIImage] = [UIImage(named: "Idle1")!, UIImage(named: "Idle2")!, UIImage(named: "Idle3")!, UIImage(named: "Idle4")!, UIImage(named: "Idle5")!, UIImage(named: "Idle6")!, UIImage(named: "Idle7")!, UIImage(named: "Idle8")!, UIImage(named: "Idle9")!, UIImage(named: "Idle10")!, UIImage(named: "Idle11")!, UIImage(named: "Idle12")!, UIImage(named: "Idle13")!, UIImage(named: "Idle14")!, UIImage(named: "Idle15")!]
    
    // Variables necesarias
    var iApli: Int!
    var iFric: Int!
    var iMasa: Int!
    var iFNeta: Int!
    var dAcel: Double!
    var iCoefFric: Double!
    
    // Variables para la posicion del personaje
    var iX: CGFloat!
    var iY: CGFloat!
    var iWidth: CGFloat!
    var iHeight: CGFloat!
    var iDifMax: CGFloat!
    var iDifMin: CGFloat!
    
    // Variable de animacion del personaje
    var iTipo: Int!
    
    var timer = Timer.scheduledTimer(timeInterval: 1000, target: self, selector: #selector(moverFondo), userInfo: nil, repeats: true)
    
    // Variables para el background
    var iDir: CGFloat!
    var heightB1: CGFloat!
    var widthB1: CGFloat!
    var scWidth: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Poner propiedades de los componentes
        setPropiedades()

        // Iniciar todo al cargar la pantalla
        setInicial()

        // Agregar las notificaciones del teclado
        notificacionesTeclado()
    }
    
    //Dependiendo si los newtons son positivos, negativos o 0
    //1.- El personaje aparecera ya sea en el lado derecho o izquierdo de la pantalla
    //2.-Dependiendo la fuerza aplicada el personaje empezará a empujar el objeto de en medio y cambiarán los valores de los calculos
    @IBAction func empujarObjeto(_ sender: UIStepper) {
        
        // Revisa la direccion a la que se empuja el objeto
        // De izquierda a derecha
        if (sender.value >= 0){
            
            imgMonito.frame.origin.x = imgObjeto.frame.minX - iDifMin
            imgMonito.transform = CGAffineTransform(scaleX: 1, y: 1)
            iDir = -1
            
            // De derecha a izquierda
        }else if (sender.value < 0) {
            
            imgMonito.frame.origin.x = imgObjeto.frame.minX + iDifMax
            imgMonito.transform = CGAffineTransform(scaleX: -1, y: 1)
            iDir = 1
        }
    }
    
    //Se toma el valor actual del stepper y se pone la imagen correspondiente
    @IBAction func actualizarObjeto(_ sender: UIStepper) {
        
        // Revisa el valor de la masa y asigna la imagen correspondiente
        if Int(sender.value) == 0 {
            
            imgObjeto.image = nil
            
        }else if Int(sender.value) > 0 && Int(sender.value) < 49{
            
            imgObjeto.image = UIImage(named: "stove")
        
        }else if Int(sender.value) > 50 && Int(sender.value) < 100{
            
            imgObjeto.image = UIImage(named: "refrigerator")
        
        }else if Int(sender.value) > 101 && Int(sender.value) < 200{
            
            imgObjeto.image = UIImage(named: "wardrobe")
        }
    }
    
    // Metodo general para actualizar datos de la simulación
    @IBAction func simulacionActiva(_ sender: Any){
        
        // Mientras que haya algo que empujar...
        if (Int(stpMasa.value) != 0){
            // Se realizan los calculos con los nuevos datos
            realizarCalculo()
            // Se muestran los datos
            actualizarValores()
            
            // Si no hay algo que empujar
        }else{
            // Todo se pone en 0s
            setCeros()
            
            // Se actualizan los labels
            actualizarValores()
        }
        
        // Actualizar la animacion del personaje
        animacionPersonaje()
    }
    
    // Revisa si se edito el texto
    @IBAction func escribirValores(_ sender: UITextField) {
        
        // Revisa si se hay valor en el de Empuje
        if let iApli = Int(tfAplicada.text!){
            // Se lo asigna al Stepper
            stpEmpuje.value = Double(iApli)

        // Si no
        }else{
            // Pone en 0 el empuje
            iApli = 0
            // Lo asigna al stepper
            stpEmpuje.value = Double(iApli)
        }

        // Revisa si hay valor en la Masa
        if let iMasa = Int(tfMasa.text!){
            // Se lo asigna al Stepper
            stpMasa.value = Double(iMasa)

        // En caso contrario
        }else{
            // Lo asigna en 0
            iMasa = 0
            stpMasa.value = Double(iMasa)
        }
        
        // Revisa direccion
        empujarObjeto(stpEmpuje)
        
        // Revisar masa del objeto
        actualizarObjeto(stpMasa)
        
        // Calcular con los nuevos valores
        simulacionActiva(stpEmpuje)
        
    }
    
    // Para poner en 0 los labels e iniciar la animación
    func setInicial(){
        
        // No hay masa, no hay objeto
        imgObjeto.image = nil
        
        // Valores necesarios para la animacion del fondo
        iDir = 0
        heightB1 = imgBack1.frame.height
        widthB1 = imgBack1.frame.width
        scWidth = UIScreen.main.bounds.width
        
        // Diferencias en las posiciones del objeto y el monito
        iDifMax = imgObjeto.frame.maxX - imgMonito.frame.maxX
        iDifMin = imgObjeto.frame.minX - imgMonito.frame.minX
        iX = imgMonito.frame.origin.x
        
        // Se inicializan los valores en 0
        setCeros()
        // Se imprimen los 0s
        actualizarValores()
        
        // Se asigna la animacion inicial
        imgMonito.animationImages = spritesIdle
        // Se guarda la bandera de la animacion
        iTipo = 0
        // Se inidica la velovidad de la animacion
        imgMonito.animationDuration = 0.5
        // Inicia la animacion
        imgMonito.startAnimating()
    }
    
    // Para que los valores iniciales sean 0
    func setCeros(){
        iFric = 0
        iMasa = 0
        dAcel = 0.0
        iFNeta = 0
        
        // Asigna el valor del empuje
        iApli = Int(stpEmpuje.value)
        
        // Valor del coeficiente
        iCoefFric = Double(slCoefFric.value)
        iCoefFric = Double(round(100 * iCoefFric) / 100)
        lbCoeficiente.text = String(slCoefFric.value)
    }
    
    // MARK: - Calculos
    
    // Obtiene los valores de los slider y realiza el calculo
    func realizarCalculo(){
        // Obtiene los valroes de Empuje y la Masa
        iApli = Int(stpEmpuje.value)
        iMasa = Int(stpMasa.value)
        iCoefFric = Double(slCoefFric.value)
        
        // Se calcula la fuerza de fricción
        let tFric = iCoefFric * 9.81 * Double(iMasa)
        
        // Revisa si es mayor la fuerza de Empuje
        if (abs(iApli) >= Int(tFric)){
            // Se guarda el valor de fricción
            iFric =  Int(tFric)
            
            // Se calcula la fuerza Normal
            if(iApli > 0){
                iFNeta = iApli - iFric
                iFric = iFric * (-1)
            }else{
                iFNeta = iApli + iFric
            }
            
            // En caso de no ser mayor la fuerza de empuje
        }else{
            // Se igualan las fuerzas de fricción y de empuje
            iFric = Int(stpEmpuje.value) * (-1)
            // Fuerza neta igual a 0
            iFNeta = 0
        }
        
        // Se calcula la Aceleración
        dAcel = Double(iFNeta) / Double(iMasa)
    }
    
    // Se actualizan los labels correspondientes
    func actualizarValores(){
        // Se actualiza los textfields
        tfAplicada.text = String(iApli)
        tfMasa.text = String(iMasa)
        
        dAcel = Double(round(100 * dAcel) / 100)
        iCoefFric = Double(round(100 * iCoefFric) / 100)
        
        // Se actualizan los labels
        lbCoeficiente.text = String(iCoefFric)
        
        lbResultados.text = "Fuerza Aplicada: " + String(iApli) + "N \nFuerza de Fricción: " + String(iFric) + "N \nFuerza Neta: " + String(iFNeta) + "N \nAceleración: " + String(dAcel) + "m/s"
    }
    
    // Funcion para mover el fondo
     @objc func moverFondo(){
        if iDir == -1{
            imgBack1.frame.origin.x  += iDir
            imgBack2.frame.origin.x += iDir
            imgBack3.frame.origin.x += iDir
            
            if imgBack1.frame.maxX == -widthB1{
                imgBack1.frame.origin.x = imgBack3.frame.maxX
            }
            if imgBack2.frame.maxX == -widthB1{
                imgBack2.frame.origin.x = imgBack1.frame.maxX
            }
            if imgBack3.frame.maxX == -widthB1{
                imgBack3.frame.origin.x = imgBack2.frame.maxX
            }
            
        }else if iDir == 1{

            imgBack1.frame.origin.x  += iDir
            imgBack2.frame.origin.x  += iDir
            imgBack3.frame.origin.x += iDir
            
            if imgBack1.frame.minX == scWidth + widthB1{
                imgBack1.frame.origin.x = imgBack2.frame.minX - widthB1
            }
            if imgBack2.frame.minX == scWidth + widthB1{
                imgBack2.frame.origin.x = imgBack3.frame.minX - widthB1
            }
            if imgBack3.frame.minX == scWidth {
                imgBack3.frame.origin.x = imgBack1.frame.minX - widthB1
            }
        }
    }
    
    func crearTimer(interval: Double!){
        timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(moverFondo), userInfo: nil, repeats: true)
    }
    
    // MARK: - Animacion
    func animacionPersonaje(){
        
        // Si no hay aceleracion
        if(abs(dAcel) == 0.0 && iTipo != 0){
            // Se asignan los sprites de estar detenido
            imgMonito.animationImages = spritesIdle
            iTipo = 0
            imgMonito.startAnimating()
            timer.invalidate()
            
            // Para animar que camina
        }else if (abs(dAcel) > 0.0 && abs(dAcel) <= 7.0 && iTipo != 1) {
            // Se guardan asignan los nuevos sprites
            imgMonito.animationImages = spritesWalk
            iTipo = 1
            imgMonito.startAnimating()
            timer.invalidate()
            crearTimer(interval: 0.09)
            // O que esta corriendo
        }else if (abs(dAcel) > 7.0 && iTipo != 2) {
            // Se asignan los sprites de correr
            imgMonito.animationImages = spritesRun
            iTipo = 2
            imgMonito.startAnimating()
            timer.invalidate()
            crearTimer(interval: 0.01)
        }
    }

    // MARK: - Diseño
    func setPropiedades(){
        
        // Poner el fondo con gradiente
        view.setFondoGradiente(colorUno: Colores.Sky, colorDos: Colores.Purple)
        vwMiniView.backgroundColor = UIColor.clear
        lbBackGround.backgroundColor = UIColor.clear

        // Redondear los labels

        lbResultados.esquinasRedondas(radio: 3.0)

        // Poner fondo en los labels
        lbResultados.backgroundColor = UIColor(white: 255.0, alpha: 0.20)

        // Redondear esquinas de textfields
        tfAplicada.esquinasRedondas(radio: 15.0)
        tfMasa.esquinasRedondas(radio: 15.0)
        
        // Border de los textfields
        tfAplicada.layer.borderWidth = 1.0
        tfMasa.layer.borderWidth = 1.0
        
        // Color del borde
        tfAplicada.layer.borderColor = UIColor(white: 255.0, alpha: 0.30).cgColor
        tfMasa.layer.borderColor = UIColor(white: 255.0, alpha: 0.30).cgColor

        // Color y opacidad del textfield
        tfAplicada.backgroundColor = Colores.WhiteBackground
        tfMasa.backgroundColor = Colores.WhiteBackground
        
        // Color, forma y opacidad del boton
        btRegresar.backgroundColor = Colores.ObscureBlue
        btRegresar.esquinasRedondas(radio: 5.0)
        
        // Set the background of the steppers
        stpEmpuje.backgroundColor = Colores.ObscureBlue
        stpMasa.backgroundColor = Colores.ObscureBlue
        
        // Set los colores del slider
        slCoefFric.minimumTrackTintColor = Colores.ObscureBlueAlpha
        slCoefFric.maximumTrackTintColor = Colores.ObscureBlue
        slCoefFric.thumbTintColor = Colores.ObscureBlueAlpha
        
        // Set fondo de imagen
        imgBack1.backgroundColor = UIColor.clear
    }
    
    // MARK: - Teclado

        // Para subir el view cuando aparezca el teclado
    @IBAction func keyboardWasShown(aNotification : NSNotification) {
        
        let kbSize = (aNotification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue.size
        
        let contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = contentInset
        
        // Si el teclado oculta el textfieldo, sube el view
        var aRect: CGRect = scrollView.frame
        aRect.size.height -= kbSize.height
        
        if !aRect.contains(tfAplicada.frame.origin) {
            scrollView.scrollRectToVisible(tfAplicada.frame, animated: true)
        
        }else if !aRect.contains(tfMasa.frame.origin) {
            scrollView.scrollRectToVisible(tfMasa.frame, animated: true)
        }
    }
    
    // Para bajar la view a la normalidad
    @IBAction func keyboardWillBeHidden(aNotification : NSNotification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }

    // Paraa registrar las notificaciones y acciones
    func notificacionesTeclado() {
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWasShown(aNotification:)),
                                               name:UIResponder.keyboardWillShowNotification, object:nil)
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillBeHidden(aNotification:)),
                                               name:UIResponder.keyboardWillHideNotification, object:nil)
    }

    // Para quitar el teclado de la pantalla
    @IBAction func quitarTeclado(){
        view.endEditing(true);
    }
}
