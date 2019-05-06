//
//  InformacionViewController.swift
//  2daLeyNewtonProyecto
//
//  Created by Noé Campos on 5/2/19.
//  Copyright © 2019 itesm. All rights reserved.
//

import UIKit

class InformacionViewController: UIViewController {
    
    @IBOutlet weak var lbTexto: UILabel!
    @IBOutlet weak var btRegresar: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.setFondoGradiente(colorUno: Colores.Sky, colorDos: Colores.Purple2)
        
        lbTexto.backgroundColor = Colores.MiniRed
        lbTexto.esquinasRedondas(radio: 10.0)
        
        btRegresar.backgroundColor = Colores.ObscureBlue
        
    }

}
