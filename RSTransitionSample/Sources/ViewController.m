//
//  ViewController.m
//  RSTransitionSample
//
//  Created by Ruslan Samsonov on 6/27/15.
//  Copyright (c) 2015 Ruslan Samsonov. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+RSTransitioning.h"
#import "ShownViewController.h"
#import "RSInteractiveAnimatorPresent.h"
#import "RSTransitonAnimatorPresent.h"

@interface ViewController () <UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) RSInteractiveAnimatorPresent *interactivePresentAnimator;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //Simple transition
    [self.view addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)]];
    
    //Interactive transition
    __weak typeof(self) weakSelf = self;
    _interactivePresentAnimator = [[RSInteractiveAnimatorPresent alloc] initWithSourceController:self presentationBlock:^(void) {
        ShownViewController *shownController = [ShownViewController new];
        shownController.modalPresentationStyle = UIModalPresentationCustom;
        shownController.transitioningDelegate = self;
        [weakSelf presentViewController:shownController animated:YES completion:nil];
    }];
    self.transitioningDelegate = self;
}

#pragma mark - Non-interactive transition
- (void)onTap:(UILongPressGestureRecognizer *)tapRecognizer
{
    if (self.presentedViewController)   return;
    
    [self presentRSViewController:[ShownViewController new] animated:YES completion:nil];
}

#pragma mark - UIViewControllerTransitioningDelegate
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    //Funny thing
    //To use interactive transition, must return something with implemented -transitionDuration method.
    //UIPercentDrivenInteractiveTransition compatibility
    return [RSTransitonAnimatorPresent new];
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator
{
    return _interactivePresentAnimator;
}
@end
