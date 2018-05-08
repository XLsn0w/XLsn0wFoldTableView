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
/**
 获取验证码 - 倒计时按钮
 */
#import <UIKit/UIKit.h>

@class XLsn0wCountTimeButton;

typedef NSString* (^CountDownChanging)(XLsn0wCountTimeButton *countDownButton,NSUInteger second);
typedef NSString* (^CountDownFinished)(XLsn0wCountTimeButton *countDownButton,NSUInteger second);
typedef void (^TouchedCountDownButtonHandler)(XLsn0wCountTimeButton *countDownButton,NSInteger tag);

@interface XLsn0wCountTimeButton : UIButton

@property(nonatomic, strong) id userInfo;

///倒计时按钮点击回调
- (void)countDownButtonHandler:(TouchedCountDownButtonHandler)touchedCountDownButtonHandler;
//倒计时时间改变回调
- (void)countDownChanging:(CountDownChanging)countDownChanging;
//倒计时结束回调
- (void)countDownFinished:(CountDownFinished)countDownFinished;
///开始倒计时
- (void)startCountDownWithSecond:(NSUInteger)second;
///停止倒计时
- (void)stopCountDown;

@end

/*
 
 _countDownCode = [XLsn0wCountTimeButton buttonWithType:UIButtonTypeCustom];
 _countDownCode.frame = CGRectMake(81, 200, 200, 40);
 [_countDownCode setTitle:@"开始" forState:UIControlStateNormal];
 _countDownCode.backgroundColor = [UIColor blueColor];
 [self.view addSubview:_countDownCode];
 
 
 [_countDownCode countDownButtonHandler:^(XLsn0wCountTimeButton*sender, NSInteger tag) {
 sender.enabled = NO;
 
 [sender startCountDownWithSecond:60];
 
 [sender countDownChanging:^NSString *(XLsn0wCountTimeButton *countDownButton,NSUInteger second) {
 NSString *title = [NSString stringWithFormat:@"剩余%zd秒",second];
 return title;
 }];
 [sender countDownFinished:^NSString *(XLsn0wCountTimeButton *countDownButton, NSUInteger second) {
 countDownButton.enabled = YES;
 return @"点击重新获取";
 
 }];
 
 }];
 
 */
