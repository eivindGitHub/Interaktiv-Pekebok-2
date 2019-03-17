//
//  CastleHallScene.m
//  Interaktiv Pekebok 2 iOS
//
//  Created by Eivind Aanestad on 17.03.2019.
//  Copyright © 2019 Eivind Aanestad. All rights reserved.
//

#import "CastleHallScene.h"

@implementation CastleHallScene{
    bool isMusic;
    AVAudioPlayer *musicplayer;
    GameScene *_newScene;
    IslandScene *_islandscene;
    double lasttime;
    double elapsedtime;
    
    SKShapeNode *castlehallnode;
    SKSpriteNode *wagonnode;
    
    CGPoint _wagonposs[5];
    CGPoint wagonposs0;
    CGPoint wagonposs1;
    CGPoint wagonposs2;
    CGPoint wagonposs3;
    CGPoint wagonposs4;
    
    NSArray *_wagonarms;
    SKSpriteNode *wagonarm0;
    SKSpriteNode *wagonarm1;
    SKSpriteNode *wagonarm2;
    SKSpriteNode *wagonarm3;
    SKSpriteNode *wagonarm4;
    
    int wagonpos; // 0, 1, 2, 3, 4
    bool statechanged;
}

+(CastleHallScene *)newGameScene {
    // Load 'GameScene.sks' as an SKScene.
    CastleHallScene *scene = (CastleHallScene *)[SKScene nodeWithFileNamed:@"CastleHallScene"];
    if (!scene) {
        NSLog(@"Failed to load CastleHallScene.sks");
        abort();
    }
    // Set the scale mode to scale to fit the window
    scene.scaleMode = SKSceneScaleModeAspectFit;
    NSLog(@"CastleHallScene load success");
    return scene;
}

-(void)setUpScene {
    lasttime = 0;
    elapsedtime = 0;
    wagonpos = 0;
    statechanged = false;
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                         pathForResource:@"bgmusic_tellepic"
                                         ofType:@"mp3"]];
    musicplayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    musicplayer.numberOfLoops = -1;
    castlehallnode = (SKShapeNode *)[self childNodeWithName:@"castlehallnode"];
    wagonnode = (SKSpriteNode*) [castlehallnode childNodeWithName:@"//wagon"];

    wagonarm0 = (SKSpriteNode*) [castlehallnode childNodeWithName:@"wagonarm0"];
    wagonarm1 = (SKSpriteNode*) [castlehallnode childNodeWithName:@"wagonarm1"];
    wagonarm2 = (SKSpriteNode*) [castlehallnode childNodeWithName:@"wagonarm2"];
    wagonarm3 = (SKSpriteNode*) [castlehallnode childNodeWithName:@"wagonarm3"];
    wagonarm4 = (SKSpriteNode*) [castlehallnode childNodeWithName:@"wagonarm4"];
    [wagonarm0 setHidden:false];
    [wagonarm1 setHidden:true];
    [wagonarm2 setHidden:true];
    [wagonarm3 setHidden:true];
    [wagonarm4 setHidden:true];
    _wagonarms = [NSArray arrayWithObjects:wagonarm0,wagonarm1,wagonarm2,wagonarm3,wagonarm4, nil];
    
    wagonposs0 = CGPointMake(40, 500);
    wagonposs1 = CGPointMake(186, 500);
    wagonposs2 = CGPointMake(336, 500);
    wagonposs3 = CGPointMake(486, 500);
    wagonposs4 = CGPointMake(636, 500);
    _wagonposs[0] = wagonposs0;
    _wagonposs[1] = wagonposs1;
    _wagonposs[2] = wagonposs2;
    _wagonposs[3] = wagonposs3;
    _wagonposs[4] = wagonposs4;
    wagonnode.position = wagonposs0;
    
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

-(void)update:(CFTimeInterval)currentTime {
    // Called before each frame is rendered
    elapsedtime = currentTime - lasttime;
    if(elapsedtime > 1){
        lasttime = currentTime;
    }
    if(statechanged){
        [self wagonStateChanged];
    }
}

-(void)wagonStateChanged{
    NSLog(@"Wagon position changed");
    statechanged = false;
    wagonnode.position = _wagonposs[wagonpos];
    for(NSUInteger i = 0; i <= wagonposmax; i++){
        if(i == wagonpos){
            [[_wagonarms objectAtIndex:i] setHidden:false];
        }
        else{
            [[_wagonarms objectAtIndex:i] setHidden:true];
        }
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
    
    //Pressed left
    if([touchedNode.name rangeOfString:@"dummyarrowleft"].location != NSNotFound){
        for (SKAudioNode *an in touchedNode.children) {
            [an runAction:[SKAction playSoundFileNamed: an.name waitForCompletion:NO]];
        }
        if(wagonpos > 0){
            wagonpos = wagonpos - 1;
            statechanged = true;
        }
        NSLog(@"Pressed left");
    }
    //Pressed left
    if([touchedNode.name rangeOfString:@"dummyarrowright"].location != NSNotFound){
        for (SKAudioNode *an in touchedNode.children) {
            [an runAction:[SKAction playSoundFileNamed: an.name waitForCompletion:NO]];
        }
        if(wagonpos < 4){
            wagonpos = wagonpos + 1;
            statechanged = true;
        }
        NSLog(@"Pressed right");
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

