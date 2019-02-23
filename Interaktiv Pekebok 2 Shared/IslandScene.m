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
    GameScene *_newGameScene;
    FarmScene *_newFarmScene;
    NSMutableArray *_meercatbools;
    NSMutableArray *_meercatboolsOld;
    SKAction *swoosh2;
    SKAction *swoosh3;
    SKAction *ding;
    SKAction *dreamharp;
    SKAction *waitabit;
    SKAction *hidecat;
    SKAction *unhidecat;
    SKAction *hideseq;
    SKAction *unhideslowseq;
    SKAction *hideslowseq;
    SKAction *unhideseq;
    SKAction *clearmeercats;
    SKAction *meercatsfxdown;
    SKAction *meercatsfxup;
    SKAction *halfvolume;
    SKAction *correctanswer;
    
    SKTexture *cat1up; SKTexture *cat1down;
    SKTexture *cat2up; SKTexture *cat2down;
    SKTexture *cat3up; SKTexture *cat3down;
    SKTexture *cat4up; SKTexture *cat4down;
    SKTexture *cat5up; SKTexture *cat5down;
    SKTexture *cat6up; SKTexture *cat6down;
    SKTexture *cat7up; SKTexture *cat7down;
    SKTexture *cat8up; SKTexture *cat8down;
    SKTexture *cat9up; SKTexture *cat9down;
    SKTexture *cat10up; SKTexture *cat10down;
    NSArray *meercattexup;
    NSArray *meercattexdown;
    NSMutableArray *meercattextures;
    
    SKShapeNode *cat1; SKShapeNode *cat2; SKShapeNode *cat3; SKShapeNode *cat4; SKShapeNode *cat5;
    SKShapeNode *cat6; SKShapeNode *cat7; SKShapeNode *cat8; SKShapeNode *cat9; SKShapeNode *cat10;
    SKShapeNode *cat1d; SKShapeNode *cat2d; SKShapeNode *cat3d; SKShapeNode *cat4d; SKShapeNode *cat5d;
    SKShapeNode *cat6d; SKShapeNode *cat7d; SKShapeNode *cat8d; SKShapeNode *cat9d; SKShapeNode *cat10d;
    NSArray *cats;
    NSArray *catsd;
    SKSpriteNode *_starnode;
    SKSpriteNode *_farstarnode;
    SKSpriteNode *_sattelitenode;
    SKSpriteNode *_planetnode;
    SKShapeNode *islandnode;
    CGSize farstarsize;
    CGSize bigfarstarrsize;
    double lasttime;
    double elapsedtime;
    double farstarage;
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
    lasttime = 0;
    elapsedtime = 0;
    farstarage = 480;
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                         pathForResource:@"bgmusic_tellepic"
                                         ofType:@"mp3"]];
    musicplayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    musicplayer.numberOfLoops = -1;
    islandnode = (SKShapeNode *)[self childNodeWithName:@"islandnode"];
    _meercatbools = [[NSMutableArray alloc] initWithObjects:
                     [NSNumber numberWithBool:NO],
                     [NSNumber numberWithBool:NO],
                     [NSNumber numberWithBool:NO],
                     [NSNumber numberWithBool:NO],
                     [NSNumber numberWithBool:NO],
                     [NSNumber numberWithBool:NO],
                     [NSNumber numberWithBool:NO],
                     [NSNumber numberWithBool:NO],
                     [NSNumber numberWithBool:NO],
                     [NSNumber numberWithBool:NO], nil];
    _meercatboolsOld = [[NSMutableArray alloc] initWithArray:_meercatbools];
    cat1 = (SKShapeNode*) [islandnode childNodeWithName:@"surikat1"];
    cat2 = (SKShapeNode*) [islandnode childNodeWithName:@"surikat2"];
    cat3 = (SKShapeNode*) [islandnode childNodeWithName:@"surikat3"];
    cat4 = (SKShapeNode*) [islandnode childNodeWithName:@"surikat4"];
    cat5 = (SKShapeNode*) [islandnode childNodeWithName:@"surikat5"];
    cat6 = (SKShapeNode*) [islandnode childNodeWithName:@"surikat6"];
    cat7 = (SKShapeNode*) [islandnode childNodeWithName:@"surikat7"];
    cat8 = (SKShapeNode*) [islandnode childNodeWithName:@"surikat8"];
    cat9 = (SKShapeNode*) [islandnode childNodeWithName:@"surikat9"];
    cat10 = (SKShapeNode*) [islandnode childNodeWithName:@"surikat10"];
    cat1d = (SKShapeNode*) [islandnode childNodeWithName:@"surikat1d"];
    cat2d = (SKShapeNode*) [islandnode childNodeWithName:@"surikat2d"];
    cat3d = (SKShapeNode*) [islandnode childNodeWithName:@"surikat3d"];
    cat4d = (SKShapeNode*) [islandnode childNodeWithName:@"surikat4d"];
    cat5d = (SKShapeNode*) [islandnode childNodeWithName:@"surikat5d"];
    cat6d = (SKShapeNode*) [islandnode childNodeWithName:@"surikat6d"];
    cat7d = (SKShapeNode*) [islandnode childNodeWithName:@"surikat7d"];
    cat8d = (SKShapeNode*) [islandnode childNodeWithName:@"surikat8d"];
    cat9d = (SKShapeNode*) [islandnode childNodeWithName:@"surikat9d"];
    cat10d = (SKShapeNode*) [islandnode childNodeWithName:@"surikat10d"];
    cats = [NSArray arrayWithObjects:cat1,cat2,cat3,cat4,cat5,cat6,cat7,cat8,cat9,cat10,nil];
    catsd = [NSArray arrayWithObjects:cat1d,cat2d,cat3d,cat4d,cat5d,cat6d,cat7d,cat8d,cat9d,cat10d,nil];
    
    
    _starnode = [SKSpriteNode spriteNodeWithImageNamed:@"stjerne1"];
    _starnode.physicsBody.collisionBitMask = 0;
    CGSize starsize = CGSizeMake(1, 1);
    [_starnode setSize:starsize];
    [_starnode setZPosition:-4];
    _farstarnode = [SKSpriteNode spriteNodeWithImageNamed:@"stjerne_fjern"];
    _farstarnode.physicsBody.collisionBitMask = 0;
    farstarsize = CGSizeMake(4, 4);
    bigfarstarrsize = CGSizeMake(5, 5);
    [_farstarnode setSize:farstarsize];
    [_farstarnode setAlpha:0.4];
    [_farstarnode setZPosition:-5];
    
    [self setupSattelite];
    [self setupPlanet];
    [self setupFarStars];
    
    //meercatsequence = [SKAction sequence:@[waitabit]];
    halfvolume = [SKAction changeVolumeTo:0.6 duration:0];
    swoosh2 = [SKAction playSoundFileNamed:@"sfx_swoosh2" waitForCompletion:NO];
    swoosh3 = [SKAction playSoundFileNamed:@"sfx_swoosh3" waitForCompletion:NO];
    ding = [SKAction playSoundFileNamed:@"quizkorrekt" waitForCompletion:NO];
    dreamharp = [SKAction playSoundFileNamed:@"dreamharpcut" waitForCompletion:NO];
    waitabit = [SKAction waitForDuration:0.5];
    meercatsfxdown = [SKAction sequence:@[halfvolume,waitabit,swoosh2]];
    meercatsfxup = [SKAction sequence:@[halfvolume,waitabit,waitabit,swoosh3]];
    hidecat = [SKAction hide];
    unhidecat = [SKAction unhide];
    hideseq = [SKAction sequence:@[waitabit,hidecat]];
    unhideseq = [SKAction sequence:@[waitabit, unhidecat]];
    unhideslowseq = [SKAction sequence:@[waitabit, waitabit, unhidecat]];
    hideslowseq = [SKAction sequence:@[waitabit, waitabit, hidecat]];
    correctanswer = [SKAction sequence:@[waitabit, dreamharp]];
    [musicplayer play];
    int count = (int)_meercatbools.count;
    for (NSUInteger i = 0; i < count; ++i) {
        [(SKShapeNode*)[cats objectAtIndex:i] setHidden:NO];
        [(SKShapeNode*)[catsd objectAtIndex:i] setHidden:YES];
    }
    [self resetMeercatBools];
    
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

