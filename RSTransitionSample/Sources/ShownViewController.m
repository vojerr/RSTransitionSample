//
//  ShownViewController.m
//  RSTransitionSample
//
//  Created by Ruslan Samsonov on 6/27/15.
//  Copyright (c) 2015 Ruslan Samsonov. All rights reserved.
//

#import "ShownViewController.h"

@interface ShownViewController ()

@end

@implementation ShownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.transitionCoordinator animateAlongsideTransition:^(id <UIViewControllerTransitionCoordinatorContext> context) {
        [UIView animateWithDuration:0.5f animations:^(void) {
            self.view.alpha = 0.5f;
        }];
    }completion:nil];
}

#pragma mark - Actions
- (void)onTap:(UITapGestureRecognizer *)tapRecognizer
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
