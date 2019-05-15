//
//  CreditosViewController.swift
//  2daLeyNewtonProyecto
//
//  Created by Noe Campos on 5/2/19.
//  Copyright © 2019 itesm. All rights reserved.
//

import UIKit

class CreditosViewController: UIViewController {

    @IBOutlet weak var lbNombres: UILabel!
    @IBOutlet weak var lbDiseñador: UILabel!
    @IBOutlet weak var lbMusica: UILabel!
    @IBOutlet weak var lbInfo: UILabel!
    @IBOutlet weak var btRegresar: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Poner el fondo con gradiente
        view.setFondoGradiente(colorUno: Colores.Sky, colorDos: Colores.Purple)
        
        // Fondo en los labels
        lbNombres.backgroundColor = Colores.MiniRed
        lbDiseñador.backgroundColor = Colores.MiniRed
        lbMusica.backgroundColor = Colores.MiniRed
        
        // Redondear esquinas
        lbNombres.esquinasRedondas(radio: 10)
        lbDiseñador.esquinasRedondas(radio: 10)
        lbMusica.esquinasRedondas(radio: 10)
        
        lbNombres.text = "Noé Campos \n E-mail: ama-noe@hotmail.com        \nMariana Villegas \n E-mail: mariana2v@hotmail.com  \nElí Moreira \n E-mail: coincidir777@hotmail.com"
        
        lbDiseñador.text = "Stephany Macías \n stefhanyreyes7@gmail.com"
        
        lbMusica.text = "https://www.bendsound.com"

        //lbInfo.text = "https://www.fisicalab.com/apartado/principio-fundamental#contenidos"
        
        // Boton forma y color
        btRegresar.esquinasRedondas(radio: 10)
        btRegresar.backgroundColor = Colores.ObscureBlue
    }
    
}
