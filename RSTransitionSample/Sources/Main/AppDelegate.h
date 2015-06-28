//
//  AppDelegate.h
//  RSTransitionSample
//
//  Created by Ruslan Samsonov on 6/27/15.
//  Copyright (c) 2015 Ruslan Samsonov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSTransitioningManager.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) id <RSTransitioningManager> transitionManager;
@end

