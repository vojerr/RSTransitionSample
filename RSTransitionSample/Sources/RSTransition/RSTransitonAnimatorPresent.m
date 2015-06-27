//
//  RSTransitonAnimator.m
//  TransitionSample
//
//  Created by Ruslan Samsonov on 6/27/15.
//  Copyright (c) 2015 Ruslan Samsonov. All rights reserved.
//

#import "RSTransitonAnimatorPresent.h"

@interface RSTransitonAnimatorPresent()
@property (nonatomic, weak) id <UIViewControllerContextTransitioning> transitionContext;
@end

@implementation RSTransitonAnimatorPresent

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    _transitionContext = transitionContext;
    UIView *containerView = [transitionContext containerView];
    UIViewController *fromController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toController.view.center = fromController.view.center;
    [containerView insertSubview:toController.view aboveSubview:fromController.view];
    
    CABasicAnimation *zoom = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    zoom.fromValue = @(0.0f);
    zoom.toValue = @(1.0f);
    zoom.removedOnCompletion = NO;
    zoom.duration = [self transitionDuration:transitionContext];
    
    CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotation.toValue = @(M_PI * 2);
    rotation.removedOnCompletion = NO;
    rotation.duration = [self transitionDuration:transitionContext];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[rotation, zoom];
    group.duration = [self transitionDuration:transitionContext];
    group.delegate = self;
    [toController.view.layer addAnimation:group forKey:@"zoom&rotate"];
   
    CABasicAnimation *color = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    color.fromValue = (__bridge id)([[UIColor redColor] CGColor]);
    color.toValue = (__bridge id)([[UIColor grayColor] CGColor]);
    color.duration = [self transitionDuration:transitionContext];
    color.fillMode = kCAFillModeForwards;
    color.removedOnCompletion = NO;
    [toController.view.layer addAnimation:color forKey:@"color"];
}

- (void)animationDidStop:(CAAnimation*)theAnimation finished:(BOOL)flag
{
    [_transitionContext completeTransition:YES];
}

@end
