//
//  RSInteractiveAnimatorPresent.m
//  RSTransitionSample
//
//  Created by Ruslan Samsonov on 6/27/15.
//  Copyright (c) 2015 Ruslan Samsonov. All rights reserved.
//

#import "RSInteractiveAnimatorPresent.h"
#import "RSAnimationGroupUtil.h"

static CGFloat const RSInteractiveAnimatorFinishAnimationDistance = 50.0f;
static CGFloat const RSInteractiveAnimatorFinishAnimationPercent = 0.5f;

@interface RSInteractiveAnimatorPresent()
@property (nonatomic, assign) CGPoint beginPoint;
@property (nonatomic, strong) UIView *toControllerView;
@property (nonatomic, weak) id <UIViewControllerContextTransitioning> transitionContext;
@property (nonatomic, strong) UIPanGestureRecognizer *panRecognizer;
@end

@implementation RSInteractiveAnimatorPresent

- (instancetype)initWithSourceController:(UIViewController *)viewController presentationBlock:(void (^)(void))presentationBlock
{
    if (self = [super init]) {
        _sourceController = viewController;
        _presentationBlock = presentationBlock;
        
        _panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPan:)];
        [_sourceController.view addGestureRecognizer:_panRecognizer];
    }
    return self;
}

- (void)dealloc
{
    [_sourceController.view removeGestureRecognizer:_panRecognizer];
}

#pragma mark -
- (void)startInteractiveTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    _transitionContext = transitionContext;
    UIView *containerView = [transitionContext containerView];
    UIViewController *fromController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toController.view.center = fromController.view.center;
    [containerView insertSubview:toController.view aboveSubview:fromController.view];
    _toControllerView = toController.view;
    _toControllerView.transform = CGAffineTransformMakeScale(0.0f, 0.0f);
}

#pragma mark - Animation State
- (void)updateWithDistance:(CGFloat)distance
{
    CGFloat percent = [self percentForDistance:distance];
    [_transitionContext updateInteractiveTransition:percent];
    [self updateAnimationWithPercent:percent];
}

- (void)updateAnimationWithPercent:(CGFloat)percent
{
    _toControllerView.transform = CGAffineTransformMakeScale(percent, percent);
}

- (void)finishWithDistance:(CGFloat)distance
{
    CGFloat percent = [self percentForDistance:distance];
    [self finishAnimation:!(percent > RSInteractiveAnimatorFinishAnimationPercent)];
}

- (void)finishAnimation:(BOOL)cancelled
{
    void (^completeBlock)(BOOL) = ^(BOOL cancelled) {
        cancelled ? [_transitionContext cancelInteractiveTransition] : [_transitionContext finishInteractiveTransition];
        [_transitionContext completeTransition:!cancelled];
        _toControllerView = nil;
        _transitionContext = nil;
    };
    [UIView animateWithDuration:0.1f animations:^(void) {
        //0.0f scale not animated
            [self updateAnimationWithPercent:cancelled ? 0.01f : 1.0f];
        } completion:^(BOOL finished) {
            completeBlock(cancelled);
        }
    ];
}


- (CGFloat)percentForDistance:(CGFloat)distance
{
    return MIN(1.0f, distance / RSInteractiveAnimatorFinishAnimationDistance);
}

#pragma mark - UIPanGestureRecognizer
- (void)onPan:(UIPanGestureRecognizer *)panRecognizer
{
    CGPoint changedPoint = [panRecognizer translationInView:panRecognizer.view];
    switch (panRecognizer.state) {
        case UIGestureRecognizerStateBegan:
        {
            _beginPoint = changedPoint;
            if (_presentationBlock) {
                _presentationBlock();
            }
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
            CGFloat distance = hypot(changedPoint.x - _beginPoint.x, changedPoint.y - _beginPoint.y);
            [self updateWithDistance:distance];
            break;
        }
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
        {
            CGFloat distance = hypot(changedPoint.x - _beginPoint.x, changedPoint.y - _beginPoint.y);
            [self finishWithDistance:distance];
            break;
        }
        default:
            break;
    }
}
@end
