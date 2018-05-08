//
//  CAAnimation+XLsn0w.h
//  XLsn0w
//
//  Created by XLsn0w on 16/7/5.
//  Copyright © 2016年 XLsn0w. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <Foundation/Foundation.h>

@interface CAAnimation (XLsn0w)

@end

/**************************************************************************************************/

typedef NS_ENUM(NSInteger, CAAnimationEasingFunction) {
    CAAnimationEasingFunctionLinear,
    
    CAAnimationEasingFunctionEaseInQuad,
    CAAnimationEasingFunctionEaseOutQuad,
    CAAnimationEasingFunctionEaseInOutQuad,
    
    CAAnimationEasingFunctionEaseInCubic,
    CAAnimationEasingFunctionEaseOutCubic,
    CAAnimationEasingFunctionEaseInOutCubic,
    
    CAAnimationEasingFunctionEaseInQuartic,
    CAAnimationEasingFunctionEaseOutQuartic,
    CAAnimationEasingFunctionEaseInOutQuartic,
    
    CAAnimationEasingFunctionEaseInQuintic,
    CAAnimationEasingFunctionEaseOutQuintic,
    CAAnimationEasingFunctionEaseInOutQuintic,
    
    CAAnimationEasingFunctionEaseInSine,
    CAAnimationEasingFunctionEaseOutSine,
    CAAnimationEasingFunctionEaseInOutSine,
    
    CAAnimationEasingFunctionEaseInExponential,
    CAAnimationEasingFunctionEaseOutExponential,
    CAAnimationEasingFunctionEaseInOutExponential,
    
    CAAnimationEasingFunctionEaseInCircular,
    CAAnimationEasingFunctionEaseOutCircular,
    CAAnimationEasingFunctionEaseInOutCircular,
    
    CAAnimationEasingFunctionEaseInElastic,
    CAAnimationEasingFunctionEaseOutElastic,
    CAAnimationEasingFunctionEaseInOutElastic,
    
    CAAnimationEasingFunctionEaseInBack,
    CAAnimationEasingFunctionEaseOutBack,
    CAAnimationEasingFunctionEaseInOutBack,
    
    CAAnimationEasingFunctionEaseInBounce,
    CAAnimationEasingFunctionEaseOutBounce,
    CAAnimationEasingFunctionEaseInOutBounce
};

@interface CAAnimation (JKEasingEquations)
+ (CAKeyframeAnimation*)jk_transformAnimationWithDuration:(CGFloat)duration
                                                     from:(CATransform3D)startValue
                                                       to:(CATransform3D)endValue
                                           easingFunction:(CAAnimationEasingFunction)easingFunction;

+ (void)jk_addAnimationToLayer:(CALayer *)layer
                      duration:(CGFloat)duration
                     transform:(CATransform3D)transform
                easingFunction:(CAAnimationEasingFunction)easingFunction;

+ (CAKeyframeAnimation*)jk_animationWithKeyPath:(NSString *)keyPath
                                       duration:(CGFloat)duration
                                           from:(CGFloat)startValue
                                             to:(CGFloat)endValue
                                 easingFunction:(CAAnimationEasingFunction)easingFunction;

+ (void)jk_addAnimationToLayer:(CALayer *)layer
                   withKeyPath:(NSString *)keyPath
                      duration:(CGFloat)duration
                            to:(CGFloat)endValue
                easingFunction:(CAAnimationEasingFunction)easingFunction;

+ (void)jk_addAnimationToLayer:(CALayer *)layer
                   withKeyPath:(NSString *)keyPath
                      duration:(CGFloat)duration
                          from:(CGFloat)startValue
                            to:(CGFloat)endValue
                easingFunction:(CAAnimationEasingFunction)easingFunction;
@end
