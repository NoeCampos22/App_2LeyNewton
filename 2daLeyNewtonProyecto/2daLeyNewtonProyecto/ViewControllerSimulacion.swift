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
    var imagesWalk = ["Walk (1)","Walk (2)", "Walk (3)", "Walk (4)", "Walk (5)", "Walk (6)", "Walk (7)", "Walk (8)", "Walk (9)", "Walk (10)", "Walk (11)", "Walk (12)", "Walk (13)", "Walk (14)", "Walk (15)"]
    var imagesRun = ["Run (1)","Run (2)", "Run (3)", "Run (4)", "Run (5)", "Run (6)", "Run (7)", "Run (8)", "Run (9)", "Run (10)", "Run (11)", "Run (12)", "Run (13)", "Run (14)", "Run (15)"]
    var imagesIdle = ["Idle1","Idle2", "Idle3", "Idle4", "Idle5", "Idle6", "Idle7", "Idle8", "Idle9", "Idle10", "Idle11", "Idle12", "Idle13", "Idle14", "Idle15"]
    
    // Arreglo para sprites del personaje
    var imgAnimation = [UIImage]()
    
    // Variables necesarias
    var iEmp: Int!
    var iFric: Int!
    var iMasa: Int!
    var iFNeta: Int!
    var dAcel: Double!
    var iCoefFric: Double!
    
    var iX: CGFloat!
    var iY: CGFloat!
    var iWidth: CGFloat!
    var iHeight: CGFloat!
    
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
        
        // Borra el arreglo de sprites
        imgAnimation.removeAll()
        
        // Si la masa es 0 o no empuja
        if(iMasa == 0 || iEmp == 0){
            // Asigna los sprites de estar quieto
            for i in 0..<imagesRun.count{
                imgAnimation.append(UIImage(named: imagesIdle[i])!)
            }
        }else{
            // Revisa si empuja caminando
            if (abs(sender.value) < 250 && abs(sender.value) > 0) {
                
                // Llena el arreglo con las imagenes de caminar
                for i in 0..<imagesWalk.count{
                    imgAnimation.append(UIImage(named: imagesWalk[i])!)
                }
                
                // O corriendo
            }else if (abs(sender.value) < 500 && abs(sender.value) > 251) {
                
                // Llena el arreglo con sprites de correr
                for i in 0..<imagesRun.count{
                    imgAnimation.append(UIImage(named: imagesRun[i])!)
                }
            }
        }
        
        
        
        
        
        // Asigan los sprites, duracion y comienzo
        character.animationImages = imgAnimation
        character.animationDuration = 0.5
        character.startAnimating()
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
            // Todo se pone en 0
            iEmp = 0
            iFric = 0
            iMasa = 0
            dAcel = 0.0
            iFNeta = 0
            
            // Se actualizan los labels
            actualizarLabels()
        }

    }
   
    
    // MARK: - Set Inicial
    // Para calcular la posicion inicial del monito
    func calcularPosicion(){
        iX = imgFoto.frame.minX - iWidth - 5
        iY = imgFoto.frame.minY
    }
    
    // Para poner en 0 los labels e iniciar la animación
    func setInicial(){

        background.loadGif(name: "back")
        //character.isHidden = true
        
        for i in 0..<imagesIdle.count{
            imgAnimation.append(UIImage(named: imagesIdle[i])!)
        }
        
        character.animationImages = imgAnimation
        character.animationDuration = 0.5
        character.startAnimating()
        
        // Save the character size
        iHeight = character.frame.height
        iWidth = character.frame.width
        
        // Calcular la posicion
        calcularPosicion()
        
        // Posicionar al personaje
        character.frame = CGRect(x: iX, y: iY, width: iWidth, height: iHeight)
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
    
    
    /*
     TO-DO List
     - Cuando la masa sea 0 la animacion sea la inicial (Check)
     - No anime cuando este la masa en 0
     - No calcule cuando la masa sea 0 (Check)
     - Posicion del monito
     - No se interrumpa la animacion
     */
    
}
