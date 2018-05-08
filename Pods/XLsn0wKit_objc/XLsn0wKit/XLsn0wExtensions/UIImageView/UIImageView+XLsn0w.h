
#import <UIKit/UIKit.h>

@interface UIImageView (XLsn0w)

@end

@interface UIImageView (Placeholder)

/**
 *  Set a web-cache imageView can use an scale placeholder image;
 *
 *  @param url         The web image url
 *  @param placeholder The place holder image can scale
 */
- (void)sd_setImageWithURL:(NSURL *)url placeholderImageScale:(UIImage *)placeholder;

- (UIImage *)scaleImage:(UIImage *)originImage;

@end
