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

#import "XLsn0wShow.h"

//Toast默认停留时间
#define ToastDispalyDuration 1.2f
//Toast到顶端/底端默认距离
#define ToastSpace 100.0f
//Toast背景颜色
#define ToastBackgroundColor [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.75]

@interface XLsn0wShow ()

@property(nonatomic,strong)UIButton *contentView;
@property(nonatomic,assign)CGFloat duration;

@end

@implementation XLsn0wShow

- (id)initWithText:(NSString *)text{
    if (self = [super init]) {

        UIFont *font = [UIFont boldSystemFontOfSize:16];
        NSDictionary * dict=[NSDictionary dictionaryWithObject: font forKey:NSFontAttributeName];
        CGRect rect=[text boundingRectWithSize:CGSizeMake(250,CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,rect.size.width + 40, rect.size.height+ 20)];
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.textColor = [UIColor whiteColor];
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.font = font;
        textLabel.text = text;
        textLabel.numberOfLines = 0;
        
        self.contentView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, textLabel.frame.size.width, textLabel.frame.size.height)];
        self.contentView.layer.cornerRadius = 20.0f;
        self.contentView.backgroundColor = ToastBackgroundColor;
        [self.contentView addSubview:textLabel];
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self.contentView addTarget:self action:@selector(toastTaped:) forControlEvents:UIControlEventTouchDown];
        self.contentView.alpha = 0.0f;
        self.duration = ToastDispalyDuration;
        
    }
    
    return self;
}

-(void)dismissToast{
    
    [self.contentView removeFromSuperview];
}

-(void)toastTaped:(UIButton *)sender{
    
    [self hideAnimation];
}

-(void)showAnimation{
    [UIView beginAnimations:@"show" context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.3];
    self.contentView.alpha = 1.0f;
    [UIView commitAnimations];
}

-(void)hideAnimation{
    [UIView beginAnimations:@"hide" context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(dismissToast)];
    [UIView setAnimationDuration:0.3];
    self.contentView.alpha = 0.0f;
    [UIView commitAnimations];
}
+(UIWindow *)window
{
    return [[[UIApplication sharedApplication] windows] lastObject];
}

- (void)showIn:(UIView *)view{
    self.contentView.center = view.center;
    [view  addSubview:self.contentView];
    [self showAnimation];
    [self performSelector:@selector(hideAnimation) withObject:nil afterDelay:self.duration];
}

- (void)showIn:(UIView *)view fromTopOffset:(CGFloat)top{
    self.contentView.center = CGPointMake(view.center.x, top + self.contentView.frame.size.height/2);
    [view  addSubview:self.contentView];
    [self showAnimation];
    [self performSelector:@selector(hideAnimation) withObject:nil afterDelay:self.duration];
}

- (void)showIn:(UIView *)view fromBottomOffset:(CGFloat)bottom{
    self.contentView.center = CGPointMake(view.center.x, view.frame.size.height-(bottom + self.contentView.frame.size.height/2));
    [view  addSubview:self.contentView];
    [self showAnimation];
    [self performSelector:@selector(hideAnimation) withObject:nil afterDelay:self.duration];
}

#pragma mark-中间显示
+ (void)showCenterWithText:(NSString *)text{
    
    [XLsn0wShow showCenterWithText:text duration:ToastDispalyDuration];
}

+ (void)showCenterWithText:(NSString *)text duration:(CGFloat)duration{
    
    XLsn0wShow *toast = [[XLsn0wShow alloc] initWithText:text];
    toast.duration = duration;
    [toast showIn:[self window]];
}
#pragma mark-上方显示
+ (void)showTopWithText:(NSString *)text{
    
    [XLsn0wShow showTopWithText:text  topOffset:ToastSpace duration:ToastDispalyDuration];
}
+ (void)showTopWithText:(NSString *)text duration:(CGFloat)duration
{
     [XLsn0wShow showTopWithText:text  topOffset:ToastSpace duration:duration];
}
+ (void)showTopWithText:(NSString *)text topOffset:(CGFloat)topOffset{
    [XLsn0wShow showTopWithText:text  topOffset:topOffset duration:ToastDispalyDuration];
}

