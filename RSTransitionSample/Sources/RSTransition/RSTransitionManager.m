//
//  RSTransitionManager.m
//  RSTransitionSample
//
//  Created by Ruslan Samsonov on 6/27/15.
//  Copyright (c) 2015 Ruslan Samsonov. All rights reserved.
//

#import "RSTransitionManager.h"
#import "ViewController.h"
#import "ShownViewController.h"
#import "RSTransitionDelegate.h"

@interface RSTransitionManager ()
@property (nonatomic, strong) NSMutableDictionary *transitionDelegates;
@end

@implementation RSTransitionManager

- (instancetype)init
{
    if (self = [super init]) {
        _transitionDelegates = [NSMutableDictionary new];
    }
    return self;
}

#pragma mark - Public
- (id <UIViewControllerTransitioningDelegate>)transitionDelegateForSourceController:(UIViewController *)sourceController shownController:(UIViewController *)shownController
{
    NSString *key = [self keyForSourceController:sourceController shownController:shownController];
    id <UIViewControllerTransitioningDelegate> transitionDelegate = _transitionDelegates[key];
    if (!transitionDelegate) {
        if ([sourceController isKindOfClass:ViewController.class] && [shownController isKindOfClass:ShownViewController.class]) {
            _transitionDelegates[key] = [RSTransitionDelegate new];
        }
    }
    return _transitionDelegates[key];
}

#pragma mark - KeyGenerator
- (NSString *)keyForSourceController:(UIViewController *)sourceController shownController:(UIViewController *)shownController
{
    return [NSString stringWithFormat:@"%@_%@", sourceController.class, shownController.class];
}
@end
