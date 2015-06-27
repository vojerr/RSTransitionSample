//
//  RSInteractiveAnimatorUp.m
//  TransitionSample
//
//  Created by Ruslan Samsonov on 6/27/15.
//  Copyright (c) 2015 Ruslan Samsonov. All rights reserved.
//

#import "RSInteractiveAnimatorPresent.h"

static CGFloat const RSInteractiveAnimatorFinishAnimationDistance = 50.0f;
static CGFloat const RSInteractiveAnimatorFinishAnimationPercent = 0.5f;

@interface RSInteractiveAnimatorPresent()
@property (nonatomic, assign) CGPoint beginPoint;
@property (nonatomic, weak) id <UIViewControllerContextTransitioning> transitionContext;
@end

@implementation RSInteractiveAnimatorPresent

- (void)startInteractiveTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPan:)];
    [fromController.view addGestureRecognizer:panRecognizer];
}

- (CGFloat)completionSpeed
{
    return 1.0f;
}

- (UIViewAnimationCurve)completionCurve
{
    return UIViewAnimationCurveEaseIn;
}

#pragma mark - UIPanGestureRecognizer
- (void)onPan:(UIPanGestureRecognizer *)panRecognizer
{
    CGPoint changedPoint = [panRecognizer translationInView:panRecognizer.view];
    switch (panRecognizer.state) {
        case UIGestureRecognizerStateBegan:
        {
            _beginPoint = changedPoint;
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
            CGFloat distance = hypot(changedPoint.x - _beginPoint.x, changedPoint.y - _beginPoint.y);
            [_transitionContext updateInteractiveTransition:MIN(1.0f, distance / RSInteractiveAnimatorFinishAnimationDistance)];
            break;
        }
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
        {
            CGFloat distance = hypot(changedPoint.x - _beginPoint.x, changedPoint.y - _beginPoint.y);
            CGFloat percent = distance / RSInteractiveAnimatorFinishAnimationDistance;
            percent > RSInteractiveAnimatorFinishAnimationPercent ? [_transitionContext finishInteractiveTransition] : [_transitionContext cancelInteractiveTransition];
            break;
        }
        default:
            break;
    }
}
@end
