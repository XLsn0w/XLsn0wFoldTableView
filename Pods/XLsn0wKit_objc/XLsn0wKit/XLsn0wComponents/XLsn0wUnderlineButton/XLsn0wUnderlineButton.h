

#define kLUHUnderLineButtonUnderLineTag 2000
#define kLUHUnderLineButtonUnderLinePadding 10
#define kLUHUnderLineButtonUnderLineHeight 4

#import <UIKit/UIKit.h>

@interface XLsn0wUnderlineButton : UIView

@property (nonatomic) NSInteger selectedIndex;

- (nullable instancetype)initWithItems:(nullable NSArray *)items;
- (void)addTarget:(nullable id)target action:(nonnull SEL)action;

@end
