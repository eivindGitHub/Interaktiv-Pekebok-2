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
    double droptime;
    
    SKShapeNode *castlehallnode;
    SKSpriteNode *wagonnode;
    SKSpriteNode *winsidenode;
    
    CGPoint _wagonposs[5];
    CGPoint wagonposs0;
    CGPoint wagonposs1;
    CGPoint wagonposs2;
    CGPoint wagonposs3;
    CGPoint wagonposs4;
    
    CGPoint _winsideposs[5];
    CGPoint winsideposs0;
    CGPoint winsideposs1;
    CGPoint winsideposs2;
    CGPoint winsideposs3;
    CGPoint winsideposs4;
    
    NSArray *_wagonarms;
    SKSpriteNode *wagonarm0;
    SKSpriteNode *wagonarm1;
    SKSpriteNode *wagonarm2;
    SKSpriteNode *wagonarm3;
    SKSpriteNode *wagonarm4;
    
    NSArray *_fallings;
    SKSpriteNode *falling0;
    SKSpriteNode *falling1;
    SKSpriteNode *falling2;
    SKSpriteNode *falling3;
    SKSpriteNode *falling4;
    SKSpriteNode *falling5;
    SKSpriteNode *falling6;
    SKSpriteNode *falling7;
    SKSpriteNode *falling8;
    SKSpriteNode *falling9;
    
    CGPoint _fallingpos[5];
    CGPoint fallingpos0;
    CGPoint fallingpos1;
    CGPoint fallingpos2;
    CGPoint fallingpos3;
    CGPoint fallingpos4;
    CGVector fallingvector;
    int fallingduration;
    SKAction *movefalling;
    SKAction *killfalling;
    SKAction *seqfalling;
    
    SKSpriteNode *scorenode1;
    SKSpriteNode *scorenode2;
    SKSpriteNode *scorenode3;
    SKSpriteNode *scorenode4;
    SKTexture *scoretex0;
    SKTexture *scoretex1;
    SKTexture *scoretex2;
    SKTexture *scoretex3;
    SKTexture *scoretex4;
    SKTexture *scoretex5;
    SKTexture *scoretex6;
    SKTexture *scoretex7;
    SKTexture *scoretex8;
    SKTexture *scoretex9;
    NSArray *scoretexs;
    
    int wagonpos; // 0, 1, 2, 3, 4
    bool statechanged;
    int score;
    int scorenum1;
    int scorenum2;
    int scorenum3;
    int scorenum4;
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
    self.physicsWorld.gravity = CGVectorMake(0, 0);
    self.physicsWorld.contactDelegate = self;
    lasttime = 0;
    elapsedtime = 0;
    droptime = 3;
    wagonpos = 0;
    score = 0; scorenum1 = 0; scorenum2 = 0; scorenum3 = 0; scorenum4 = 0;
    statechanged = false;
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                         pathForResource:@"bgmusic_tellepic"
                                         ofType:@"mp3"]];
    musicplayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    musicplayer.numberOfLoops = -1;
    castlehallnode = (SKShapeNode *)[self childNodeWithName:@"castlehallnode"];
    wagonnode = (SKSpriteNode*) [castlehallnode childNodeWithName:@"//wagon"];
    [wagonnode setName:@"thewagon"];
    winsidenode = (SKSpriteNode*) [castlehallnode childNodeWithName:@"//wagoninside"];

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
    
    falling0 = [SKSpriteNode spriteNodeWithImageNamed:@"fallingobject0"]; [falling0 setZPosition:2];
    falling1 = [SKSpriteNode spriteNodeWithImageNamed:@"fallingobject1"]; [falling1 setZPosition:2];
    falling2 = [SKSpriteNode spriteNodeWithImageNamed:@"fallingobject2"]; [falling2 setZPosition:2];
    falling3 = [SKSpriteNode spriteNodeWithImageNamed:@"fallingobject3"]; [falling3 setZPosition:2];
    falling4 = [SKSpriteNode spriteNodeWithImageNamed:@"fallingobject4"]; [falling4 setZPosition:2];
    falling5 = [SKSpriteNode spriteNodeWithImageNamed:@"fallingobject5"]; [falling5 setZPosition:2];
    falling6 = [SKSpriteNode spriteNodeWithImageNamed:@"fallingobject6"]; [falling6 setZPosition:2];
    falling7 = [SKSpriteNode spriteNodeWithImageNamed:@"fallingobject7"]; [falling7 setZPosition:2];
    falling8 = [SKSpriteNode spriteNodeWithImageNamed:@"fallingobject8"]; [falling8 setZPosition:2];
    falling9 = [SKSpriteNode spriteNodeWithImageNamed:@"fallingobject9"]; [falling9 setZPosition:2];
    _fallings = [NSArray arrayWithObjects:falling0,falling1,falling2, falling3,falling4,falling5,falling6,falling7,falling8,falling9 , nil];
    
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
    CGSize wagcol = CGSizeMake(200, 2);
    wagonnode.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:wagcol];
    wagonnode.physicsBody.affectedByGravity = false;
    wagonnode.physicsBody.dynamic = false;
    wagonnode.physicsBody.categoryBitMask = wagonHitCat;
    wagonnode.physicsBody.contactTestBitMask = fallingHitCat;
    wagonnode.physicsBody.collisionBitMask = fallingHitCat;
    winsideposs0 = CGPointMake(52, 542);
    winsideposs1 = CGPointMake(198, 542);
    winsideposs2 = CGPointMake(348, 542);
    winsideposs3 = CGPointMake(498, 542);
    winsideposs4 = CGPointMake(648, 542);
    _winsideposs[0] = winsideposs0;
    _winsideposs[1] = winsideposs1;
    _winsideposs[2] = winsideposs2;
    _winsideposs[3] = winsideposs3;
    _winsideposs[4] = winsideposs4;
    winsidenode.position = winsideposs0;
    
    fallingpos0 = CGPointMake(100, 980);
    fallingpos1 = CGPointMake(246, 980);
    fallingpos2 = CGPointMake(396, 980);
    fallingpos3 = CGPointMake(546, 980);
    fallingpos4 = CGPointMake(696, 980);
    _fallingpos[0] = fallingpos0;
    _fallingpos[1] = fallingpos1;
    _fallingpos[2] = fallingpos2;
    _fallingpos[3] = fallingpos3;
    _fallingpos[4] = fallingpos4;
    fallingvector = CGVectorMake(0, -535);
    fallingduration = 10;
    movefalling = [SKAction moveBy:fallingvector duration:fallingduration];
    killfalling = [SKAction removeFromParent];
    seqfalling = [SKAction sequence:@[movefalling, killfalling]];
    
    scoretex0 = [SKTexture textureWithImageNamed:@"wscore0"];
    scoretex1 = [SKTexture textureWithImageNamed:@"wscore1"];
    scoretex2 = [SKTexture textureWithImageNamed:@"wscore2"];
    scoretex3 = [SKTexture textureWithImageNamed:@"wscore3"];
    scoretex4 = [SKTexture textureWithImageNamed:@"wscore4"];
    scoretex5 = [SKTexture textureWithImageNamed:@"wscore5"];
    scoretex6 = [SKTexture textureWithImageNamed:@"wscore6"];
    scoretex7 = [SKTexture textureWithImageNamed:@"wscore7"];
    scoretex8 = [SKTexture textureWithImageNamed:@"wscore8"];
    scoretex9 = [SKTexture textureWithImageNamed:@"wscore9"];
    scoretexs = [NSArray arrayWithObjects:scoretex0,scoretex1,scoretex2,scoretex3,scoretex4,scoretex5,scoretex6,scoretex7,scoretex8,scoretex9, nil];
    
    CGPoint scpos1 = CGPointMake(345, 217);
    CGPoint scpos2 = CGPointMake(325, 207);
    CGPoint scpos3 = CGPointMake(305, 197);
    CGPoint scpos4 = CGPointMake(285, 187);
    scorenode1 = [SKSpriteNode spriteNodeWithImageNamed:@"wscore0"];
    scorenode2 = [SKSpriteNode spriteNodeWithImageNamed:@"wscore0"]; [scorenode2 setHidden:true];
    scorenode3 = [SKSpriteNode spriteNodeWithImageNamed:@"wscore0"]; [scorenode3 setHidden:true];
    scorenode4 = [SKSpriteNode spriteNodeWithImageNamed:@"wscore0"]; [scorenode4 setHidden:true];
    scorenode1.position = scpos1; [scorenode1 setZPosition:2]; [self addChild:scorenode1];
    scorenode2.position = scpos2; [scorenode2 setZPosition:2]; [self addChild:scorenode2];
    scorenode3.position = scpos3; [scorenode3 setZPosition:2]; [self addChild:scorenode3];
    scorenode4.position = scpos4; [scorenode4 setZPosition:2]; [self addChild:scorenode4];
    
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
    if(elapsedtime > droptime){
        lasttime = currentTime;
        [self spawnFalling];
    }
    if(statechanged){
        [self wagonStateChanged];
    }
}

