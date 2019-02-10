//
//  GameScene.m
//  Interaktiv Pekebok 2 Shared
//
//  Created by Eivind Aanestad on 09.02.2019.
//  Copyright © 2019 Eivind Aanestad. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene {
    SKShapeNode *_spinnyNode;
    SKLabelNode *_label;
    SKShapeNode *_snowball1;
    SKShapeNode *_snowball1_sing;
    SKShapeNode *_touchednode;
}

+ (GameScene *)newGameScene {
    // Load 'GameScene.sks' as an SKScene.
    GameScene *scene = (GameScene *)[SKScene nodeWithFileNamed:@"GameScene"];
    if (!scene) {
        NSLog(@"Failed to load GameScene.sks");
        abort();
    }
    
    // Set the scale mode to scale to fit the window
    scene.scaleMode = SKSceneScaleModeAspectFit;
    return scene;
}

- (void)setUpScene {
    _snowball1 = (SKShapeNode *)[self childNodeWithName:@"//snowball1"];
    _snowball1_sing = (SKShapeNode *)[self childNodeWithName:@"//snowball1_sing"];

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
    [_label runAction:[SKAction actionNamed:@"Pulse"] withKey:@"fadeInOut"];
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
    
    // Detects which node was touched by utilizing names.
    for (SKAudioNode *an in touchedNode.children) {
        if(an != nil && [an isKindOfClass:[SKAudioNode class]]) {
            NSString *mystring = touchedNode.name;
            NSString *mystringsing = [mystring stringByAppendingString:@"_sing"];
            SKTexture *tex1 = [SKTexture textureWithImageNamed:mystring];
            SKTexture *tex2 = [SKTexture textureWithImageNamed:mystringsing];
            [touchedNode runAction:[SKAction animateWithTextures:@[tex2,tex1] timePerFrame:0.5 resize:YES restore:NO]];
            [an runAction:[SKAction playSoundFileNamed: an.name waitForCompletion:NO]];
        }
    }
    if ([touchedNode.name isEqualToString:@"snowball1_sing"]) {
        NSLog(@"Touched singing snowball");
    }
    if ([touchedNode.name isEqualToString:@"Player Character"]) {
        NSLog(@"Touched player");
    }
    if ([touchedNode.name isEqualToString:@"Test Node"]) {
        NSLog(@"Touched test node");
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
