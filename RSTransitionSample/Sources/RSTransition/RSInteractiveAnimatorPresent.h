//
//  RSInteractiveAnimatorPresent.m
//  RSTransitionSample
//
//  Created by Ruslan Samsonov on 6/27/15.
//  Copyright (c) 2015 Ruslan Samsonov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RSInteractiveAnimatorPresent : NSObject <UIViewControllerInteractiveTransitioning>
@property (nonatomic, weak, readonly) UIViewController *sourceController;
@property (nonatomic, strong, readonly) void (^presentationBlock)(void);

- (instancetype)initWithSourceController:(UIViewController *)viewController presentationBlock:(void (^)(void))presentationBlock;
@end
