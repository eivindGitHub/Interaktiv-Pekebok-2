//
//  CastleHallScene.h
//  Interaktiv Pekebok 2 iOS
//
//  Created by Eivind Aanestad on 17.03.2019.
//  Copyright © 2019 Eivind Aanestad. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <AVFoundation/AVFoundation.h>
#import "GameScene.h"
#import "IslandScene.h"
#import "FarmScene.h"

static const int wagonposmax = 4;
static const int wagonposmin = 0;
static const int fallingHitCat = 1;
static const int wagonHitCat = 2;

@interface CastleHallScene : SKScene <SKPhysicsContactDelegate>

+ (CastleHallScene *)newGameScene;

@end

