//
//  GameScene.swift
//  SimpleShooter
//
//  Created by Elber Carneiro on 4/26/16.
//  Copyright (c) 2016 Elber Carneiro. All rights reserved.
//

import SpriteKit

var player = SKSpriteNode?()
var projectile = SKSpriteNode?()
var enemy = SKSpriteNode?()

var scoreLabel = SKLabelNode?()
var mainLabel = SKLabelNode?()

var fireProjectileRate = 0.2
var projectileSpeed = 0.9

var enemySpeed = 2.1
var enemySpawnRate = 0.6

var isAlive = true

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */

    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {

        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