-(void)setScore{
    int remains = 0;
    scorenum4 = score / 1000;
    remains = score - scorenum4*1000;
    scorenum3 = remains / 100;
    remains = remains - scorenum3*100;
    scorenum2 = remains / 10;
    remains = remains - scorenum2*10;
    scorenum1 = remains;
    [scorenode1 setTexture:[scoretexs objectAtIndex:scorenum1]];
    if(scorenum2 == 0 && scorenum3 == 0){
        [scorenode2 setHidden:true];
    }
    else{
        [scorenode2 setTexture:[scoretexs objectAtIndex:scorenum2]];
        [scorenode2 setHidden:false];
    }
    if(scorenum3 == 0 && scorenum4 == 0){
        [scorenode3 setHidden:true];
    }
    else{
        [scorenode3 setTexture:[scoretexs objectAtIndex:scorenum3]];
        [scorenode3 setHidden:false];
    }
    if(scorenum4 != 0){
        [scorenode4 setTexture:[scoretexs objectAtIndex:scorenum4]];
        [scorenode4 setHidden:false];
    }
    else{
        [scorenode4 setHidden:true];
    }
}

-(void)wagonStateChanged{
    NSLog(@"Wagon position changed");
    statechanged = false;
    wagonnode.position = _wagonposs[wagonpos];
    winsidenode.position = _winsideposs[wagonpos];
    for(NSUInteger i = 0; i <= wagonposmax; i++){
        if(i == wagonpos){
            [[_wagonarms objectAtIndex:i] setHidden:false];
        }
        else{
            [[_wagonarms objectAtIndex:i] setHidden:true];
        }
    }
}

