//
//  UIViewController+RSTransitioning.m
//  TransitionSample
//
//  Created by Ruslan Samsonov on 6/27/15.
//  Copyright (c) 2015 Ruslan Samsonov. All rights reserved.
//

#import "UIViewController+RSTransitioning.h"
#import "AppDelegate.h"
#import "RSTransitioningManager.h"

@implementation UIViewController (RSTransitioning)
- (void)presentRSViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion
{
    id <RSTransitioningManager> transitionManager = [((AppDelegate *)[[UIApplication sharedApplication] delegate]) transitionManager];
    viewControllerToPresent.modalPresentationStyle = UIModalPresentationCustom;
    viewControllerToPresent.transitioningDelegate = [transitionManager transitionDelegateForSourceController:self shownController:viewControllerToPresent];
    [self presentViewController:viewControllerToPresent animated:flag completion:completion];
}

- (void)dismissRSViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion
{
    id <RSTransitioningManager> transitionManager = [((AppDelegate *)[[UIApplication sharedApplication] delegate]) transitionManager];
    self.presentedViewController.transitioningDelegate = [transitionManager transitionDelegateForSourceController:self shownController:self.presentedViewController];
    [self dismissViewControllerAnimated:flag completion:completion];
}
@end
