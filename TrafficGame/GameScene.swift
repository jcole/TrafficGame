//
//  GameScene.swift
//  TrafficGame
//
//  Created by Jeff on 3/15/16.
//  Copyright (c) 2016 JeffCole Inc. All rights reserved.
//

import SpriteKit

enum TileType:Int {
  case Terrain = 0
  case Horizontal = 1
  case Vertical = 2
  case Intersection = 3
}

let tileNames:[TileType : String] = [
  TileType.Terrain : "terrainTile3",
  TileType.Horizontal: "roadTile6.png",
  TileType.Vertical: "roadTile27.png",
  TileType.Intersection: "roadTile5.png",
]

class GameScene: SKScene {
  
  // Tiles
  var tileLayer = [[Int]]()
  let tileSize = CGSize(width:64, height:64)
  
  // State
  var lastUpdateTimeInterval:NSTimeInterval?

  // Entities
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
    setTileMap()
    addTiles()
    addCar()
  }

  // MARK: Positions
  
  func positionForNode(col:Int, row:Int) -> CGPoint {
    let centerX:CGFloat = CGRectGetMidX(self.frame)
    let centerY:CGFloat = CGRectGetMidY(self.frame)
    
    let numRows = tileLayer.count
    let numCol = tileLayer[0].count
    
    let mapWidth:CGFloat = CGFloat(numCol) * tileSize.width
    let mapHeight:CGFloat = CGFloat(numRows) * tileSize.height
    
    let xOffset:CGFloat = mapWidth / 2.0 - tileSize.width / 2.0
    let yOffset:CGFloat = mapHeight / 2.0 - tileSize.height / 2.0
    
    let x:CGFloat = centerX + tileSize.width * CGFloat(col) - xOffset
    let y:CGFloat = centerY + tileSize.height * CGFloat(-row) + yOffset

    return CGPoint(x: x, y: y)
  }

  // MARK: Add tiles
  
  func setTileMap() {
    tileLayer = [
      [0, 0, 2, 0, 0],
      [0, 0, 2, 0, 0],
      [1, 1, 3, 1, 1],
      [0, 0, 2, 0, 0],
      [0, 0, 2, 0, 0]
    ]
  }
  
  func addTiles() {
    for (indexr, row) in tileLayer.enumerate() {
      for (indexc, cvalue) in row.enumerate() {
        let position = self.positionForNode(indexc, row: indexr)
        let node = self.createTileNode(TileType(rawValue: cvalue)!, location: position)
        addChild(node)
      }
    }
  }
  
  func createTileNode(type:TileType, location:CGPoint) -> SKSpriteNode {
    let atlasTiles = SKTextureAtlas(named: "Tiles")
    let texture = atlasTiles.textureNamed(tileNames[type]!)

    let node = SKSpriteNode(texture: texture)
    node.size = tileSize
    node.position = location
    node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    node.zPosition = 1
    
    return node
  }
  
  // MARK: Cars
  
  func addCar() {
    let car = CarEntity()
    let position = self.positionForNode(4, row: 2)
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