-(void)spawnFalling{
    int skin = (arc4random() % (_fallings.count));
    int xpos = (arc4random() % (5));
    SKSpriteNode *fallingthing = [[_fallings objectAtIndex:skin] copy];
    fallingthing.position = _fallingpos[xpos];
    [fallingthing runAction:seqfalling];
    CGSize fallingcolsize = CGSizeMake(50, 2);
    fallingthing.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:fallingcolsize];
    fallingthing.physicsBody.categoryBitMask = fallingHitCat;
    fallingthing.physicsBody.contactTestBitMask = wagonHitCat;
    fallingthing.physicsBody.collisionBitMask = wagonHitCat;
    fallingthing.physicsBody.affectedByGravity = false;
    [fallingthing setName:@"fallingthing"];
    [self addChild:fallingthing];
}

-(void)didBeginContact:(SKPhysicsContact *)contact
{
    SKPhysicsBody *firstBody, *secondBody;
    
    firstBody = contact.bodyA;
    secondBody = contact.bodyB;
    
    if(firstBody.categoryBitMask == fallingHitCat || secondBody.categoryBitMask == fallingHitCat)
    {
        if([firstBody.node.name rangeOfString:@"fallingthing"].location != NSNotFound){
            [firstBody.node removeFromParent];
            score++;
        }
        if([secondBody.node.name rangeOfString:@"fallingthing"].location != NSNotFound){
            [secondBody.node removeFromParent];
            score++;
        }
        [self setScore];
        NSLog(@"falling thing hit the wagon");
        //setup your methods and other things here
        
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

