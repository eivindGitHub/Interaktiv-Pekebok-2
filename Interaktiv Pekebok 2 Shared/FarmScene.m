//
//  FarmScene.m
//  Interaktiv Pekebok 2 iOS
//
//  Created by Eivind Aanestad on 22.02.2019.
//  Copyright © 2019 Eivind Aanestad. All rights reserved.
//

#import "FarmScene.h"

@implementation FarmScene{
    bool isMusic;
    AVAudioPlayer *musicplayer;
    GameScene *_newScene;
    IslandScene *_islandscene;
    double lasttime;
    double elapsedtime;
    double farstarage;
    SKShapeNode *_farmnode;
    SKSpriteNode *_bubblenode;
}

+(FarmScene *)newGameScene {
    // Load 'GameScene.sks' as an SKScene.
    FarmScene *scene = (FarmScene *)[SKScene nodeWithFileNamed:@"FarmScene"];
    if (!scene) {
        NSLog(@"Failed to load FarmScene,sks");
        abort();
    }
    
    // Set the scale mode to scale to fit the window
    scene.scaleMode = SKSceneScaleModeAspectFit;
    NSLog(@"FarmScene.sks load success");
    return scene;
}

-(void)setUpScene {
    lasttime = 0;
    elapsedtime = 0;
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                         pathForResource:@"bgmusic_tellepic"
                                         ofType:@"mp3"]];
    musicplayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    musicplayer.numberOfLoops = -1;
    _farmnode = (SKShapeNode *)[self childNodeWithName:@"farmnode"];

    _bubblenode = [SKSpriteNode spriteNodeWithImageNamed:@"saapeboble_blaa"];
    _bubblenode.physicsBody.collisionBitMask = 0;
    CGSize bubblesize = CGSizeMake(1, 1);
    [_bubblenode setSize:bubblesize];
    [_bubblenode setZPosition:1];
    [musicplayer play];
    
#if TARGET_OS_WATCH
    // For watch we just periodically create one of these and let it spin
    // For other platforms we let user touch/mouse events create these
    
#endif
}

#if TARGET_OS_WATCH
-(void)sceneDidLoad {
    [self setUpScene];
}
#else
-(void)didMoveToView:(SKView *)view {
    [self setUpScene];
}
#endif
-(void)spawnBubble{
    SKShapeNode *bubble = [_bubblenode copy];
    int xpos = 200;
    int ypos = 200;
    int speed = (arc4random() % (50+1)) + 100;
    CGPoint pos = CGPointMake(xpos, ypos);
    CGVector vector = CGVectorMake(1500, 0);
    bubble.position = pos;
    SKAction *growbubble = [SKAction resizeByWidth:60 height:60 duration:2];
    SKAction *movebubble = [SKAction moveBy:vector duration:speed];
    SKAction *killbubble = [SKAction removeFromParent];
    SKAction *bubbleseq = [SKAction sequence:@[growbubble, movebubble, killbubble]];
    [bubble runAction:bubbleseq];
    [self addChild:bubble];
}
-(void)update:(CFTimeInterval)currentTime {
    // Called before each frame is rendered
    elapsedtime = currentTime - lasttime;

    if(elapsedtime > 1){
        [self spawnBubble];
        lasttime = currentTime;
    }
}

#if TARGET_OS_IOS || TARGET_OS_TV
// Touch-based event handling

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    [self handleTouchedPoint:location];
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    
}
- (void)handleTouchedPoint:(CGPoint)touchedPoint {
    //SKSpriteNode *touchedNode = (SKSpriteNode *)[self nodeAtPoint:touchedPoint];

    NSLog(@"Touched node");
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