//sets meercat bool array to NO NO NO NO NO
-(void) resetMeercatBools{
    NSLog(@"Resetting meercats");
    _meercatboolsOld = [[NSMutableArray alloc] initWithArray:_meercatbools];
    bool isPutDown = NO;
    bool isPutUp = NO;
    int count = (int)_meercatbools.count;
    for(int i = 0; i < _meercatbools.count; i++){
        if([[_meercatbools objectAtIndex:i] isEqual:[NSNumber numberWithBool: YES]])
        {
            isPutDown = YES;
        }
        [_meercatbools replaceObjectAtIndex:i withObject:[NSNumber numberWithBool:NO]];
    }
    if(isPutDown){
        for (NSUInteger i = 0; i < count; ++i) {
            [(SKShapeNode*)[cats objectAtIndex:i] runAction:hideseq];
            [(SKShapeNode*)[catsd objectAtIndex:i] runAction:unhideseq];
        }
        NSLog(@"Swoosh down");
        [islandnode runAction:meercatsfxdown];
    }
    
    //bruker Fisher-Yates for å stokke array.
    //random tall mellom 0-10. fyller opp fra bjynnelsen av array: 1 1 1 1 0 0 0 0 0 0 0.... stokker senere
    int standingmeercats = (arc4random() % (count+1));
    if(standingmeercats > 0){
       ;
    }
    //NSLog(@"count: %i  tempamount: %i", count, tempamountofkats);
    for(NSUInteger i = 0; i < standingmeercats; i++){
        [_meercatbools replaceObjectAtIndex:i withObject:[NSNumber numberWithBool:YES]];
    }
    
    for (NSUInteger i = 0; i < count; ++i) {
        // Select a random element between i and end of array to swap with.
        NSInteger nElements = count - i;
        NSInteger n = (arc4random() % nElements) + i;
        [_meercatbools exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
    //Hides and unhides meercats according to meercatbools
    for (NSUInteger i = 0; i < count; ++i) {
        if([[_meercatbools objectAtIndex:i] isEqual:[NSNumber numberWithBool: YES]]){
            isPutUp = YES;
            [(SKShapeNode*)[cats objectAtIndex:i] runAction:unhideslowseq];
            [(SKShapeNode*)[catsd objectAtIndex:i] runAction:hideslowseq];
        }
        else{
            [(SKShapeNode*)[cats objectAtIndex:i] runAction:hideslowseq];
            [(SKShapeNode*)[catsd objectAtIndex:i] runAction:unhideslowseq];
        }
    }
    if(isPutUp){
        NSLog(@"Swoosh up");
        [islandnode runAction:meercatsfxup];
    }
}

-(int)meercatCount{
    int meercatcount = 0;
    for(int i = 0; i < _meercatbools.count; i++){
        if([[_meercatbools objectAtIndex:i] isEqual:[NSNumber numberWithBool: YES]])
        {
            meercatcount++;
        }
    }
    return meercatcount;
}
-(void)setupSattelite{
    if([self childNodeWithName:@"//sattelite"] == nil){
        _sattelitenode = [SKSpriteNode spriteNodeWithImageNamed:@"satelitt"];
        _sattelitenode.physicsBody.collisionBitMask = 0;
        [_sattelitenode setName:@"sattelite"];
        [_sattelitenode setZPosition:-1];
        [self addChild:_sattelitenode];
    }
    int ypos = (arc4random() % (320+1)) + 640;
    CGPoint satpos = CGPointMake(-100, ypos);
    CGVector vector = CGVectorMake(1700, 0);
    [_sattelitenode setPosition:satpos];
    int speed = 40;
    [_sattelitenode runAction:[SKAction moveBy:vector duration:speed]];
    
}
-(void)setupPlanet{
    if([self childNodeWithName:@"//planet"] == nil){
        _planetnode = [SKSpriteNode spriteNodeWithImageNamed:@"planet"];
        _planetnode.physicsBody.collisionBitMask = 0;
        [_planetnode setName:@"planet"];
        [_planetnode setZPosition:-3];
        [self addChild:_planetnode];
    }
    int ypos = (arc4random() % (300+1)) + 660;
    CGPoint planetpos = CGPointMake(-100, ypos);
    CGVector vector = CGVectorMake(1700, 0);
    [_planetnode setPosition:planetpos];
    int speed = 80;
    [_planetnode runAction:[SKAction moveBy:vector duration:speed]];
}
-(void)setupFarStars{
    //Create 1000 far stars
    for(int i = 0; i < 500; i++){
        SKShapeNode *farstar = [_farstarnode copy];
        int xpos = (arc4random() % (1280+1));
        int ypos = (arc4random() % (320+1)) + 640;
        int speed = (arc4random() % (50+1)) + farstarage;
        CGPoint pos = CGPointMake(xpos, ypos);
        CGVector vector = CGVectorMake(1500, 0);
        farstar.position = pos;
        SKAction *movestar = [SKAction moveBy:vector duration:speed];
        SKAction *killstar = [SKAction removeFromParent];
        SKAction *starseq = [SKAction sequence:@[movestar, killstar]];
        if(i % 5 == 0){
            int rdmwait = (arc4random() % (20))+1;
            SKAction *blinkstar = [SKAction fadeAlphaTo:1.0 duration:1];
            SKAction *blinkstar2 = [SKAction fadeAlphaTo:0.4 duration:1];
            SKAction *waitstar = [SKAction waitForDuration:rdmwait];
            SKAction *growstar = [SKAction scaleToSize:bigfarstarrsize duration:1];
            SKAction *shrinkstar = [SKAction scaleToSize:farstarsize duration:1];
            SKAction *blinkseq = [SKAction repeatActionForever:[SKAction sequence:@[waitstar, blinkstar, blinkstar2]]];
            SKAction *growseq = [SKAction repeatActionForever:[SKAction sequence:@[waitstar, growstar, shrinkstar]]];
            SKAction *parallelseq = [SKAction group:@[starseq, blinkseq, growseq]];
            [farstar runAction:parallelseq];
        }
        else{
                [farstar runAction:starseq];
        }
        [self addChild:farstar];
    }
}
-(void)spawnFarStarCluster{
    int farstarcount = (arc4random() % (2))+1;
    for(int i = 0; i < farstarcount; i++){
        int roll5die = (arc4random() % 5)+1;
        SKShapeNode *farstar = [_farstarnode copy];
        int xpos = -(arc4random() % (10+1));
        int ypos = (arc4random() % (320+1)) + 640;
        int speed = (arc4random() % (50+1)) + farstarage;
        CGPoint pos = CGPointMake(xpos, ypos);
        CGVector vector = CGVectorMake(1500, 0);
        farstar.position = pos;
        SKAction *movestar = [SKAction moveBy:vector duration:speed];
        SKAction *killstar = [SKAction removeFromParent];
        SKAction *starseq = [SKAction sequence:@[movestar, killstar]];
        if(roll5die == 5){
            int rdmwait = (arc4random() % (20));
            SKAction *blinkstar = [SKAction fadeAlphaTo:1.0 duration:1];
            SKAction *blinkstar2 = [SKAction fadeAlphaTo:0.4 duration:1];
            SKAction *waitstar = [SKAction waitForDuration:rdmwait];
            SKAction *growstar = [SKAction scaleToSize:bigfarstarrsize duration:1];
            SKAction *shrinkstar = [SKAction scaleToSize:farstarsize duration:1];
            SKAction *blinkseq = [SKAction repeatActionForever:[SKAction sequence:@[waitstar, blinkstar, blinkstar2]]];
            SKAction *growseq = [SKAction repeatActionForever:[SKAction sequence:@[waitstar, growstar, shrinkstar]]];
            SKAction *parallelgroup = [SKAction group:@[starseq, blinkseq, growseq]];
            [farstar runAction:parallelgroup];
        }
        [farstar runAction:starseq];
        [self addChild:farstar];
    }
}

-(void)spawnStar{
    SKShapeNode *star = [_starnode copy];
    int xpos = 10;
    int ypos = (arc4random() % (320+1)) + 640;
    int speed = (arc4random() % (50+1)) + 100;
    CGPoint pos = CGPointMake(xpos, ypos);
    CGVector vector = CGVectorMake(1500, 0);
    star.position = pos;
    SKAction *growstar = [SKAction resizeByWidth:30 height:30 duration:2];
    SKAction *movestar = [SKAction moveBy:vector duration:speed];
    SKAction *killstar = [SKAction removeFromParent];
    SKAction *starseq = [SKAction sequence:@[growstar, movestar, killstar]];
    SKAction *parallelgroup = [SKAction group:@[growstar, starseq]];
    [star runAction:parallelgroup];
    [self addChild:star];
}
-(void)update:(CFTimeInterval)currentTime {
    // Called before each frame is rendered
    elapsedtime = currentTime - lasttime;
    if(_sattelitenode.position.x > 1500){
        [self setupSattelite];
    }
    if(_planetnode.position.x > 1500){
        [self setupPlanet];
    }
    if(elapsedtime > 1){
        [self spawnFarStarCluster];
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
    
    // arrows
    if ([touchedNode.name rangeOfString:@"arrow_r"].location != NSNotFound) {
        SKTransition *flipz = [SKTransition flipVerticalWithDuration:2.0];
        FarmScene *_newScene = [FarmScene newGameScene];
        [self.scene.view presentScene: _newScene transition:flipz];
        NSLog(@"Touched arrow");
    }
    else if ([touchedNode.name rangeOfString:@"arrow_l"].location != NSNotFound) {
        SKTransition *flipz = [SKTransition flipVerticalWithDuration:2.0];
        GameScene *_newScene = [GameScene newGameScene];
        [self.scene.view presentScene: _newScene transition:flipz];
        NSLog(@"Touched arrow");
    }
    else if([touchedNode.name rangeOfString:@"icon"].location != NSNotFound){
        for (SKAudioNode *an in touchedNode.children) {
            if([touchedNode.name rangeOfString:@"icon10"].location == NSNotFound){
                NSString *mystring = touchedNode.name;
                NSString *mystringred = [mystring stringByAppendingString:@"red"];
                SKTexture *tex1 = [SKTexture textureWithImageNamed:mystring];
                SKTexture *tex2 = [SKTexture textureWithImageNamed:mystringred];
                [touchedNode runAction:[SKAction animateWithTextures:@[tex2,tex1] timePerFrame:0.4 resize:NO restore:NO]];
            }
            [an runAction:[SKAction playSoundFileNamed: an.name waitForCompletion:NO]];
        }
        int touchednumber = [touchedNode.userData[@"userData1"] intValue];
        //If correct number, play sounds, generate new meercat number, put all cats down then raise according to meercatbools
        if(touchednumber == [self meercatCount]){
            //[touchedNode runAction:meercatsfxdown];
            [touchedNode runAction:dreamharp];
            [self resetMeercatBools];
            [self spawnStar];
            NSLog(@"Touched correct number");
        }
        NSLog(@"Touched number");
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
