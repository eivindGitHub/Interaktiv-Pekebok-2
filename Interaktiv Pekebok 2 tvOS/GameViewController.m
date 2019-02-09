//
//  GameViewController.m
//  Interaktiv Pekebok 2 tvOS
//
//  Created by Eivind Aanestad on 09.02.2019.
//  Copyright © 2019 Eivind Aanestad. All rights reserved.
//

#import "GameViewController.h"
#import "GameScene.h"

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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end
