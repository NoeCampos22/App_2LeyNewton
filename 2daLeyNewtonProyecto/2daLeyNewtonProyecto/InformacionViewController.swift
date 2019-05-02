//
//  InformacionViewController.swift
//  2daLeyNewtonProyecto
//
//  Created by Alumno on 5/2/19.
//  Copyright © 2019 itesm. All rights reserved.
//

import UIKit

class InformacionViewController: UIViewController {

    @IBOutlet weak var infoImagen: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        infoImagen.image = UIImage(named: "segunda_ley")
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
