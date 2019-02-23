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
    NSUInteger currentcolor; // 0 rød 1 grønn 2 blå 3 gul 4 rosa 5 orange 6 lilla 7 brun
    SKShapeNode *_farmnode;
    SKSpriteNode *_bubblenode;
    SKSpriteNode *_bubble_red;
    SKSpriteNode *_bubble_green;
    SKSpriteNode *_bubble_blue;
    SKSpriteNode *_bubble_yellow;
    SKSpriteNode *_bubble_brown;
    SKSpriteNode *_bubble_lilac;
    SKSpriteNode *_bubble_orange;
    SKSpriteNode *_bubble_pink;
    NSArray *_bubbles;
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
    currentcolor = 1;
    CGSize bubblesize = CGSizeMake(1, 1);
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                         pathForResource:@"bgmusic_tellepic"
                                         ofType:@"mp3"]];
    musicplayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    musicplayer.numberOfLoops = -1;
    _farmnode = (SKShapeNode *)[self childNodeWithName:@"farmnode"];
    _bubble_red = [SKSpriteNode spriteNodeWithImageNamed:@"saapeboble_roed"];
    _bubble_green = [SKSpriteNode spriteNodeWithImageNamed:@"saapeboble_groenn"];
    _bubble_blue = [SKSpriteNode spriteNodeWithImageNamed:@"saapeboble_blaa"];
    _bubble_yellow = [SKSpriteNode spriteNodeWithImageNamed:@"saapeboble_gul"];
    _bubble_brown = [SKSpriteNode spriteNodeWithImageNamed:@"saapeboble_brun"];
    _bubble_lilac = [SKSpriteNode spriteNodeWithImageNamed:@"saapeboble_lilla"];
    _bubble_orange = [SKSpriteNode spriteNodeWithImageNamed:@"saapeboble_orange"];
    _bubble_pink = [SKSpriteNode spriteNodeWithImageNamed:@"saapeboble_rosa"];
    _bubbles = [NSArray arrayWithObjects:_bubble_red,_bubble_blue,_bubble_green,_bubble_yellow, _bubble_pink, _bubble_orange, _bubble_lilac, _bubble_brown, nil];
    for(SKSpriteNode *bbl in _bubbles){
        [bbl setSize:bubblesize];
        [bbl setZPosition:1];
        [bbl setName:@"poppable"];
    }

    _bubblenode = [SKSpriteNode spriteNodeWithImageNamed:@"saapeboble_blaa"];
    _bubblenode.physicsBody.collisionBitMask = 0;
    
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
    SKShapeNode *bubble = [[_bubbles objectAtIndex:currentcolor] copy];
    int boyorgirl = (arc4random() % (10)) + 1;
    int xstartpos = 210;
    int ystartpos = 245;
    if(boyorgirl % 2 == 0){
        xstartpos = 210;
        ystartpos = 245;
    }
    else{
        xstartpos = 140;
        ystartpos = 150;
    }
    int xend = (arc4random() % (2000)) + xstartpos + 100;
    int yend = 1000;
    int xcontrol = (xend-xstartpos)/2;
    int ycontrol = ystartpos;
    int speed = (arc4random() % (100+1)) + 10;
    CGFloat growthduration = 50 / (CGFloat)speed;
    CGPoint posstart = CGPointMake(xstartpos, ystartpos);
    CGPoint posend = CGPointMake(xend, yend);
    CGPoint poscontrol = CGPointMake(xcontrol, ycontrol);
    bubble.position = posstart;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointZero];
    [path addQuadCurveToPoint:posend controlPoint:poscontrol];
    SKAction *growbubble = [SKAction resizeByWidth:60 height:60 duration:growthduration];
    SKAction *movebubble = [SKAction followPath:path.CGPath speed:speed];
    SKAction *killbubble = [SKAction removeFromParent];
    SKAction *bubbleseq = [SKAction sequence:@[movebubble, killbubble]];
    SKAction *bubblepar = [SKAction group:@[growbubble, bubbleseq]];
    [bubble runAction:bubblepar];
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
    SKSpriteNode *touchedNode = (SKSpriteNode *)[self nodeAtPoint:touchedPoint];
    if([touchedNode.name rangeOfString:@"saapeboble"].location != NSNotFound){
        for (SKAudioNode *an in touchedNode.children) {
            [an runAction:[SKAction playSoundFileNamed: an.name waitForCompletion:NO]];
        }
        currentcolor = [touchedNode.userData[@"userData1"] intValue];
        [self spawnBubble];
    }
    else if([touchedNode.name rangeOfString:@"poppable"].location != NSNotFound){
        [touchedNode runAction:[SKAction playSoundFileNamed:@"sfx_bubblepop" waitForCompletion:NO]];
        [touchedNode runAction:[SKAction removeFromParent]];
    }
    // arrows
    else if ([touchedNode.name rangeOfString:@"arrow_r"].location != NSNotFound) {
        SKTransition *flipz = [SKTransition flipVerticalWithDuration:2.0];
        GameScene *_newScene = [GameScene newGameScene];
        [self.scene.view presentScene: _newScene transition:flipz];
        NSLog(@"Touched arrow");
    }
    else if ([touchedNode.name rangeOfString:@"arrow_l"].location != NSNotFound) {
        SKTransition *flipz = [SKTransition flipVerticalWithDuration:2.0];
        IslandScene *_newScene = [IslandScene newGameScene];
        [self.scene.view presentScene: _newScene transition:flipz];
        NSLog(@"Touched arrow");
    }
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
