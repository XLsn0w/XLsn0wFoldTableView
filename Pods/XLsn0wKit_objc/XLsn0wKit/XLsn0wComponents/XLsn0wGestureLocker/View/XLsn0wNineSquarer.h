///  九宫格 手势密码页面
#import <UIKit/UIKit.h>

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define Screen_Width  [UIScreen mainScreen].bounds.size.width
#define Screen_Height [UIScreen mainScreen].bounds.size.height

@class XLsn0wNineSquarer;
@protocol ZLGestureLockDelegate <NSObject>

- (void)gestureLockView:(XLsn0wNineSquarer *)lockView drawRectFinished:(NSMutableString *)gesturePassword;

@end

@interface XLsn0wNineSquarer : UIView

@property (assign, nonatomic) id<ZLGestureLockDelegate> delegate;

@end
