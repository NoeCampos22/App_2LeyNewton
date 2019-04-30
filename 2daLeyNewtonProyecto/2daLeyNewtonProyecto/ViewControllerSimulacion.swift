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
    //Slider Values
    @IBOutlet weak var lbNewtons: UILabel!
    @IBOutlet weak var lbMasa: UILabel!
    @IBOutlet weak var lbFriccion: UILabel!
    
    @IBOutlet weak var lbAngulo: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        lbNewtons.text = "0"
        lbMasa.text = "0"
        lbFriccion.text = "0"
        lbAngulo.text = "0"
        lbFuerzaNeta.text = "0"
        lbAceleracion.text = "0"
        lbFuerzaFriccion.text = "0"
        
        var imagesNames = ["Idle1","Idle2", "Idle3", "Idle4", "Idle5", "Idle6", "Idle7", "Idle8", "Idle9", "Idle10", "Idle11", "Idle12", "Idle13", "Idle14", "Idle15"]
        var images = [UIImage]()
        for i in 0..<imagesNames.count{
            images.append(UIImage(named: imagesNames[i])!)
        }
        character.animationImages = images
        character.animationDuration = 0.5
        character.startAnimating()
        
        // Do any additional setup after loading the view.
    }
    
    //Se hace la acción de la simulación calculando la aceleración, fricción y fuerza neta
//FUERZA NETA = MASA*ACELERACION
//Aceleracion = Fuerza neta/masa
    //9.8*peso
    //Fn = 9.81 * peso
    //Fuerza neta = Fuerza aplicada - Fn*friccion
    
    @IBAction func sliderNewton(_ sender: UISlider) {
        lbNewtons.text = String(Int(sender.value))
  
    }
    
    @IBAction func sliderActionMasa(_ sender: UISlider) {
        lbMasa.text = String(Int(sender.value))
    }
    
    @IBAction func sliderActionAngulo(_ sender: UISlider) {
        lbAngulo.text = String(Int(sender.value))
    }
    @IBAction func sliderActionFriccion(_ sender: UISlider) {
           lbFriccion.text = String(Double(sender.value))
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
        lbFuerzaFriccion.text = String(fr)
        lbAceleracion.text = String(acc)
        lbFuerzaNeta.text = String(fuerzaNeta)
        
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
