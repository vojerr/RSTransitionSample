//
//  UIViewController+RSTransitioning.h
//  RSTransitionSample
//
//  Created by Ruslan Samsonov on 6/27/15.
//  Copyright (c) 2015 Ruslan Samsonov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (RSTransitioning)
- (void)presentRSViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion;
- (void)dismissRSViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion;
@end
