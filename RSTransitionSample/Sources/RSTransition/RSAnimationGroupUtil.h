//
//  RSAnimationGroupUtil.h
//  RSTransitionSample
//
//  Created by Ruslan Samsonov on 6/28/15.
//  Copyright (c) 2015 Ruslan Samsonov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RSAnimationGroupUtil : NSObject
+ (CAAnimationGroup *)createRotateAndScaleAnimationWithDuration:(CGFloat)duration;
+ (CAAnimationGroup *)createBackwardsRotateAndScaleAnimationWithDuration:(CGFloat)duration;
@end
