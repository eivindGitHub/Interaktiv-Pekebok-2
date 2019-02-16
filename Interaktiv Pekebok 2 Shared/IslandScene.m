//
//  IslandScene.m
//  Interaktiv Pekebok 2 iOS
//
//  Created by Eivind Aanestad on 14.02.2019.
//  Copyright © 2019 Eivind Aanestad. All rights reserved.
//

#import "IslandScene.h"

@implementation IslandScene{

    bool isMusic;
    AVAudioPlayer *musicplayer;
    GameScene *_newScene;
}

+ (IslandScene *)newGameScene {
    // Load 'GameScene.sks' as an SKScene.
    IslandScene *scene = (IslandScene *)[SKScene nodeWithFileNamed:@"IslandScene"];
    if (!scene) {
        NSLog(@"Failed to load IslandScene,sks");
        abort();
    }
    
    // Set the scale mode to scale to fit the window
    scene.scaleMode = SKSceneScaleModeAspectFit;
    return scene;
}

- (void)setUpScene {
 
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                         pathForResource:@"castle_music2"
                                         ofType:@"mp3"]];
    musicplayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    musicplayer.numberOfLoops = -1;
    
#if TARGET_OS_WATCH
    // For watch we just periodically create one of these and let it spin
    // For other platforms we let user touch/mouse events create these
    
#endif
}

#if TARGET_OS_WATCH
- (void)sceneDidLoad {
    [self setUpScene];
}
#else
- (void)didMoveToView:(SKView *)view {
    [self setUpScene];
}
#endif

- (void)makeSpinnyAtPoint:(CGPoint)pos color:(SKColor *)color {
    
}

-(void)update:(CFTimeInterval)currentTime {
    // Called before each frame is rendered
}

#if TARGET_OS_IOS || TARGET_OS_TV
// Touch-based event handling

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    [self handleTouchedPoint:location];
    
    for (UITouch *t in touches) {
        [self makeSpinnyAtPoint:[t locationInNode:self] color:[SKColor greenColor]];
    }
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch *t in touches) {
        [self makeSpinnyAtPoint:[t locationInNode:self] color:[SKColor blueColor]];
    }
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *t in touches) {
        [self makeSpinnyAtPoint:[t locationInNode:self] color:[SKColor redColor]];
    }
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *t in touches) {
        [self makeSpinnyAtPoint:[t locationInNode:self] color:[SKColor redColor]];
    }
}
- (void)handleTouchedPoint:(CGPoint)touchedPoint {
    SKSpriteNode *touchedNode = (SKSpriteNode *)[self nodeAtPoint:touchedPoint];
    
    // arrows
    if ([touchedNode.name isEqualToString:@"arrow_l"]) {
        SKTransition *reveal = [SKTransition revealWithDirection:SKTransitionDirectionDown duration:1.0];
        GameScene *_newScene = [GameScene newGameScene];
        [self.scene.view presentScene: _newScene];
        NSLog(@"Touched left arrow");
    }
    else if([touchedNode.name rangeOfString:@"icon"].location != NSNotFound){
        for (SKAudioNode *an in touchedNode.children) {
            NSString *mystring = touchedNode.name;
            NSString *mystringred = [mystring stringByAppendingString:@"red"];
            SKTexture *tex1 = [SKTexture textureWithImageNamed:mystring];
            SKTexture *tex2 = [SKTexture textureWithImageNamed:mystringred];
            [touchedNode runAction:[SKAction animateWithTextures:@[tex2,tex1] timePerFrame:0.5 resize:NO restore:NO]];
            [an runAction:[SKAction playSoundFileNamed: an.name waitForCompletion:NO]];
            NSLog(@"Touched number");
        }
    }

}
#endif

#if TARGET_OS_OSX
// Mouse-based event handling

- (void)mouseDown:(NSEvent *)event {
    [_label runAction:[SKAction actionNamed:@"Pulse"] withKey:@"fadeInOut"];
    
    [self makeSpinnyAtPoint:[event locationInNode:self] color:[SKColor greenColor]];
}

- (void)mouseDragged:(NSEvent *)event {
    [self makeSpinnyAtPoint:[event locationInNode:self] color:[SKColor blueColor]];
}

- (void)mouseUp:(NSEvent *)event {
    [self makeSpinnyAtPoint:[event locationInNode:self] color:[SKColor redColor]];
}

#endif
@end
