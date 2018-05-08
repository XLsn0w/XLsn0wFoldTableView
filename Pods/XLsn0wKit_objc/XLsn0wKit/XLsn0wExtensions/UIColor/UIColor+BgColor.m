

#import "UIColor+BgColor.h"

@implementation UIColor (BgColor)

+(UIColor*) colorWithRGB:(NSUInteger)rgb
{
    return [UIColor colorWithRGB:rgb alpha:1.0f];
}
+(UIColor*) colorWithRGB:(NSUInteger)rgb alpha:(CGFloat)alpha
{
    NSUInteger red = ( (rgb&0xff0000) >> 16 );
    NSUInteger green = ( (rgb&0xff00) >> 8 );
    NSUInteger blue = ( rgb & 0xFF );
    CGFloat r = (CGFloat)red / 255.0f;
    CGFloat g = (CGFloat)green  / 255.0f;
    CGFloat b = (CGFloat)blue / 255.0f;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:alpha];
}

@end
