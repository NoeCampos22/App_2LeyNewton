//
//  ViewController.swift
//  2daLeyNewtonProyecto
//
//  Created by Noe Campos on 2/27/19.
//  Copyright © 2019 itesm. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var audio = AVAudioPlayer()
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var btInfo: UIButton!
    @IBOutlet weak var btSimulador: UIButton!
    @IBOutlet weak var btPreguntas: UIButton!
    @IBOutlet weak var lbMusica: UILabel!
    @IBOutlet weak var swMusica: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Poner el fondo con gradiente
        view.setFondoGradiente(colorUno: Colores.Sky, colorDos: Colores.Purple)

        // Redondear botones
        btInfo.esquinasRedondas(radio: 15.0)
        btSimulador.esquinasRedondas(radio: 15.0)
        btPreguntas.esquinasRedondas(radio: 15.0)
        
        // Size del font
        btPreguntas.fontSize()
        btSimulador.fontSize()
        btPreguntas.fontSize()
        
        // Fondo de los botones
        btInfo.backgroundColor = Colores.ObscureBlue
        btSimulador.backgroundColor = Colores.ObscureBlue
        btPreguntas.backgroundColor = Colores.ObscureBlue
        
        // Colores del switch
        swMusica.tintColor = Colores.ObscureBlue
        swMusica.onTintColor = Colores.ObscureBlueAlpha

        // Reproducir la musica
        do {
            audio = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "bgm", ofType: "mp3")!))
        }
        catch {
            print(error)
        }
        
        // Revisa la configuración
        if let bgm = defaults.value(forKey: "bgm") as? Bool {
            swMusica.isOn = bgm
        }
    }

    override func viewDidAppear(_ animated: Bool) {
    if (swMusica.isOn == true){
            audio.play()
        }
    }
    
    @IBAction func unwindSimulacion (unwindSegue: UIStoryboardSegue) {
    }
    
    // Renombrar la de arriba y quitar estas

    @IBAction func unwindPreguntas (unwindSegue: UIStoryboardSegue) {
    }
    
    @IBAction func unwindCreditos (unwindSegue: UIStoryboardSegue) {
    }

    // To start or stop the musica
    @IBAction func bgmControl(_ sender: UISwitch) {
        defaults.set(sender.isOn, forKey: "bgm")
        
        if(sender.isOn == true) {
            audio.play()
        } else {
            audio.stop()
        }
    }
}

