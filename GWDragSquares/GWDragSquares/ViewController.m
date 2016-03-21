//
//  ViewController.m
//  GWDragSquares
//
//  Created by Commoner on 16/3/21.
//  Copyright © 2016年 Commoner. All rights reserved.
//

#import "ViewController.h"
#import "GWDragSquaresView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    GWDragSquaresView *dragView = [[GWDragSquaresView alloc]initWithFrame:self.view.frame];
    
    [self.view addSubview:dragView];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
