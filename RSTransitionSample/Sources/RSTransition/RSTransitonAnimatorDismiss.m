//
//  RSTransitonAnimatorDismiss.m
//  RSTransitionSample
//
//  Created by Ruslan Samsonov on 6/28/15.
//  Copyright (c) 2015 Ruslan Samsonov. All rights reserved.
//

#import "RSTransitonAnimatorDismiss.h"
#import "RSAnimationGroupUtil.h"

static CGFloat const RSTransitonAnimatorDismissDuration = 0.5f;

@interface RSTransitonAnimatorDismiss()
@property (nonatomic, weak) id <UIViewControllerContextTransitioning> transitionContext;
@property (nonatomic, weak) UIViewController *fromController;
@end

@implementation RSTransitonAnimatorDismiss

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return RSTransitonAnimatorDismissDuration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    _transitionContext = transitionContext;
    UIViewController *fromController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    _fromController = fromController;
    UIViewController *toController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toController.view.frame = [UIScreen mainScreen].bounds;
    
    CAAnimationGroup *animationGroup = [RSAnimationGroupUtil createBackwardsRotateAndScaleAnimationWithDuration:[self transitionDuration:transitionContext]];
    animationGroup.delegate = self;
    [fromController.view.layer addAnimation:animationGroup forKey:@"zoom&rotate"];
}

- (void)animationDidStop:(CAAnimation*)theAnimation finished:(BOOL)flag
{
    [_transitionContext completeTransition:YES];
}

@end
