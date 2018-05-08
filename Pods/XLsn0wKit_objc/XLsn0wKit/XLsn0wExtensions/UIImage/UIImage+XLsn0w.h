
#import <UIKit/UIKit.h>

@interface UIImage (XLsn0w)

/**
 *  Create a pure color image only use the code
 *
 *  @param size  Size of the image
 *  @param color Pure color of the image
 *
 *  @return created image 
 */
+ (UIImage *)xlsn0w_createImageWithCGSize:(CGSize)size color:(UIColor *)color;
+ (UIImage *)xlsn0w_createImageWithCGSize:(CGSize)size andColor:(UIColor *)color;

/**
 *  Create a arrow image use CoreGraphics methods.
 *
 *  @param color The arrow color.
 *
 *  @return The arrow image.
 */
+ (UIImage *)xlsn0w_navigtionBarBackButtonImage:(UIColor *)color;

@end

@interface UIImage (imageNamed)

// 如果跟系统方法差不多功能,可以采取添加前缀,与系统方法区分
+ (UIImage *)wg_imageWithName:(NSString *)imageName;

@end

@interface UIImage (StretchSize)

/** 返回一张图片，按指定方式拉伸的图片：width * 0.5 : height * 0.5 */
+ (UIImage *)stretchImageSizeWithName:(NSString *)name;

@end

