//
//  TitleScene.swift
//  SimpleShooter
//
//  Created by Elber Carneiro on 5/1/16.
//  Copyright © 2016 Elber Carneiro. All rights reserved.
//

import Foundation
import SpriteKit

class TitleScene : SKScene {
    
    var buttonPlay : UIButton!
    var gameTitle : UILabel!
    
    var textColorHUD = UIColor(colorLiteralRed: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
    
    override func didMoveToView(view: SKView) {
        
        self.backgroundColor = UIColor.purpleColor()
        
        setUpText()
    }
    
    func setUpText() {
        
        buttonPlay = UIButton(frame: CGRect(x: 100, y: 100, width: 400, height: 100))
        buttonPlay.center = CGPoint(x: view!.frame.size.width / 2, y: 600)
        buttonPlay.titleLabel?.font = UIFont(name: "Futura", size: 60)
        buttonPlay.setTitle("Play!", forState: UIControlState.Normal)
        buttonPlay.setTitleColor(textColorHUD, forState: UIControlState.Normal)
        buttonPlay.addTarget(self, action: #selector(TitleScene.playTheGame), forControlEvents: UIControlEvents.TouchUpInside)
        self.view?.addSubview(buttonPlay)
        
        gameTitle = UILabel(frame: CGRect(x: 0, y: 0, width: view!.frame.width, height: 300))
        gameTitle.textColor = textColorHUD
        gameTitle.font = UIFont(name: "Futura", size: 60)
        gameTitle.textAlignment = NSTextAlignment.Center
        gameTitle.text = "BLOCK SHOOTER"
        self.view?.addSubview(gameTitle)
    }
    
    func playTheGame() {
        
        
    }
}
