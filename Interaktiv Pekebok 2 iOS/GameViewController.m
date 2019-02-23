//
//  GameViewController.m
//  Interaktiv Pekebok 2 iOS
//
//  Created by Eivind Aanestad on 09.02.2019.
//  Copyright © 2019 Eivind Aanestad. All rights reserved.
//

#import "GameViewController.h"
#import "GameScene.h"
#import "IslandScene.h"
#import "FarmScene.h"

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    GameScene *scene = [GameScene newGameScene];
    
    // Present the scene
    SKView *skView = (SKView *)self.view;
    [skView presentScene:scene];
    skView.ignoresSiblingOrder = YES;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    //skView.scene.scaleMode = SKSceneScaleModeAspectFit;
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
