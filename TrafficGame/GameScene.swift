//
//  GameScene.swift
//  TrafficGame
//
//  Created by Jeff on 3/15/16.
//  Copyright (c) 2016 JeffCole Inc. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
  
  // State
  var lastUpdateTimeInterval:NSTimeInterval?

  // Entities
  var roadMap:RoadMap!
  var cars = [CarEntity]()

  // MARK: Setup
  
  override func didMoveToView(view: SKView) {
    /* Setup your scene here */
    
    // center scene
    self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    
    // Camera
    let myCamera = SKCameraNode()
    myCamera.setScale(0.75)
    addChild(myCamera)
    self.camera = myCamera
    
    // Set up tiles
    setRoadMap()
    addCar()
  }

  // MARK: Add tiles
  
  func setRoadMap() {
    roadMap = RoadMap(mapCenter: CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame)))
    let tiles = roadMap.createTiles()
    for tile in tiles {
      self.addChild(tile)
    }
  }

  // MARK: Cars
  
  func addCar() {
    let car = CarEntity()
    let position = roadMap.positionForNode(4, row: 2)
    car.setPosition(position)
    car.node.zPosition = 2
    
    self.cars.append(car)
    self.addChild(car.node)
  }
  
  // MARK: Update cycle
  
  override func update(currentTime: NSTimeInterval) {
    super.update(currentTime)
    
    // No updates to perform if this scene isn't being rendered
    guard view != nil else { return }
    
    // Calculate the amount of time since update was last called
    if lastUpdateTimeInterval == nil {
      lastUpdateTimeInterval = currentTime
      return
    }
    
    let deltaTime = currentTime - lastUpdateTimeInterval!
    lastUpdateTimeInterval = currentTime
    
    for car in cars {
      car.updateWithDeltaTime(deltaTime)
    }
  }
  
  // MARK: Touches
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    /* Called when a touch begins */
  }
  
}
