//
//  ViewController.swift
//  2daLeyNewtonProyecto
//
//  Created by Noe Capos on 2/27/19.
//  Copyright © 2019 itesm. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var btInfo: UIButton!
    @IBOutlet weak var btSimulador: UIButton!
    @IBOutlet weak var btPreguntas: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.setFondoGradiente(colorUno: Colores.Sky, colorDos: Colores.Purple)
        
        btInfo.esquinasRedondas(radio: 15.0)
        btSimulador.esquinasRedondas(radio: 15.0)
        btPreguntas.esquinasRedondas(radio: 15.0)
        
        btInfo.backgroundColor = Colores.ObscureBlue
        btSimulador.backgroundColor = Colores.ObscureBlue
        btPreguntas.backgroundColor = Colores.ObscureBlue
        
    }
    
    @IBAction func unwindSimulacion (unwindSegue: UIStoryboardSegue) {
    }
    
    @IBAction func unwindPreguntas (unwindSegue: UIStoryboardSegue) {
    }
    
    @IBAction func unwindCreditos (unwindSegue: UIStoryboardSegue) {
    }
}

