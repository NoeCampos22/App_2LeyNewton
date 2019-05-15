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
        
        // Poner el fondo con gradiente
        view.setFondoGradiente(colorUno: Colores.Sky, colorDos: Colores.Purple)
        
        // Color y dondo del label
        lbTexto.backgroundColor = Colores.TransparentRed
        lbTexto.esquinasRedondas(radio: 10.0)
        
        // Color y forma del boton
        btRegresar.backgroundColor = Colores.ObscureBlue
        btRegresar.esquinasRedondas(radio: 10.0)
        
    }

}