+ (void)showTopWithText:(NSString *)text topOffset:(CGFloat)topOffset duration:(CGFloat)duration{
    XLsn0wShow *toast = [[XLsn0wShow alloc] initWithText:text];
    toast.duration = duration;
    [toast showIn:[self window] fromTopOffset:topOffset];
}
#pragma mark-下方显示
+ (void)showBottomWithText:(NSString *)text{
    
    [XLsn0wShow showBottomWithText:text  bottomOffset:ToastSpace duration:ToastDispalyDuration];
}
+ (void)showBottomWithText:(NSString *)text duration:(CGFloat)duration
{
      [XLsn0wShow showBottomWithText:text  bottomOffset:ToastSpace duration:duration];
}
+ (void)showBottomWithText:(NSString *)text bottomOffset:(CGFloat)bottomOffset{
    [XLsn0wShow showBottomWithText:text  bottomOffset:bottomOffset duration:ToastDispalyDuration];
}

+ (void)showBottomWithText:(NSString *)text bottomOffset:(CGFloat)bottomOffset duration:(CGFloat)duration{
    XLsn0wShow *toast = [[XLsn0wShow alloc] initWithText:text];
    toast.duration = duration;
    [toast showIn:[self window] fromBottomOffset:bottomOffset];
}

@end

@implementation UIView (XHToast)

#pragma mark-中间显示
- (void)showXHToastCenterWithText:(NSString *)text {
    [self showXHToastCenterWithText:text duration:ToastDispalyDuration];
}

- (void)showXHToastCenterWithText:(NSString *)text duration:(CGFloat)duration {
    XLsn0wShow *toast = [[XLsn0wShow alloc] initWithText:text];
    toast.duration = duration;
    [toast showIn:self];
}

#pragma mark-上方显示
- (void)showXHToastTopWithText:(NSString *)text {
    [self showXHToastTopWithText:text topOffset:ToastSpace duration:ToastDispalyDuration];
}

- (void)showXHToastTopWithText:(NSString *)text duration:(CGFloat)duration {
    [self showXHToastTopWithText:text topOffset:ToastSpace duration:duration];
}

- (void)showXHToastTopWithText:(NSString *)text topOffset:(CGFloat)topOffset {
    [self showXHToastTopWithText:text topOffset:topOffset duration:ToastDispalyDuration];
}

- (void)showXHToastTopWithText:(NSString *)text topOffset:(CGFloat)topOffset duration:(CGFloat)duration {
    XLsn0wShow *toast = [[XLsn0wShow alloc] initWithText:text];
    toast.duration = duration;
    [toast showIn:self fromTopOffset:topOffset];
}

#pragma mark-下方显示
- (void)showXHToastBottomWithText:(NSString *)text {
    [self showXHToastBottomWithText:text bottomOffset:ToastSpace duration:ToastDispalyDuration];
}

- (void)showXHToastBottomWithText:(NSString *)text duration:(CGFloat)duration {
    [self showXHToastBottomWithText:text bottomOffset:ToastSpace duration:duration];
}

- (void)showXHToastBottomWithText:(NSString *)text bottomOffset:(CGFloat)bottomOffset {
    [self showXHToastBottomWithText:text bottomOffset:bottomOffset duration:ToastDispalyDuration];
}

- (void)showXHToastBottomWithText:(NSString *)text bottomOffset:(CGFloat)bottomOffset duration:(CGFloat)duration {
    XLsn0wShow *toast = [[XLsn0wShow alloc] initWithText:text];
    toast.duration = duration;
    [toast showIn:self fromBottomOffset:bottomOffset];
}

@end

