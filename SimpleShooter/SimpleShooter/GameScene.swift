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

var score = 0

// an SKScene is the root node of a tree of SKNodes
// a scene must be presented from an SKView object (which in a way is like a
// scenes controller)

// the SKPhysicsDelegate protocol allows ...

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    // called immediately after a scene is presented into view. Good for initial
    // setup
    override func didMoveToView(view: SKView) {
        
        // assign this scene as the delegate to handle physics events
        physicsWorld.contactDelegate = self;
        
        self.backgroundColor = UIColor.purpleColor()
        
        spawnPlayer()
        spawnScoreLabel()
        spawnMainLabel()
        fireProjectile()
        randomEnemyTimerSpawn()
        updateScore()
        hideLabel()
        resetVariablesOnStart()

    }
    
    // Called when a touch begins
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {

        for touch in touches {

        }
    }
   
    // Called before each frame is rendered
    override func update(currentTime: CFTimeInterval) {

    }
    
    /* CUSTOM SETUP FUNCTIONS */
    
    func spawnPlayer() {
        
    }
    
    func spawnScoreLabel() {
        
    }
    
    func spawnMainLabel() {
        
    }
    
    func fireProjectile() {
        
    }
    
    func randomEnemyTimerSpawn() {
        
    }
    
    func updateScore() {
        
    }
    
    func hideLabel() {
        
    }
    
    func resetVariablesOnStart() {
        isAlive = true
        score = 0
    }
}
