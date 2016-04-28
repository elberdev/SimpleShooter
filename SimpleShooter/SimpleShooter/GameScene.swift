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

// an off-white
var textColorHUD = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)

// this will be used to handle collisions between objects
struct physicsCategory {
    
    // the word static is to a stuct what the class keyword is in a class
    // it creates a type-level variable or function, like the + in Objective-C.
    static let player : UInt32 = 1
    static let enemy : UInt32 = 2
    static let projectile : UInt32 = 3
}

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
        
        // init player
        player = SKSpriteNode(color: UIColor.whiteColor(), size: CGSize(width: 100, height: 100))
        
        // position it in the world
        player?.position = CGPoint(x: CGRectGetMidX(self.frame), y: 200)
        
        // give it a physics body. We use a volume-based constructor which by default
        // is affected by all the different types of physics forces. Maybe we should
        // have used an edge-based constructor instead?
        player?.physicsBody = SKPhysicsBody(rectangleOfSize: (player?.size)!)
        
        // so we have to make sure it is not affected by gravity and ignores all dynamic
        // forces applied to it. I think dynamic being false also includes gravity so the
        // gravity bit may be unnecessary.
        player?.physicsBody?.affectedByGravity = false
        player?.physicsBody?.dynamic = false
        
        // tell which physics group it belongs to
        player?.physicsBody?.categoryBitMask = physicsCategory.player
        
        // tell which physics group it can collide with
        player?.physicsBody?.contactTestBitMask = physicsCategory.enemy

        
        self.addChild(player!)
    }
    
    func spawnScoreLabel() {
        
        scoreLabel = SKLabelNode(fontNamed: "Futura")
        scoreLabel?.fontSize = 50
        scoreLabel?.fontColor = textColorHUD
        scoreLabel?.position = CGPoint(x: CGRectGetMidX(self.frame), y: 50)
        scoreLabel?.text = "Score"
        
        self.addChild(scoreLabel!)
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
