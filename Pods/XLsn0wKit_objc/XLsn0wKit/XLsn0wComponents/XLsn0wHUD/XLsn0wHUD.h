/*********************************************************************************************
 *   __      __   _         _________     _ _     _    _________   __         _         __   *
 *	 \ \    / /  | |        | _______|   | | \   | |  |  ______ |  \ \       / \       / /   *
 *	  \ \  / /   | |        | |          | |\ \  | |  | |     | |   \ \     / \ \     / /    *
 *     \ \/ /    | |        | |______    | | \ \ | |  | |     | |    \ \   / / \ \   / /     *
 *     /\/\/\    | |        |_______ |   | |  \ \| |  | |     | |     \ \ / /   \ \ / /      *
 *    / /  \ \   | |______   ______| |   | |   \ \ |  | |_____| |      \ \ /     \ \ /       *
 *   /_/    \_\  |________| |________|   |_|    \__|  |_________|       \_/       \_/        *
 *                                                                                           *
 *********************************************************************************************/

#import <UIKit/UIKit.h>

@interface XLsn0wHUD : UIView <CAAnimationDelegate>

@property (nonatomic, weak) UIView *selfView;

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;
@property (nonatomic, strong) UILabel *textLabel;

@property (nonatomic, copy) NSString *text;

// 等待中
+ (instancetype)showLoadText:(NSString *)loadText superview:(UIView *)superview animated:(BOOL)animated;

// 提示消息
+ (instancetype)showTipText:(NSString *)tipText superview:(UIView *)superview duration:(NSTimeInterval)duration animated:(BOOL)animated;

// 取消view中的HUD
+ (void)dismissSuperview:(UIView *)superview animated:(BOOL)animated;

// 取消所有HUD
+ (void)dismissAll:(BOOL)animated;

// 取消
- (void)dismiss:(BOOL)animated;

///支付成功
+ (XLsn0wHUD *)showPayIn:(UIView*)view;
+ (XLsn0wHUD *)hidePayIn:(UIView*)view;
- (void)startPay;
- (void)hidePay;

@end

@protocol XLsn0wHUDDelegate <NSObject>

@optional
- (void)addIndicator;
- (void)addText;
- (void)compositeElements;

@end

