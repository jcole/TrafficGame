//
//  CarEntity.swift
//  TrafficGame
//
//  Created by Jeff on 3/16/16.
//  Copyright © 2016 JeffCole Inc. All rights reserved.
//

import UIKit
import GameKit

class CarEntity: GKEntity, GKAgentDelegate {

  var node:SKSpriteNode!
  var agent:GKAgent2D!

  // MARK: Init
  override init() {
    super.init()
    
    setupNode()
    setupAgent()
  }
  
  // MARK: Node
  
  func setupNode() {
    let texture = SKTexture(imageNamed: "Car Red")
    let carSize = CGSize(width:71 / 5.0, height:131 / 5.0)
    self.node = SKSpriteNode(texture: texture, size: carSize)
    self.node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
  }
  
  // MARK: Agent
  
  func setupAgent() {
    agent = GKAgent2D()
    agent.delegate = self
    agent.maxSpeed = 40.0
    agent.maxAcceleration = 5.0
    addComponent(agent!)
  }
  
  // MARK: GKAgentDelegate methods
  
  func agentWillUpdate(agent:GKAgent) {
    
  }
  
  func agentDidUpdate(agent:GKAgent) {
    self.node.zRotation = CGFloat(self.agent.rotation)
    self.node.position = CGPoint(position:self.agent.position)
  }
  
  // MARK: Public methods
  
  func setPosition(position:CGPoint) {
    node.position = position
    agent.position = position.toVector2()
  }
  
}
