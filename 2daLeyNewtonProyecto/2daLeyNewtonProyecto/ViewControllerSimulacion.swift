//
//  ViewControllerSimulacion.swift
//  2daLeyNewtonProyecto
//
//  Created by Alumno on 2/27/19.
//  Copyright © 2019 itesm. All rights reserved.
//

import UIKit

class ViewControllerSimulacion: UIViewController {
    
    
    // Sliders
    @IBOutlet weak var slEmpuje: UISlider!
    @IBOutlet weak var slAngulo: UISlider!{
        didSet{
            slAngulo.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi))
        }
    }
    @IBOutlet weak var slMasa: UISlider!
    @IBOutlet weak var slCoefFric: UISlider!
    
    // Imagenes
    @IBOutlet weak var imgFoto: UIImageView!
    @IBOutlet weak var character: UIImageView!
    @IBOutlet weak var imgBack: UIImageView!
    @IBOutlet weak var background: UIImageView!
    
    // Labels
    @IBOutlet weak var lbAceleracion: UILabel!
    @IBOutlet weak var lbFuerzaNeta: UILabel!
    @IBOutlet weak var lbFuerzaFriccion: UILabel!
    @IBOutlet weak var lbEmpuje: UILabel!
    @IBOutlet weak var lbMasa: UILabel!
    @IBOutlet weak var lbFriccion: UILabel!
    @IBOutlet weak var lbAngulo: UILabel!
    
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
    
    // Variable de animacion del personaje
    var iTipo: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Iniciar todo al cargar la pantalla
        setInicial()
    }
    
    //Dependiendo si los newtons son positivos, negativos o 0
    //1.- El personaje aparecera ya sea en el lado derecho o izquierdo de la pantalla
    //2.-Dependiendo la fuerza aplicada el personaje empezará a empujar el objeto de en medio y cambiarán los valores de los calculos
    @IBAction func empujarObjeto(_ sender: UISlider) {
        
        // Revisa la direccion a la que se empuja el objeto
        // De izquierda a derecha
        if (sender.value > 0){
            imgBack.transform = CGAffineTransform(scaleX: 1, y: 1)
            character.frame = CGRect(x: iX, y: iY, width: iWidth, height: iHeight)
            character.transform = CGAffineTransform(scaleX: 1, y: 1)
        
        // De derecha a izquierda
        }else if (sender.value < 0) {
            imgBack.transform = CGAffineTransform(scaleX: -1, y: 1)
            character.frame = CGRect(x: 170.0, y: 150.0, width: 100.0, height: 250.0)
            character.transform = CGAffineTransform(scaleX: -1, y: 1)
        }
    }
    
    //Tomamos valor para calculos y animación para los
    @IBAction func sliderActionMasa(_ sender: UISlider) {
        
        lbMasa.text = String(Int(sender.value))
        if sender.value > 0 && sender.value < 49{
            imgFoto.image = UIImage(named: "apple")
        }
        if sender.value > 50 && sender.value < 100{
            imgFoto.image = UIImage(named: "orange")
        }
        if sender.value > 101 && sender.value < 200{
            imgFoto.image = UIImage(named: "watermelon")
        }
    }
    
    // Metodo general para actualizar datos de la simulación
    @IBAction func simulacionActiva(_ sender: Any){
        
        // Mientras que haya algo que empujar...
        if(Int(slMasa.value) != 0){
            // Se realizan los calculos con los nuevos datos
            realizarCalculo()
            // Se muestran los datos
            actualizarLabels()
            
        // Si no hay algo que empujar
        }else{
            // Todo se pone en 0s
            setCeros()
            
            // Se actualizan los labels
            actualizarLabels()
        }
        
        
        // Actualizar la animacion del personaje
        animacionPersonaje()

    }
   
    
    // MARK: - Set Inicial
    // Para calcular la posicion inicial del monito
    func calcularPosicion(){
        iX = imgFoto.frame.minX - iWidth - 5
        iY = imgFoto.frame.minY
    }
    
    // Para poner en 0 los labels e iniciar la animación
    func setInicial(){
        
        // Imagen del fondo
        background.loadGif(name: "back")
        
        // Se inicializan los valores en 0
        setCeros()
        // Se imprimen los 0s
        actualizarLabels()
        
        // Se asigna la animacion inicial
        character.animationImages = spritesIdle
        // Se guarda la bandera de la animacion
        iTipo = 0
        // Se inidica la velovidad de la animacion
        character.animationDuration = 0.5
        // Inicia la animacion
        character.startAnimating()
        
        
        // Save the character size
        iHeight = character.frame.height
        iWidth = character.frame.width
        
        // Calcular la posicion
        calcularPosicion()
        
        // Posicionar al personaje
        character.frame = CGRect(x: iX, y: iY, width: iWidth, height: iHeight)
    }
    
    // Para que los valores iniciales sean 0
    func setCeros(){
        iEmp = 0
        iFric = 0
        iMasa = 0
        dAcel = 0.0
        iFNeta = 0
    }
    
    // MARK: - Calculos
    
    // Obtiene los valores de los slider y realiza el calculo
    func realizarCalculo(){
        // Obtiene los valroes de Empuje y la Masa
        iEmp = Int(slEmpuje.value)
        iMasa = Int(slMasa.value)
        
        // Se calcula la fuerza de fricción
        let tFric = Double(slCoefFric.value) * 9.81 * Double(iMasa)
        
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
            iFric = Int(slEmpuje.value)
            // Fuerza neta igual a 0
            iFNeta = 0
        }
        
        // Se calcula la Aceleración
        dAcel = Double(iFNeta) / Double(iMasa)
    }
    
    // Se actualizan los labels correspondientes
    func actualizarLabels(){
        lbEmpuje.text = String(iEmp)
        lbMasa.text = String(iMasa)
        lbFuerzaFriccion.text = String(iFric)
        lbFuerzaNeta.text = String(iFNeta)
        lbAceleracion.text = String(format: "%.2f", dAcel)
    }
    
    // MARK: - Animacion
    func animacionPersonaje(){
        
        // Si no hay aceleracion
        if(dAcel == 0.0 && iTipo != 0){
            // Se asignan los sprites de estar detenido
            character.animationImages = spritesIdle
            iTipo = 0
            character.startAnimating()
            
            // Para animar que camina
        }else if (dAcel > 0.0 && dAcel <= 7.0 && iTipo != 1) {
            // Se guardan asignan los nuevos sprites
            character.animationImages = spritesWalk
            iTipo = 1
            character.startAnimating()
            
            // O que esta corriendo
        }else if (dAcel > 7.0 && iTipo != 2) {
            // Se asignan los sprites de correr
            character.animationImages = spritesRun
            iTipo = 2
            character.startAnimating()
        }
    }
    
    /*
     TO-DO List
     - Posicion del monito
     */
    
}
