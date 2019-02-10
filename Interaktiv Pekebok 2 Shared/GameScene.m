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
    _leverup = (SKShapeNode *)[self childNodeWithName:@"//castle_lever_up"];
    [_leverup setHidden:true];
    _leverdown = (SKShapeNode *)[self childNodeWithName:@"//castle_lever_down"];
    [_leverdown setHidden:false];
    _princess = (SKShapeNode *)[self childNodeWithName:@"//princessdummy"];
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
    for (SKAudioNode *an in touchedNode.children) {
        if(an != nil && [an isKindOfClass:[SKAudioNode class]] && [touchedNode.name rangeOfString:@"snowball"].location != NSNotFound) {
            NSString *mystring = touchedNode.name;
            NSString *mystringsing = [mystring stringByAppendingString:@"_sing"];
            SKTexture *tex1 = [SKTexture textureWithImageNamed:mystring];
            SKTexture *tex2 = [SKTexture textureWithImageNamed:mystringsing];
            [touchedNode runAction:[SKAction animateWithTextures:@[tex2,tex1] timePerFrame:0.5 resize:YES restore:NO]];
            [an runAction:[SKAction playSoundFileNamed: an.name waitForCompletion:NO]];
            NSLog(@"Touched singing snowball");
        }
    }
    // lever
    if ([touchedNode.name rangeOfString:@"castle_lever"].location != NSNotFound) {
        [_leverup setHidden:!_leverup.hidden];
        [_leverdown setHidden:!_leverdown.hidden];
        [touchedNode runAction:[SKAction playSoundFileNamed:@"sfx_lever" waitForCompletion:NO]];
        NSLog(@"Touched lever");
    }
    // princess
    if ([_princess containsPoint:touchedPoint]) {
        for (SKAudioNode *an in _princess.children) {
            if(an != nil && [an isKindOfClass:[SKAudioNode class]]) {
                [an runAction:[SKAction playSoundFileNamed: an.name waitForCompletion:NO]];
            }
        }
        NSLog(@"Touched princess");
    }
    if ([touchedNode.name isEqualToString:@"castlecamera0"]) {
        [touchedNode runAction:[SKAction animateWithTextures:_cameras timePerFrame:0.1 resize:YES restore:NO]];
        [touchedNode runAction:[SKAction playSoundFileNamed:@"sfx_camera2" waitForCompletion:NO]];
        NSLog(@"Touched camera");
    }
    if ([touchedNode.name isEqualToString:@"castle_speaker0"]) {
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
