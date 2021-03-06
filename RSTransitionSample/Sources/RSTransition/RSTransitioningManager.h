//
//  RSTransitioningManager.h
//  RSTransitionSample
//
//  Created by Ruslan Samsonov on 6/27/15.
//  Copyright (c) 2015 Ruslan Samsonov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol RSTransitioningManager <NSObject>
- (id <UIViewControllerTransitioningDelegate>)transitionDelegateForSourceController:(UIViewController *)sourceController shownController:(UIViewController *)shownController;
@end
