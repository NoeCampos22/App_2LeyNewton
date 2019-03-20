//
//  ViewControllerSimulacion.swift
//  2daLeyNewtonProyecto
//
//  Created by Alumno on 2/27/19.
//  Copyright © 2019 itesm. All rights reserved.
//

import UIKit

class ViewControllerSimulacion: UIViewController {
    
    
    @IBOutlet weak var lbFuerzaNeta: UILabel!
    
    @IBOutlet weak var lbFriccion: UILabel!
    
    @IBOutlet weak var lbAceleracion: UILabel!
    var imagenes: [String] = [String]()
    
    @IBOutlet weak var imgFoto: UIImageView!
    @IBOutlet weak var slider: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()
      /*  imagenes = ["apple", "orange.jpg","watermelon.jpg"]*/
        // Do any additional setup after loading the view.
    }
    

    @IBAction func sliderAction(_ sender: UISlider) {
        
        lbFuerzaNeta.text = String(sender.value)
        lbFriccion.text = String(sender.value)
        lbAceleracion.text = String(sender.value)

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

