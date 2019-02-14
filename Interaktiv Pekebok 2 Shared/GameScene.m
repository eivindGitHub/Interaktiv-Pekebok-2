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
    SKShapeNode *_leverup;
    SKShapeNode *_leverdown;
    SKShapeNode *_princess;
    SKShapeNode *_musearm;
    SKShapeNode *_snakkeboble;
    SKShapeNode *_snakkeboble_prins;
    SKAction *unhidebubble;
    SKAction *waitbubble;
    SKAction *waitbubble2;
    SKAction *hidebubble;
    SKAction *hidesequence;
    SKAction *bubblesequence2;
    NSArray *_cameras;
    SKTexture *camera0;
    SKTexture *camera1;
    SKTexture *camera2;
    SKTexture *camera3;
    SKTexture *camera4;
    SKTexture *camera5;
    SKTexture *camera6;
    SKTexture *camera7;
    SKTexture *camera8;
    SKTexture *camera9;
    SKTexture *camera10;
    SKTexture *camera11;
    SKTexture *camera12;
    SKTexture *camera13;
    
    NSArray *_speakers;
    SKTexture *castle_speaker0;
    SKTexture *castle_speaker1;
    SKTexture *castle_speaker2;
    SKTexture *castle_speaker3;
    SKTexture *castle_speaker4;
    SKTexture *castle_speaker5;
    SKTexture *castle_speaker6;
    SKTexture *castle_speaker7;
    SKTexture *castle_speaker8;
    SKTexture *castle_speaker9;
    SKShapeNode *_touchednode;
    
    SKTexture *letterA; SKTexture *letterE; SKTexture *letterI;
    SKTexture *letterO; SKTexture *letterU; SKTexture *letterY;
    SKTexture *letterAE; SKTexture *letterOE; SKTexture *letterAA;
    SKTexture *letterA_off; SKTexture *letterE_off; SKTexture *letterI_off;
    SKTexture *letterO_off; SKTexture *letterU_off; SKTexture *letterY_off;
    SKTexture *letterAE_off; SKTexture *letterOE_off; SKTexture *letterAA_off;
    SKShapeNode *letternodeA; SKShapeNode *letternodeE; SKShapeNode *letternodeI;
    SKShapeNode *letternodeO; SKShapeNode *letternodeU; SKShapeNode *letternodeY;
    SKShapeNode *letternodeAE; SKShapeNode *letternodeOE; SKShapeNode *letternodeAA;
    NSArray *_letternodes;
    
    SKShapeNode *_blockbottom;
    SKShapeNode *_blocktop;
    CGFloat top;
    CGFloat bottom;
    SKShapeNode *_gate;
    
    SKShapeNode *_arrow_right;
    SKShapeNode *_arrow_left;
    IslandScene *_newScene;
    NSString *_currentletter;
    bool isMusic;
    AVAudioPlayer *musicplayer;
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
    _arrow_right = (SKShapeNode *)[self childNodeWithName:@"//arrow_right"];
    _leverup = (SKShapeNode *)[self childNodeWithName:@"//castle_lever_up"];
    [_leverup setHidden:true];
    _leverdown = (SKShapeNode *)[self childNodeWithName:@"//castle_lever_down"];
    [_leverdown setHidden:false];
    _princess = (SKShapeNode *)[self childNodeWithName:@"//princessdummy"];
    _musearm = (SKShapeNode *)[self childNodeWithName:@"//musearm"];
    [_musearm setUserInteractionEnabled:NO];
    _snakkeboble = (SKShapeNode *)[self childNodeWithName:@"//snakkeboble"];
    [_snakkeboble setHidden:true];
    _snakkeboble_prins = (SKShapeNode *)[self childNodeWithName:@"//snakkeboble_prins"];
    [_snakkeboble_prins setHidden:true];
    unhidebubble = [SKAction unhide];
    waitbubble = [SKAction waitForDuration:0.5];
    waitbubble2 = [SKAction waitForDuration:2.0];
    hidebubble = [SKAction hide];
    hidesequence = [SKAction sequence:@[unhidebubble, waitbubble, hidebubble]];
    bubblesequence2 = [SKAction sequence:@[unhidebubble, waitbubble2, hidebubble]];
    _currentletter = @"a";
    _blocktop = (SKShapeNode *)[self childNodeWithName:@"//blocktop"];
    _blockbottom = (SKShapeNode *)[self childNodeWithName:@"//blockbottom"];
    _gate = (SKShapeNode *)[self childNodeWithName:@"//gate"];
    top = _blocktop.position.y;
    bottom = _blockbottom.position.y;
    
    camera0 = [SKTexture textureWithImageNamed:@"castlecamera0"];
    camera1 = [SKTexture textureWithImageNamed:@"castlecamera1"];
    camera2 = [SKTexture textureWithImageNamed:@"castlecamera2"];
    camera3 = [SKTexture textureWithImageNamed:@"castlecamera3"];
    camera4 = [SKTexture textureWithImageNamed:@"castlecamera4"];
    camera5 = [SKTexture textureWithImageNamed:@"castlecamera5"];
    camera6 = [SKTexture textureWithImageNamed:@"castlecamera6"];
    camera7 = [SKTexture textureWithImageNamed:@"castlecamera7"];
    camera8 = [SKTexture textureWithImageNamed:@"castlecamera8"];
    camera9 = [SKTexture textureWithImageNamed:@"castlecamera9"];
    camera10 = [SKTexture textureWithImageNamed:@"castlecamera10"];
    camera11 = [SKTexture textureWithImageNamed:@"castlecamera11"];
    camera12 = [SKTexture textureWithImageNamed:@"castlecamera12"];
    camera13 = [SKTexture textureWithImageNamed:@"castlecamera13"];
    _cameras = [NSArray arrayWithObjects:camera1,camera2,camera3,camera4,camera5,camera6,camera7,camera8,camera9,camera10,camera11,camera12,camera13,camera12,camera11,camera10,camera9,camera8,camera7,camera6,camera5,camera4,camera3,camera2,camera1,camera0, nil];
    
    castle_speaker0 = [SKTexture textureWithImageNamed:@"castle_speaker0"];
    castle_speaker1 = [SKTexture textureWithImageNamed:@"castle_speaker1"];
    castle_speaker2 = [SKTexture textureWithImageNamed:@"castle_speaker2"];
    castle_speaker3 = [SKTexture textureWithImageNamed:@"castle_speaker3"];
    castle_speaker4 = [SKTexture textureWithImageNamed:@"castle_speaker4"];
    castle_speaker5 = [SKTexture textureWithImageNamed:@"castle_speaker5"];
    castle_speaker6 = [SKTexture textureWithImageNamed:@"castle_speaker6"];
    castle_speaker7 = [SKTexture textureWithImageNamed:@"castle_speaker7"];
    castle_speaker8 = [SKTexture textureWithImageNamed:@"castle_speaker8"];
    castle_speaker9 = [SKTexture textureWithImageNamed:@"castle_speaker9"];
    _speakers = [NSArray arrayWithObjects:castle_speaker0,castle_speaker1,castle_speaker2,castle_speaker3,castle_speaker4,castle_speaker5,castle_speaker6,castle_speaker7,castle_speaker8,castle_speaker9, nil];
    
    letterA = [SKTexture textureWithImageNamed:@"letter_A"]; letterE = [SKTexture textureWithImageNamed:@"letter_E"]; letterI = [SKTexture textureWithImageNamed:@"letter_I"];
    letterO = [SKTexture textureWithImageNamed:@"letter_O"]; letterU = [SKTexture textureWithImageNamed:@"letter_U"]; letterY = [SKTexture textureWithImageNamed:@"letter_Y"];
    letterAE = [SKTexture textureWithImageNamed:@"letter_AE"]; letterOE = [SKTexture textureWithImageNamed:@"letter_OE"]; letterAA = [SKTexture textureWithImageNamed:@"letter_AA"];
    letterA_off = [SKTexture textureWithImageNamed:@"letter_A_off"]; letterE_off = [SKTexture textureWithImageNamed:@"letter_E_off"]; letterI_off = [SKTexture textureWithImageNamed:@"letter_I_off"];
    letterO_off = [SKTexture textureWithImageNamed:@"letter_O_off"]; letterU_off = [SKTexture textureWithImageNamed:@"letter_U_off"]; letterY_off = [SKTexture textureWithImageNamed:@"letter_Y_off"];
    letterAE_off = [SKTexture textureWithImageNamed:@"letter_AE_off"]; letterOE = [SKTexture textureWithImageNamed:@"letter_OE_off"]; letterAA_off = [SKTexture textureWithImageNamed:@"letter_AA_off"];
    letternodeA = (SKShapeNode *)[self childNodeWithName:@"//letter_A_off"]; letternodeE = (SKShapeNode *)[self childNodeWithName:@"//letter_E_off"]; letternodeI = (SKShapeNode *)[self childNodeWithName:@"//letter_I_off"];
    letternodeO = (SKShapeNode *)[self childNodeWithName:@"//letter_O_off"]; letternodeU = (SKShapeNode *)[self childNodeWithName:@"//letter_U_off"]; letternodeY = (SKShapeNode *)[self childNodeWithName:@"//letter_Y_off"];
    letternodeAE = (SKShapeNode *)[self childNodeWithName:@"//letter_AE_off"]; letternodeOE = (SKShapeNode *)[self childNodeWithName:@"//letter_OE_off"]; letternodeAA = (SKShapeNode *)[self childNodeWithName:@"//letter_AA_off"];
    _letternodes = [NSArray arrayWithObjects:letternodeA,letternodeE,letternodeI,letternodeO,letternodeU,letternodeY,letternodeAE,letternodeOE,letternodeAA , nil];
    
    isMusic = false;
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
    
    // Plays audio and animates touched snowball.
    if([touchedNode.name rangeOfString:@"snowball"].location != NSNotFound){
        NSString *singstring = [@"_" stringByAppendingString:_currentletter];
        int wildnumber = arc4random_uniform(7) + 1;
        NSString *wildstring = [NSString stringWithFormat:@"%d",wildnumber];
        for (SKAudioNode *an in touchedNode.children) {
            if( an != nil && [an isKindOfClass:[SKAudioNode class]] && [an.name hasSuffix:singstring] ){
                NSString *mystring = touchedNode.name;
                NSString *mystringsing = [mystring stringByAppendingString:@"_sing"];                
                SKTexture *tex1 = [SKTexture textureWithImageNamed:mystring];
                SKTexture *tex2 = [SKTexture textureWithImageNamed:mystringsing];
                [touchedNode runAction:[SKAction animateWithTextures:@[tex2,tex1] timePerFrame:0.5 resize:YES restore:NO]];
                [an runAction:[SKAction playSoundFileNamed: an.name waitForCompletion:NO]];
                NSLog(@"Touched singing snowball");
            }
            else if( an != nil && [an isKindOfClass:[SKAudioNode class]] && [an.name hasPrefix:@"wildsnowball"] && [an.name hasSuffix:wildstring] ){
                NSString *mystring = touchedNode.name;
                NSString *mystringsing = [mystring stringByAppendingString:@"_sing"];
                SKTexture *tex1 = [SKTexture textureWithImageNamed:mystring];
                SKTexture *tex2 = [SKTexture textureWithImageNamed:mystringsing];
                [touchedNode runAction:[SKAction animateWithTextures:@[tex2,tex1] timePerFrame:2.5 resize:YES restore:NO]];
                [an runAction:[SKAction playSoundFileNamed: an.name waitForCompletion:NO]];
                NSLog(@"Touched singing wild snowball");
            }
        }
    }
    // Plays audio and animates touched letter.
    else if([touchedNode.name rangeOfString:@"letter"].location != NSNotFound){
        for (SKAudioNode *an in touchedNode.children) {
            if(an != nil && [an isKindOfClass:[SKAudioNode class]]){
                for (SKSpriteNode *ln in _letternodes){
                    NSString *offstring = ln.name;
                    SKTexture *offtex = [SKTexture textureWithImageNamed:offstring];
                    [ln runAction:[SKAction setTexture:offtex]];
                }
                [an runAction:[SKAction playSoundFileNamed: an.name waitForCompletion:NO]];
                NSString *mystring = touchedNode.name;
                NSString *mystringon = [mystring stringByReplacingOccurrencesOfString:@"_off" withString:@""];
                SKTexture *ontex = [SKTexture textureWithImageNamed:mystringon];
                [touchedNode runAction:[SKAction setTexture:ontex resize:NO]];
                [_snakkeboble runAction:hidesequence];
                _currentletter = touchedNode.userData[@"letter"];
                NSLog(@"Touched letter");
            }
        }
    }
    // lever
    else if ([touchedNode.name rangeOfString:@"castle_lever"].location != NSNotFound) {
        [_leverup setHidden:!_leverup.hidden];
        [_leverdown setHidden:!_leverdown.hidden];
        [touchedNode runAction:[SKAction playSoundFileNamed:@"sfx_lever" waitForCompletion:NO]];
        if(!_leverup.hidden){
            [_gate runAction:[SKAction moveToY:top duration:1.0]];
        }
        else{
            [_gate runAction:[SKAction moveToY:bottom duration:1.0]];
        }
        NSLog(@"Touched lever");
    }
    // princess
    else if ([_princess containsPoint:touchedPoint]) {
        for (SKAudioNode *an in _princess.children) {
            if(an != nil && [an isKindOfClass:[SKAudioNode class]]) {
                [an runAction:[SKAction playSoundFileNamed: an.name waitForCompletion:NO]];
            }
        }
        [_snakkeboble_prins runAction:bubblesequence2];
        NSLog(@"Touched princess");
    }
    // camera
    else if ([touchedNode.name isEqualToString:@"castlecamera0"]) {
        [touchedNode runAction:[SKAction animateWithTextures:_cameras timePerFrame:0.1 resize:YES restore:NO]];
        [touchedNode runAction:[SKAction playSoundFileNamed:@"sfx_camera2" waitForCompletion:NO]];
        NSLog(@"Touched camera");
    }
    // speaker
    else if ([touchedNode.name isEqualToString:@"castle_speaker0"]) {
        if(!isMusic){
            [touchedNode runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:_speakers timePerFrame:0.1 resize:YES restore:NO]] withKey:@"musicaction"];
            [musicplayer play];
            isMusic = !isMusic;
        }
        else{
            [touchedNode removeActionForKey:@"musicaction"];
            [touchedNode setTexture:castle_speaker0];
            [musicplayer pause];
            isMusic = !isMusic;
        }
        
        NSLog(@"Touched speaker");
    }
    // arrows
    else if ([touchedNode.name isEqualToString:@"arrow_r"]) {
        SKTransition *reveal = [SKTransition revealWithDirection:SKTransitionDirectionDown duration:1.0];
        IslandScene *_newScene = [IslandScene newGameScene];
        for(SKView *v in self.view.subviews){
            [v removeFromSuperview];
        }
        [self.scene.view presentScene: _newScene];
        NSLog(@"Touched right arrow");
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
