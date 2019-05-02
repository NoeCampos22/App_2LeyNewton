//
//  CreditosViewController.swift
//  2daLeyNewtonProyecto
//
//  Created by Alumno on 5/2/19.
//  Copyright © 2019 itesm. All rights reserved.
//

import UIKit

class CreditosViewController: UIViewController {

    @IBOutlet weak var lbNombres: UILabel!
    @IBOutlet weak var lbDiseñador: UILabel!
    @IBOutlet weak var lbMusica: UILabel!
    @IBOutlet weak var btRegresar: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.setFondoGradiente(colorUno: Colores.Sky, colorDos: Colores.Purple)
        
        lbNombres.backgroundColor = Colores.MiniRed
        lbDiseñador.backgroundColor = Colores.MiniRed
        lbMusica.backgroundColor = Colores.MiniRed
        
        lbNombres.esquinasRedondas(radio: 10)
        lbDiseñador.esquinasRedondas(radio: 10)
        lbMusica.esquinasRedondas(radio: 10)
        
        lbNombres.text = "Noé Campos \n ama-noe@hotmail.com        \nMariana Villegas \n mariana2v@hotmail.com  \nElí Moreira \n eli@gmail.com"
        
        lbDiseñador.text = "Stephany Macías \n stephMacias@gmail.com"
        
        lbMusica.text = "https://www.bendsound.com"
        
        btRegresar.esquinasRedondas(radio: 10)
        btRegresar.backgroundColor = Colores.ObscureBlue
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
