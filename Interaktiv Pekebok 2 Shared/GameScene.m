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
    [_snowball1 runAction:[SKAction repeatAction:[SKAction rotateByAngle:M_PI duration:1] count:10]];
    _snowball1_sing = (SKShapeNode *)[self childNodeWithName:@"//snowball1_sing"];
    [_snowball1_sing setHidden:true];
    // Get label node from scene and store it for use later
    _label = (SKLabelNode *)[self childNodeWithName:@"//helloLabel"];
    _label.alpha = 0.0;
    [_label runAction:[SKAction fadeInWithDuration:2.0]];
    
    // Create shape node to use during mouse interaction
    CGFloat w = (self.size.width + self.size.height) * 0.05;
    _spinnyNode = [SKShapeNode shapeNodeWithRectOfSize:CGSizeMake(w, w) cornerRadius:w * 0.3];
    
    

#if TARGET_OS_WATCH
    // For watch we just periodically create one of these and let it spin
    // For other platforms we let user touch/mouse events create these
    _spinnyNode.position = CGPointMake(0.0, 0.0);
    _spinnyNode.strokeColor = [SKColor redColor];
    [self runAction:[SKAction repeatActionForever:[SKAction sequence:@[
        [SKAction waitForDuration:2.0],
        [SKAction runBlock:^{
            [self addChild:[_spinnyNode copy]];
        }]
    ]]]];
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
    SKNode *touchedNode = [self nodeAtPoint:touchedPoint];
    
    // Detects which node was touched by utilizing names.
    if ([touchedNode.name isEqualToString:@"snowball1"]) {
        NSLog(@"Touched snowball");
        SKAudioNode *_H_a = (SKAudioNode *)[touchedNode childNodeWithName:@"H_a"];
        [_H_a runAction:[SKAction playSoundFileNamed:_H_a.name waitForCompletion:NO]];
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
