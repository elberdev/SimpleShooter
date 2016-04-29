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
        spawnProjectile()
        spawnEnemy()
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
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in touches {
            
            let touchLocation = touch.locationInNode(self)
            if isAlive {
                
                player?.position.x = touchLocation.x
            }
            
            // we will move things, not destroy them
            if !isAlive {
                
                player?.position.x = -200
            }
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
        
        mainLabel = SKLabelNode(fontNamed: "Futura")
        mainLabel?.fontSize = 100
        mainLabel?.fontColor = textColorHUD
        mainLabel?.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        mainLabel?.text = "Start"
        self.addChild(mainLabel!)
    }
    
    func spawnProjectile() {
        
        projectile = SKSpriteNode(color: UIColor.whiteColor(), size: CGSize(width: 20, height: 20))
        projectile!.position = CGPoint(x: (player?.position.x)!, y: (player?.position.y)!)
        projectile?.physicsBody = SKPhysicsBody(rectangleOfSize: (projectile?.size)!)
        projectile?.physicsBody?.affectedByGravity = false
        projectile?.physicsBody?.categoryBitMask = physicsCategory.projectile
        projectile?.physicsBody?.contactTestBitMask = physicsCategory.enemy
        projectile?.physicsBody?.dynamic = false
        
        // this will keep the projectile from being positioned on top of the player
        projectile?.zPosition = -1
        
        // this specific object needs to do stuff! So we program a couple of actions
        let moveForward = SKAction.moveToY(800, duration: projectileSpeed)
        let destroy = SKAction.removeFromParent()
        
        // then run the damn actions
        projectile?.runAction(SKAction.sequence([moveForward, destroy]))
        
        addChild(projectile!)
    }
    
    func spawnEnemy() {
        
        enemy = SKSpriteNode(color: UIColor.redColor(), size: CGSize(width: 80, height: 80))
        enemy!.position = CGPoint(x: Int(arc4random_uniform(1000) + 300), y: 1000)
        
        enemy?.physicsBody = SKPhysicsBody(rectangleOfSize: enemy!.size)
        enemy?.physicsBody?.affectedByGravity = false
        enemy?.physicsBody?.categoryBitMask = physicsCategory.enemy
        enemy?.physicsBody?.contactTestBitMask = physicsCategory.projectile
        // this will eliminate rotation due to collision
        enemy?.physicsBody?.allowsRotation = false
        enemy?.physicsBody?.dynamic = true
        
        // there's a reason we make this a var here...
        var moveForward = SKAction.moveToY(-100, duration: enemySpeed)
        let destroy = SKAction.removeFromParent()
        
        enemy?.runAction(SKAction.sequence([moveForward, destroy]))
        
        self.addChild(enemy!)
    }
    
    func fireProjectile() {
        
        // a wait timer!
        let fireProjectileTimer = SKAction.waitForDuration(fireProjectileRate)
        
        // an action!
        let spawn = SKAction.runBlock {
        
            self.spawnProjectile()
        }
        
        // put them together for an action sequence
        let sequence = SKAction.sequence([fireProjectileTimer, spawn])
        
        // run the action sequence
        self.runAction(SKAction.repeatActionForever(sequence))
    }
    
    func randomEnemyTimerSpawn() {
        
        let spawnEnemyTimer = SKAction.waitForDuration(enemySpawnRate)
        let spawn = SKAction.runBlock {
            
            self.spawnEnemy()
        }
        let sequence = SKAction.sequence([spawnEnemyTimer, spawn])
        self.runAction(SKAction.repeatActionForever(sequence))
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
