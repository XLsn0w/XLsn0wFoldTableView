
#import "UIImage+XLsn0w.h"
#import <UIKit/UIKit.h>

@implementation UIImage (XLsn0w)

+ (UIImage *)xlsn0w_createImageWithCGSize:(CGSize)size color:(UIColor *)color {
    CGSize imageSize = size;
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [color set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)xlsn0w_createImageWithCGSize:(CGSize)size andColor:(UIColor *)color {
    return [self xlsn0w_createImageWithCGSize:size color:color];
}


+ (UIImage *)xlsn0w_navigtionBarBackButtonImage:(UIColor *)color {
    CGSize size = CGSizeMake(16.0, 30.0);
    UIGraphicsBeginImageContextWithOptions(size, 0, [UIScreen mainScreen].scale);
    [[UIColor clearColor] set];
    UIRectFill(CGRectMake(0, 0, 16.0, 30.0));
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    const CGFloat *cs = CGColorGetComponents(color.CGColor);
    //画四个边角
    CGContextSetLineWidth(ctx, 2.5);
    CGContextSetRGBStrokeColor(ctx, cs[0], cs[1], cs[2], CGColorGetAlpha(color.CGColor));
    
    //左上角
    CGPoint pointA[] = {
        CGPointMake(1, 15.5),
        CGPointMake(10, 6)
    };
    
    CGPoint pointB[] = {
        CGPointMake(1, 14.5),
        CGPointMake(10, 24)
    };
    CGContextAddLines(ctx, pointA, 2);
    CGContextAddLines(ctx, pointB, 2);
    CGContextStrokePath(ctx);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end

#import <objc/runtime.h>

@implementation UIImage (imageNamed)
/**
 定义完毕新方法后,需要弄清楚什么时候实现与系统的方法交互?
 答 : 既然是给系统的方法添加额外的功能,换句话说,我们以后在开发中都是使用自己定义的方法,取代系统的方法,所以,当程序一启动,就要求能使用自己定义的功能方法.说这里:我们必须要弄明白一下两个方法 :
 +(void)initialize(当类第一次被调用的时候就会调用该方法,整个程序运行中只会调用一次)
 + (void)load(当程序启动的时候就会调用该方法,换句话说,只要程序一启动就会调用load方法,整个程序运行中只会调用一次)
 */

+ (void)load {
    /*
     self:UIImage
     谁的事情,谁开头 1.发送消息(对象:objc) 2.注册方法(方法编号:sel) 3.交互方法(方法:method) 4.获取方法(类:class)
     Method:方法名
     
     获取方法,方法保存到类
     Class:获取哪个类方法
     SEL:获取哪个方法
     imageName
     */
    // 获取imageName:方法的地址
    Method imageNameMethod = class_getClassMethod(self, @selector(imageNamed:));
    
    // 获取wg_imageWithName:方法的地址
    Method wg_imageWithNameMethod = class_getClassMethod(self, @selector(wg_imageWithName:));
    
    // 交换方法地址，相当于交换实现方式
    method_exchangeImplementations(imageNameMethod, wg_imageWithNameMethod);
    
}

// 加载图片, 判断是否为空
+ (UIImage *)wg_imageWithName:(NSString *)imageName {
    // 这里调用imageWithName，相当于调用imageName
    UIImage *image = [UIImage wg_imageWithName:imageName];
    if (!image) {
        NSLog(@"imageNamed对应图片名称不符或者不存在");
    }
    return image;
}

@end

@implementation UIImage (StretchSize)

+ (UIImage *)stretchImageSizeWithName:(NSString *)name {
    UIImage *image = [UIImage imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

@end







