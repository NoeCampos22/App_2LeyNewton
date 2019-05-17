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
    @IBOutlet weak var btRegresar: UIButton!
    @IBOutlet weak var lbLeyenda: UILabel!
    @IBOutlet weak var lbSegundaLeyenda: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Poner el fondo con gradiente
        view.setFondoGradiente(colorUno: Colores.Sky, colorDos: Colores.Purple)
        
        // Fondo en los labels
        lbNombres.backgroundColor = Colores.MiniRed
        lbDiseñador.backgroundColor = Colores.MiniRed
        lbMusica.backgroundColor = Colores.MiniRed
        lbSegundaLeyenda.backgroundColor = Colores.MiniRed
        lbLeyenda.backgroundColor = Colores.MiniRed
        
        // Redondear esquinas
        lbNombres.esquinasRedondas(radio: 10)
        lbDiseñador.esquinasRedondas(radio: 10)
        lbMusica.esquinasRedondas(radio: 10)
        lbLeyenda.esquinasRedondas(radio: 10)
        lbSegundaLeyenda.esquinasRedondas(radio: 10)
        
        lbLeyenda.text = "Segunda Ley ha sido desarrollado por estudiantes del Tecnológico de Monterrey durante el semestre Enero Mayo 2019, como parte del curso Desarrollo de Aplicaciónes para Dispositivos Móviles y asesorados por la maestra Yolanda Martínez Treviño"
        
        lbSegundaLeyenda.text = "Segunda Ley se distribuye como está de manera gratuita y se prohibe su distribución y uso con fines de lucro."
        
        lbNombres.text = "Noé Campos \n ama-noe@hotmail.com\nMariana Villegas \n mariana2v@hotmail.com\nElí Moreira \n coincidir777@hotmail.com"
        
        lbDiseñador.text = "Stephany Macías \n stefhanyreyes7@gmail.com"
        
        lbMusica.text = "https://www.bendsound.com"

        // Boton forma y color
        btRegresar.esquinasRedondas(radio: 10)
        btRegresar.backgroundColor = Colores.ObscureBlue
    }
    
}
