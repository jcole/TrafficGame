//
//  RoadMap.swift
//  TrafficGame
//
//  Created by Jeff on 3/16/16.
//  Copyright © 2016 JeffCole Inc. All rights reserved.
//

import UIKit
import SpriteKit

class RoadMap: NSObject {

  var mapCenter:CGPoint!
  var tileLayer = [[Int]]()
  let tileSize = CGSize(width:64, height:64)

  // Constants
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
  
  // MARK: Positions

  convenience init(mapCenter:CGPoint) {
    self.init()
    self.mapCenter = mapCenter
    
    tileLayer = [
      [0, 0, 2, 0, 0],
      [0, 0, 2, 0, 0],
      [1, 1, 3, 1, 1],
      [0, 0, 2, 0, 0],
      [0, 0, 2, 0, 0]
    ]
  }
  
  // MARK: Positions

  func positionForNode(col:Int, row:Int) -> CGPoint {
    let centerX:CGFloat = mapCenter.x
    let centerY:CGFloat = mapCenter.y
    
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
  
  // MARK: Add nodes
  
  func createTiles() -> [SKSpriteNode] {
    var nodes = [SKSpriteNode]()
    
    for (indexr, row) in tileLayer.enumerate() {
      for (indexc, cvalue) in row.enumerate() {
        let position = self.positionForNode(indexc, row: indexr)
        let node = self.createNode(TileType(rawValue: cvalue)!, location: position)
        nodes.append(node)
      }
    }
    
    return nodes
  }

  private func createNode(type:TileType, location:CGPoint) -> SKSpriteNode {
    let atlasTiles = SKTextureAtlas(named: "Tiles")
    let texture = atlasTiles.textureNamed(tileNames[type]!)
    
    let node = SKSpriteNode(texture: texture)
    node.size = tileSize
    node.position = location
    node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    node.zPosition = 1
    
    return node
  }
}
