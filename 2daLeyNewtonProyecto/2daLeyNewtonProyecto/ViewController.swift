//
//  ViewController.swift
//  2daLeyNewtonProyecto
//
//  Created by Noe Capos on 2/27/19.
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
    @IBOutlet weak var musicSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.setFondoGradiente(colorUno: Colores.Sky, colorDos: Colores.Purple)
        
        btInfo.esquinasRedondas(radio: 15.0)
        btSimulador.esquinasRedondas(radio: 15.0)
        btPreguntas.esquinasRedondas(radio: 15.0)
        
        btInfo.backgroundColor = Colores.ObscureBlue
        btSimulador.backgroundColor = Colores.ObscureBlue
        btPreguntas.backgroundColor = Colores.ObscureBlue
        
        do {
            audio = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "bgm", ofType: "mp3")!))
        }
        catch {
            print(error)
        }
        
        if let bgm = defaults.value(forKey: "bgMusic") as? Bool {
            musicSwitch.isOn = bgm
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (musicSwitch.isOn == true){
            audio.play()
        }
    }
    
    @IBAction func unwindSimulacion (unwindSegue: UIStoryboardSegue) {
    }
    
    @IBAction func unwindPreguntas (unwindSegue: UIStoryboardSegue) {
    }
    
    @IBAction func unwindCreditos (unwindSegue: UIStoryboardSegue) {
    }
    
    @IBAction func unwindInfo (unwindSegue: UIStoryboardSegue) {
    }
    
    @IBAction func bgmControl(_ sender: UISwitch) {
        defaults.set(sender.isOn, forKey: "bgMusic")
        
        if(sender.isOn == true)
        {
            audio.play()
        }
        else
        {
            audio.stop()
        }
    }
    
}

