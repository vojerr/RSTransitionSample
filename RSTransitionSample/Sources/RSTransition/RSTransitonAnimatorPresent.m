//
//  RSTransitonAnimator.m
//  RSTransitionSample
//
//  Created by Ruslan Samsonov on 6/27/15.
//  Copyright (c) 2015 Ruslan Samsonov. All rights reserved.
//

#import "RSTransitonAnimatorPresent.h"
#import "RSAnimationGroupUtil.h"

static CGFloat const RSTransitonAnimatorPresentDuration = 0.5f;

@interface RSTransitonAnimatorPresent()
@property (nonatomic, weak) id <UIViewControllerContextTransitioning> transitionContext;
@end

@implementation RSTransitonAnimatorPresent

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return RSTransitonAnimatorPresentDuration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    _transitionContext = transitionContext;
    UIView *containerView = [transitionContext containerView];
    UIViewController *fromController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toController.view.center = fromController.view.center;
    [containerView insertSubview:toController.view aboveSubview:fromController.view];
    
    CAAnimationGroup *animationGroup = [RSAnimationGroupUtil createRotateAndScaleAnimationWithDuration:[self transitionDuration:transitionContext]];
    animationGroup.delegate = self;
    [toController.view.layer addAnimation:animationGroup forKey:@"zoom&rotate"];
}

- (void)animationDidStop:(CAAnimation*)theAnimation finished:(BOOL)flag
{
    [_transitionContext completeTransition:YES];
}

@end
