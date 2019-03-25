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
    //Sliders outlets
    @IBOutlet weak var sliderNewtons: UISlider!
    @IBOutlet weak var sliderPeso: UISlider!
    @IBOutlet weak var sliderFriccion: UISlider!
    
    @IBOutlet weak var lbAceleracion: UILabel!
    @IBOutlet weak var lbFuerzaNeta: UILabel!
    @IBOutlet weak var lbFuerzaFriccion: UILabel!
    //Slider Values
    @IBOutlet weak var lbNewtons: UILabel!
    @IBOutlet weak var lbPeso: UILabel!
    @IBOutlet weak var lbFriccion: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    //Tomamos valor para calculos y animación para los
    @IBAction func sliderActionPeso(_ sender: UISlider) {
           lbPeso.text = String(Int(sender.value))
    }
    
    @IBAction func sliderActionFriccion(_ sender: UISlider) {
           lbFriccion.text = String(Double(sender.value))
    }
    //Calculos pero todavía no jala bien
    @IBAction func btIniciarSimulacion(_ sender: UIButton) {
        let friccion = Double(sliderFriccion.value)
        let peso = Double(sliderPeso.value)
        let newtonsAplicados = Double(sliderNewtons.value)
        let fn = 9.81 * peso
        let fuerzaNeta = newtonsAplicados - (fn * friccion)
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
