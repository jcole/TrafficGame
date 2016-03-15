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
  
  var tileLayer = [[Int]]()
  let tileSize = CGSize(width:64, height:64)
  
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
  }
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    /* Called when a touch begins */
  }
  
  override func update(currentTime: CFTimeInterval) {
    /* Called before each frame is rendered */
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
    let centerX:CGFloat = CGRectGetMidX(self.frame)
    let centerY:CGFloat = CGRectGetMidY(self.frame)

    let numRows = tileLayer.count
    let numCol = tileLayer[0].count
    
    let mapWidth:CGFloat = CGFloat(numCol) * tileSize.width
    let mapHeight:CGFloat = CGFloat(numRows) * tileSize.height
    
    let xOffset:CGFloat = mapWidth / 2.0 - tileSize.width / 2.0
    let yOffset:CGFloat = mapHeight / 2.0 - tileSize.height / 2.0
    
    for (indexr, row) in tileLayer.enumerate() {
      for (indexc, cvalue) in row.enumerate() {
        let x:CGFloat = centerX + tileSize.width * CGFloat(indexc) - xOffset
        let y:CGFloat = centerY + tileSize.height * CGFloat(-indexr) + yOffset
      
        self.createNodeOf(TileType(rawValue: cvalue)!, location: CGPoint(x: x, y: y))
      }
    }
  }
  
  func createNodeOf(type:TileType, location:CGPoint) {
    let atlasTiles = SKTextureAtlas(named: "Tiles")
    let texture = atlasTiles.textureNamed(tileNames[type]!)

    let node = SKSpriteNode(texture: texture)
    node.size = tileSize
    node.position = location
    node.zPosition = 1
    addChild(node)
  }
  
}
