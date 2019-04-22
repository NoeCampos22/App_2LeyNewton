//
//  ViewControllerSimulacion.swift
//  2daLeyNewtonProyecto
//
//  Created by Alumno on 2/27/19.
//  Copyright © 2019 itesm. All rights reserved.
//

import UIKit

class ViewControllerSimulacion: UIViewController {
    @IBOutlet weak var imgFoto: UIImageView!
    
    @IBOutlet weak var character: UIImageView!
    //Sliders outlets
    @IBOutlet weak var sliderNewtons: UISlider!
    
    @IBOutlet weak var imgBack: UIImageView!
    
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var sliderAngulo: UISlider!{
        didSet{
            sliderAngulo.transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI_2))
        }
    }
    
    
    @IBOutlet weak var sliderMasa: UISlider!
    @IBOutlet weak var sliderFriccion: UISlider!
    @IBOutlet weak var lbAceleracion: UILabel!
    @IBOutlet weak var lbFuerzaNeta: UILabel!
    @IBOutlet weak var lbFuerzaFriccion: UILabel!
    
    //S
    @IBOutlet weak var lbNewtons: UILabel!
    @IBOutlet weak var lbMasa: UILabel!
    @IBOutlet weak var lbFriccion: UILabel!
    
    @IBOutlet weak var lbAngulo: UILabel!
    
    var imagesJump = ["Jump (1)","Jump (2)", "Jump (3)", "Jump (4)", "Jump (5)", "Jump (6)", "Jump (7)", "Jump (8)", "Jump (9)", "Jump (10)", "Jump (11)", "Jump (12)", "Jump (13)", "Jump (14)", "Jump (15)"]
    
    var imagesWalk = ["Walk (1)","Walk (2)", "Walk (3)", "Walk (4)", "Walk (5)", "Walk (6)", "Walk (7)", "Walk (8)", "Walk (9)", "Walk (10)", "Walk (11)", "Walk (12)", "Walk (13)", "Walk (14)", "Walk (15)"]
    
    var imagesRun = ["Run (1)","Run (2)", "Run (3)", "Run (4)", "Run (5)", "Run (6)", "Run (7)", "Run (8)", "Run (9)", "Run (10)", "Run (11)", "Run (12)", "Run (13)", "Run (14)", "Run (15)"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        background.loadGif(name: "back")
        lbNewtons.text = "0"
        lbMasa.text = "0"
        lbFriccion.text = "0"
        lbAngulo.text = "0"
        lbFuerzaNeta.text = "0"
        lbAceleracion.text = "0"
        lbFuerzaFriccion.text = "0"
        character.isHidden = true
        
        var imagesIdle = ["Idle1","Idle2", "Idle3", "Idle4", "Idle5", "Idle6", "Idle7", "Idle8", "Idle9", "Idle10", "Idle11", "Idle12", "Idle13", "Idle14", "Idle15"]
        
        var images = [UIImage]()
        for i in 0..<imagesIdle.count{
            images.append(UIImage(named: imagesIdle[i])!)
        }
        
        character.animationImages = images
        character.animationDuration = 0.5
        character.startAnimating()
        
    }
    
    //Se hace la acción de la simulación calculando la aceleración, fricción y fuerza neta
    //FUERZA NETA = MASA*ACELERACION
    //Aceleracion = Fuerza neta/masa
    //9.8*peso
    //Fn = 9.81 * peso
    //Fuerza neta = Fuerza aplicada - Fn*friccion
    func moveRight(image: UIImageView){
        image.center.x += 300
    }
    func moveLeft(image: UIImageView){
        image.center.x -= 300
    }
    
    //Dependiendo si los newtons son positivos, negativos o 0
    //1.- El personaje aparecera ya sea en el lado derecho o izquierdo de la pantalla
    //2.-Dependiendo la fuerza aplicada el personaje empezará a empujar el objeto de en medio y cambiarán los valores de los calculos
    @IBAction func empujarObjeto(_ sender: UISlider) {

        if sender.value > 0{
            imgBack.transform = CGAffineTransform(scaleX: 1, y: 1)
            character.frame = CGRect(x: 100.0, y: 150.0, width: 100.0, height: 250.0)
            character.transform = CGAffineTransform(scaleX: 1, y: 1)
            character.isHidden = false
            
            if sender.value < 250 && sender.value > 0 {
                var images = [UIImage]()
                
                for i in 0..<imagesWalk.count{
                    images.append(UIImage(named: imagesWalk[i])!)
                }
                
                character.animationImages = images
                character.animationDuration = 0.5
                character.startAnimating()
            }
            
            if sender.value < 500 && sender.value > 251 {
                var images = [UIImage]()
                
                for i in 0..<imagesRun.count{
                    images.append(UIImage(named: imagesRun[i])!)
                }
                
                character.animationImages = images
                character.animationDuration = 0.5
                character.startAnimating()
            }
        }

        if sender.value < 0 {
            imgBack.transform = CGAffineTransform(scaleX: -1, y: 1)
            character.frame = CGRect(x: 170.0, y: 150.0, width: 100.0, height: 250.0)
            
            character.transform = CGAffineTransform(scaleX: -1, y: 1)
            character.isHidden = false
            
            if sender.value > -250 && sender.value < 0 {
                var images = [UIImage]()
                
                for i in 0..<imagesWalk.count{
                    images.append(UIImage(named: imagesWalk[i])!)
                }
                
                character.animationImages = images
                character.animationDuration = 0.5
                character.startAnimating()
            }
            
            if sender.value > -500 && sender.value < -251 {
                var images = [UIImage]()
                
                for i in 0..<imagesRun.count{
                    images.append(UIImage(named: imagesRun[i])!)
                }
                
                character.animationImages = images
                character.animationDuration = 0.5
                character.startAnimating()
            }
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
    
    //Calculos pero todavía no jala bien
    @IBAction func btIniciarSimulacion(_ sender: UIButton) {
        
        let friccion = Double(sliderFriccion.value)
        let masa = Double(sliderMasa.value)
        let newtonsAplicados = Double(sliderNewtons.value)
        let fX = cos(Double(sliderAngulo.value)) * newtonsAplicados
        let fY = sin(Double(sliderAngulo.value)) * newtonsAplicados
        let fn = (9.81 * masa) - fY
        let fr = friccion * fn
        let fuerzaNeta = fX - fr
        let acc = (fX - fr) / masa
        lbFuerzaFriccion.text = String(format: "%.2f", friccion)
        lbAceleracion.text = String(format: "%.2f", acc)
        lbFuerzaNeta.text = String(format: "%.2f", fuerzaNeta)
        
    }
    
    /*  lbFuerzaNeta.text = ""
     lbAceleracion.text = ""
     lbFuerzaFriccion.text = ""
     lbNewtons.text = ""
     lbPeso.text = ""
     lbFriccion.text = ""
     sliderPeso.value = 0.0
     sliderFriccion.value = 0.0
     sliderNewtons.value = 0.0*/
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
