//
//  ViewController.swift
//  2daLeyNewtonProyecto
//
//  Created by Alumno on 2/27/19.
//  Copyright © 2019 itesm. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var musicSwitch: UISwitch!
    
    var audio = AVAudioPlayer()
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
    @IBAction func unwindInfo (unwindSegue: UIStoryboardSegue) {
        
    }
    @IBAction func unwindCredits (unwindSegue: UIStoryboardSegue) {
        
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

