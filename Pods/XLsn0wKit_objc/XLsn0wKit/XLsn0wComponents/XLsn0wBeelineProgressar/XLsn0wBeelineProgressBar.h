
#import <UIKit/UIKit.h>

typedef enum {
    XLsn0wProgressBarType_Beeline = 0,
    XLsn0wProgressBarType_Ring,
} XLsn0wBeelineProgressBarType;

@interface XLsn0wBeelineProgressBar : UIView

/*
 *进度文字颜色
 */
@property (nonatomic,strong) UIColor *textColor;
/*
 *进度条进度
 */
@property (nonatomic,assign) float progress;
/*
 *进度条颜色
 */
@property (nonatomic,strong) UIColor *progressColor;
/*
 *进度条类型
 */
@property (nonatomic,assign) XLsn0wBeelineProgressBarType type;

/*
 *默认风格进度条是否为圆角，默认为YES
 */
@property (nonatomic,assign) BOOL isRect;

/*
 *是否使用动画效果，默认为YES
 */
@property (nonatomic,assign) BOOL isAnimation;

/*
 *环形进度条宽度
 */
@property (nonatomic,assign) float ringWidth;

@end
