//
//  RSTransitonAnimatorDismiss.m
//  TransitionSample
//
//  Created by Ruslan Samsonov on 6/28/15.
//  Copyright (c) 2015 Ruslan Samsonov. All rights reserved.
//

#import "RSTransitonAnimatorDismiss.h"

@interface RSTransitonAnimatorDismiss()
@property (nonatomic, weak) id <UIViewControllerContextTransitioning> transitionContext;
@property (nonatomic, weak) UIViewController *fromController;
@end

@implementation RSTransitonAnimatorDismiss

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    _transitionContext = transitionContext;
    UIViewController *fromController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    _fromController = fromController;
    UIViewController *toController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toController.view.frame = [UIScreen mainScreen].bounds;
    
    CABasicAnimation *zoom = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    zoom.toValue = @(0.0f);
    zoom.fromValue = @(1.0f);
    zoom.removedOnCompletion = NO;
    zoom.duration = [self transitionDuration:transitionContext];
    
    CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotation.toValue = @(-M_PI * 2);
    rotation.removedOnCompletion = NO;
    rotation.duration = [self transitionDuration:transitionContext];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[rotation, zoom];
    group.duration = [self transitionDuration:transitionContext];
    group.delegate = self;
    [fromController.view.layer addAnimation:group forKey:@"zoom&rotate"];
    
    CABasicAnimation *color = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    color.toValue = (__bridge id)([[UIColor redColor] CGColor]);
    color.fromValue = (__bridge id)([[UIColor grayColor] CGColor]);
    color.duration = [self transitionDuration:transitionContext];
    color.fillMode = kCAFillModeForwards;
    color.removedOnCompletion = NO;
    [fromController.view.layer addAnimation:color forKey:@"color"];
}

- (void)animationDidStop:(CAAnimation*)theAnimation finished:(BOOL)flag
{
    [_transitionContext completeTransition:YES];
}

@end
