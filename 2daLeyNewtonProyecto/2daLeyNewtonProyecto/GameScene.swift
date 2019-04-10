//
//  GameScene.swift
//  2daLeyNewtonProyecto
//
//  Created by Alumno on 3/27/19.
//  Copyright © 2019 itesm. All rights reserved.
//

import Foundation
import SpriteKit
class GameScene: SKScene{
    var textureAtlas = SKTextureAtlas()
    var textureArray = [SKTexture]()
    var mainGuy = SKSpriteNode()
    
    override func didMove(to view: SKView){
        textureAtlas = SKTextureAtlas(named: "2daLeyNewtonProyecto")
        NSLog("\(textureAtlas.textureNames)")
        for i in 0...textureAtlas.textureNames.count{
            var Name = "idle\(i).png"
            textureArray.append(SKTexture(imageNamed: Name))
        }
        mainGuy = SKSpriteNode(imageNamed: textureAtlas.textureNames[0] as! String)
        mainGuy.size = CGSize(width: 70, height: 140)
        mainGuy.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        self.addChild(mainGuy)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        mainGuy.run(SKAction.repeatForever(SKAction.animate(with: textureArray, timePerFrame: 0.1)))
    }
  /*  override func update(_ currentTime: TimeInterval) {
    
    }*/
    
    
}

