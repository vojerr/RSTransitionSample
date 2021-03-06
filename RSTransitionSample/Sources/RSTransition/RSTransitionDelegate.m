//
//  RSTransitionDelegate.m
//  RSTransitionSample
//
//  Created by Ruslan Samsonov on 6/27/15.
//  Copyright (c) 2015 Ruslan Samsonov. All rights reserved.
//

#import "RSTransitionDelegate.h"
#import "RSTransitonAnimatorPresent.h"
#import "RSTransitonAnimatorDismiss.h"

@implementation RSTransitionDelegate

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [RSTransitonAnimatorPresent new];
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [RSTransitonAnimatorDismiss new];
}
@end
