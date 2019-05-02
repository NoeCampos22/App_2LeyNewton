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
    @IBOutlet weak var lbAceleracion: UILabel!
    @IBOutlet weak var lbFuerzaNeta: UILabel!
    @IBOutlet weak var lbFuerzaFriccion: UILabel!
    
    // Textfields
    @IBOutlet weak var tfEmpuje: UITextField!
    @IBOutlet weak var tfMasa: UITextField!
    
    // Arreglo de asssets
    var spritesWalk: [UIImage] = [UIImage(named: "Walk (1)")!, UIImage(named: "Walk (2)")!, UIImage(named: "Walk (3)")!, UIImage(named: "Walk (4)")!, UIImage(named: "Walk (5)")!, UIImage(named: "Walk (6)")!, UIImage(named: "Walk (7)")!, UIImage(named: "Walk (8)")!, UIImage(named: "Walk (9)")!, UIImage(named: "Walk (10)")!, UIImage(named: "Walk (11)")!, UIImage(named: "Walk (12)")!, UIImage(named: "Walk (13)")!, UIImage(named: "Walk (14)")!, UIImage(named: "Walk (15)")!]
    
    var spritesRun: [UIImage] = [UIImage(named: "Run (1)")!, UIImage(named: "Run (2)")!, UIImage(named: "Run (3)")!, UIImage(named: "Run (4)")!, UIImage(named: "Run (5)")!, UIImage(named: "Run (6)")!, UIImage(named: "Run (7)")!, UIImage(named: "Run (8)")!, UIImage(named: "Run (9)")!, UIImage(named: "Run (10)")!, UIImage(named: "Run (11)")!, UIImage(named: "Run (12)")!, UIImage(named: "Run (13)")!, UIImage(named: "Run (14)")!, UIImage(named: "Run (15)")!]
    
    var spritesIdle: [UIImage] = [UIImage(named: "Idle1")!, UIImage(named: "Idle2")!, UIImage(named: "Idle3")!, UIImage(named: "Idle4")!, UIImage(named: "Idle5")!, UIImage(named: "Idle6")!, UIImage(named: "Idle7")!, UIImage(named: "Idle8")!, UIImage(named: "Idle9")!, UIImage(named: "Idle10")!, UIImage(named: "Idle11")!, UIImage(named: "Idle12")!, UIImage(named: "Idle13")!, UIImage(named: "Idle14")!, UIImage(named: "Idle15")!]
    
    // Variables necesarias
    var iEmp: Int!
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
            //imgBack1.transform = CGAffineTransform(scaleX: 1, y: 1)
            //imgMonito.frame.origin.x = iX - iDif
            
            imgMonito.frame.origin.x = imgObjeto.frame.minX - iDifMin
            imgMonito.transform = CGAffineTransform(scaleX: 1, y: 1)
            
            // De derecha a izquierda
        }else if (sender.value < 0) {
            //imgBack1.transform = CGAffineTransform(scaleX: -1, y: 1)
            //imgMonito.frame.origin.x = iX + iDif
            
            imgMonito.frame.origin.x = imgObjeto.frame.minX + iDifMax
            
            imgMonito.transform = CGAffineTransform(scaleX: -1, y: 1)
        }
    }
    
    //Se toma el valor actual del stepper y se pone la imagen correspondiente
    @IBAction func actualizarObjeto(_ sender: UIStepper) {
        
        // Revisa el valor de la masa y asigna la imagen correspondiente
        if Int(sender.value) > 0 && Int(sender.value) < 49{
            
            imgObjeto.image = UIImage(named: "apple")
        
        }else if Int(sender.value) > 50 && Int(sender.value) < 100{
            
            imgObjeto.image = UIImage(named: "orange")
        
        }else if Int(sender.value) > 101 && Int(sender.value) < 200{
            
            imgObjeto.image = UIImage(named: "watermelon")
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
            
            // Asigna el valor del empuje
            iEmp = Int(stpEmpuje.value)
            
            // Se actualizan los labels
            actualizarValores()
        }
        
        // Actualizar la animacion del personaje
        animacionPersonaje()
    }
    
    // Revisa si se edito el texto
    @IBAction func escribirValores(_ sender: UITextField) {
        
        // Revisa si se hay valor en el de Empuje
        if let iEmp = Int(tfEmpuje.text!){
            // Se lo asigna al Stepper
            stpEmpuje.value = Double(iEmp)

        // Si no
        }else{
            // Pone en 0 el empuje
            iEmp = 0
            // Lo asigna al stepper
            stpEmpuje.value = Double(iEmp)
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
        realizarCalculo()
        
        // Actualizar labels
        actualizarValores()
        
    }
    
    // MARK: - Set Inicial
    // Para calcular la posicion inicial del monito
    func calcularPosicion(){
    }
    
    // Para poner en 0 los labels e iniciar la animación
    func setInicial(){
        
        // Imagen del fondo
        //background.loadGif(name: "back")
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
        iEmp = 0
        iFric = 0
        iMasa = 0
        dAcel = 0.0
        iFNeta = 0
        iCoefFric = 0
    }
    
    // MARK: - Calculos
    
    // Obtiene los valores de los slider y realiza el calculo
    func realizarCalculo(){
        // Obtiene los valroes de Empuje y la Masa
        iEmp = Int(stpEmpuje.value)
        iMasa = Int(stpMasa.value)
        iCoefFric = Double(slCoefFric.value)
        
        // Se calcula la fuerza de fricción
        let tFric = iCoefFric * 9.81 * Double(iMasa)
        
        print(tFric)
        
        // Revisa si es mayor la fuerza de Empuje
        if (abs(iEmp) >= Int(tFric)){
            // Se guarda el valor de fricción
            iFric =  Int(tFric)
            
            // Se calcula la fuerza Normal
            if(iEmp > 0){
                iFNeta = iEmp - iFric
            }else{
                iFNeta = iEmp + iFric
            }
            
            // En caso de no ser mayor la fuerza de empuje
        }else{
            // Se igualan las fuerzas de fricción y de empuje
            iFric = Int(stpEmpuje.value)
            // Fuerza neta igual a 0
            iFNeta = 0
        }
        
        // Se calcula la Aceleración
        dAcel = Double(iFNeta) / Double(iMasa)
    }
    
    // Se actualizan los labels correspondientes
    func actualizarValores(){
        // Se actualiza los textfields
        tfEmpuje.text = String(iEmp)
        tfMasa.text = String(iMasa)
        
        // Se actualizan los labels
        lbFuerzaFriccion.text = "Fuerza de Fricción: " + String(iFric) + "N"
        lbFuerzaNeta.text = "Fuerza Neta: " + String(iFNeta) + "N"
        lbAceleracion.text = "Aceleración: " +  String(format: "%.2f", dAcel) + "m/s"
    }
    
    // MARK: - Animacion
    func animacionPersonaje(){
        
        // Si no hay aceleracion
        if(abs(dAcel) == 0.0 && iTipo != 0){
            // Se asignan los sprites de estar detenido
            imgMonito.animationImages = spritesIdle
            iTipo = 0
            imgMonito.startAnimating()
            
            // Para animar que camina
        }else if (abs(dAcel) > 0.0 && abs(dAcel) <= 7.0 && iTipo != 1) {
            // Se guardan asignan los nuevos sprites
            imgMonito.animationImages = spritesWalk
            iTipo = 1
            imgMonito.startAnimating()
            
            // O que esta corriendo
        }else if (abs(dAcel) > 7.0 && iTipo != 2) {
            // Se asignan los sprites de correr
            imgMonito.animationImages = spritesRun
            iTipo = 2
            imgMonito.startAnimating()
        }
    }

    // MARK: - Diseño
    func setPropiedades(){
        
        // Poner el fondo gradiente
        view.setFondoGradiente(colorUno: Colores.Sky, colorDos:Colores.Purple)
        vwMiniView.backgroundColor = UIColor.clear
        lbBackGround.backgroundColor = UIColor.clear

        // Redondear los labels
        lbAceleracion.esquinasRedondas(radio: 3.0)
        lbFuerzaNeta.esquinasRedondas(radio: 3.0)
        lbFuerzaFriccion.esquinasRedondas(radio: 3.0)

        // Poner fondo en los labels
        lbAceleracion.backgroundColor = UIColor(white: 255.0, alpha: 0.20)
        lbFuerzaNeta.backgroundColor = UIColor(white: 255.0, alpha: 0.20)
        lbFuerzaFriccion.backgroundColor = UIColor(white: 255.0, alpha: 0.20)

        // Redondear esquinas de textfields
        tfEmpuje.esquinasRedondas(radio: 15.0)
        tfMasa.esquinasRedondas(radio: 15.0)
        
        // Border de los textfields
        tfEmpuje.layer.borderWidth = 1.0
        tfMasa.layer.borderWidth = 1.0
        
        // Color del borde
        tfEmpuje.layer.borderColor = UIColor(white: 255.0, alpha: 0.30).cgColor
        tfMasa.layer.borderColor = UIColor(white: 255.0, alpha: 0.30).cgColor

        // Color y opacidad del textfield
        tfEmpuje.backgroundColor = Colores.WhiteBackground
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
        
        if !aRect.contains(tfEmpuje.frame.origin) {
            scrollView.scrollRectToVisible(tfEmpuje.frame, animated: true)
        
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
