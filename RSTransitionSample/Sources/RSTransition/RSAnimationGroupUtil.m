//
//  RSAnimationGroupUtil.m
//  RSTransitionSample
//
//  Created by Ruslan Samsonov on 6/28/15.
//  Copyright (c) 2015 Ruslan Samsonov. All rights reserved.
//

#import "RSAnimationGroupUtil.h"

@implementation RSAnimationGroupUtil
+ (CAAnimationGroup *)createRotateAndScaleAnimationWithDuration:(CGFloat)duration;
{
    CABasicAnimation *zoom = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    zoom.fromValue = @(0.0f);
    zoom.toValue = @(1.0f);
    
    CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotation.toValue = @(M_PI * 2);
    
    CABasicAnimation *color = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    color.fromValue = (__bridge id)([[UIColor redColor] CGColor]);
    color.toValue = (__bridge id)([[UIColor grayColor] CGColor]);
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[rotation, zoom, color];
    group.duration = duration;
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    
    return group;
}

+ (CAAnimationGroup *)createBackwardsRotateAndScaleAnimationWithDuration:(CGFloat)duration
{
    CABasicAnimation *zoom = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    zoom.toValue = @(0.0f);
    zoom.fromValue = @(1.0f);
    
    CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotation.toValue = @(-M_PI * 2);
    
    CABasicAnimation *color = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    color.toValue = (__bridge id)([[UIColor redColor] CGColor]);
    color.fromValue = (__bridge id)([[UIColor grayColor] CGColor]);
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[rotation, zoom, color];
    group.duration = duration;
    
    return group;
}
@end
