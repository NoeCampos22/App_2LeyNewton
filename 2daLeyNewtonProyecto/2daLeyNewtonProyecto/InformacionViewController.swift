//
//  InformacionViewController.swift
//  2daLeyNewtonProyecto
//
//  Created by Noé Campos and Eli Moreira on 5/2/19.
//  Copyright © 2019 itesm. All rights reserved.
//

import UIKit

class InformacionViewController: UIViewController {
    
    @IBOutlet weak var lbTexto: UILabel!
    @IBOutlet weak var btRegresar: UIButton!
    @IBOutlet weak var scvScrollView: UIScrollView!
    @IBOutlet weak var vwViewNegra: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scvScrollView.contentSize = vwViewNegra.frame.size
        
        // Poner el fondo con gradiente
        view.setFondoGradiente(colorUno: Colores.Sky, colorDos: Colores.Purple)
        
        // Color y dondo del label
        lbTexto.backgroundColor = Colores.TransparentRed
        lbTexto.esquinasRedondas(radio: 10.0)
        
        // Color y forma del boton
        btRegresar.backgroundColor = Colores.ObscureBlue
        btRegresar.esquinasRedondas(radio: 10.0)
        
    }
    
    // Que orientacion soporta
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    // Para que no rote la pantalla
    override var shouldAutorotate: Bool {
        return false
    }
}
