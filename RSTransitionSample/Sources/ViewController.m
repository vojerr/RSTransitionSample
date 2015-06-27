//
//  ViewController.m
//  TransitionSample
//
//  Created by Ruslan Samsonov on 6/27/15.
//  Copyright (c) 2015 Ruslan Samsonov. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+RSTransitioning.h"
#import "ShownViewController.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)]];
}

- (void)onTap:(UITapGestureRecognizer *)tapRecognizer
{
    if (self.presentedViewController)   return;
    
    [self presentRSViewController:[ShownViewController new] animated:YES completion:nil];
}
@end
