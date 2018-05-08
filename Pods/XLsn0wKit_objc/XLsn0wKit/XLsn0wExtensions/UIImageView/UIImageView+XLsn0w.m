
#import "UIImageView+XLsn0w.h"

@implementation UIImageView (XLsn0w)

@end

#import "UIImageView+WebCache.h"

@implementation UIImageView (Placeholder)

- (void)sd_setImageWithURL:(NSURL *)url placeholderImageScale:(UIImage *)placeholder {
    placeholder = [self scaleImage:placeholder];
    [self sd_setImageWithURL:url placeholderImage:placeholder];
}

- (UIImage *)scaleImage:(UIImage *)originImage {
    CGSize imageSize = self.frame.size;
    //判断图片尺寸是否小于UIImageView的尺寸
    if(imageSize.width <= originImage.size.width ||
       imageSize.height <= originImage.size.height)
        return originImage;
    //绘制新的图片
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [[UIColor colorWithRed:238.0/255.0f green:238.0/255.0f blue:238.0/255.0f alpha:1.0f] set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    [originImage drawAtPoint:CGPointMake((imageSize.width - originImage.size.width)/2.0f, (imageSize.height - originImage.size.height)/2.0f)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end