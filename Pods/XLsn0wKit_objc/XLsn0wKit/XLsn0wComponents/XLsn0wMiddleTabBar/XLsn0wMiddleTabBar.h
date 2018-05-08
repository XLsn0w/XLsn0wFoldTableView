
#import <UIKit/UIKit.h>

@protocol XLsn0wMiddleTabBarDelegate <NSObject>

- (void)hookMiddleButtonEventWithMiddleButton:(UIButton *)middleButton;

@end

@class  MiddleButton;

@interface XLsn0wMiddleTabBar : UITabBar

@property (nonatomic, weak) id <XLsn0wMiddleTabBarDelegate> delegater;
@property (nonatomic, strong) MiddleButton *middleButton;

@end

@interface MiddleButton : UIButton

@end
