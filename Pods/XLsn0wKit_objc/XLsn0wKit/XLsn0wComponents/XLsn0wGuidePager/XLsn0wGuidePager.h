
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XLGuidePage : NSObject

@property (nonatomic, retain) UIImage *bgImage;
@property (nonatomic, retain) UIImage *titleImage;
@property (nonatomic, assign) CGFloat imgPositionY;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) UIFont *titleFont;
@property (nonatomic, retain) UIColor *titleColor;
@property (nonatomic, assign) CGFloat titlePositionY;
@property (nonatomic, retain) NSString *desc;
@property (nonatomic, retain) UIFont *descFont;
@property (nonatomic, retain) UIColor *descColor;
@property (nonatomic, assign) CGFloat descPositionY;
@property (nonatomic, retain) UIView *customView;

+ (XLGuidePage *)page;
+ (XLGuidePage *)pageWithCustomView:(UIView *)customV;

@end

@protocol XLGuidePageViewDelegate <NSObject>

@optional
- (void)introDidFinish;

@end

@interface XLsn0wGuidePager: UIView

@property (nonatomic, assign) id<XLGuidePageViewDelegate> xlDelegate;

// titleView Y position - from top of the screen
// pageControl Y position - from bottom of the screen
@property (nonatomic, assign) bool swipeToExit;
@property (nonatomic, assign) bool hideOffscreenPages;
@property (nonatomic, retain) UIImage *bgImage;
@property (nonatomic, retain) UIView *titleView;
@property (nonatomic, assign) CGFloat titleViewY;
@property (nonatomic, retain) UIPageControl *pageControl;
@property (nonatomic, assign) CGFloat pageControlY;
@property (nonatomic, retain) UIButton *skipButton;

@property (nonatomic, assign) NSInteger currentPageIndex;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIImageView *bgImageView;
@property (nonatomic, retain) UIImageView *pageBgBack;
@property (nonatomic, retain) UIImageView *pageBgFront;
@property (nonatomic, retain) NSArray *pages;

- (id)initWithFrame:(CGRect)frame andPages:(NSArray *)pagesArray;

- (void)showInView:(UIView *)view animateDuration:(CGFloat)duration;
- (void)hideWithFadeOutDuration:(CGFloat)duration;

@end

/*!

 - (void)showGuidePageView {
 if (![[NSUserDefaults standardUserDefaults] objectForKey:@"FirstLaunch"]) {
 
 XLGuidePage *guidePage1 = [XLGuidePage page];
 guidePage1.title = @"GuidePage1";
 guidePage1.desc = @"GuidePage1GuidePage1GuidePage1";
 guidePage1.bgImage = [UIImage imageNamed:@"GuidePage1"];
 
 XLGuidePage *guidePage2 = [XLGuidePage page];
 guidePage2.title = @"GuidePage2";
 guidePage2.desc = @"GuidePage2GuidePage2GuidePage2";
 guidePage2.bgImage = [UIImage imageNamed:@"GuidePage2"];
 
 XLGuidePage *guidePage3 = [XLGuidePage page];
 guidePage3.title = @"GuidePage3";
 guidePage3.desc = @"GuidePage3GuidePage3GuidePage3";
 guidePage3.bgImage = [UIImage imageNamed:@"GuidePage3"];
 
 XLGuidePageView *guidePageView = [[XLGuidePageView alloc] initWithFrame:[UIScreen mainScreen].bounds andPages:@[guidePage1, guidePage2, guidePage3]];
 [guidePageView showInView:[UIApplication sharedApplication].keyWindow animateDuration:0.0];
 guidePageView.xlDelegate = self;
 
 [[NSUserDefaults standardUserDefaults] setObject:@"NoFirstLaunch" forKey:@"FirstLaunch"];
 [[NSUserDefaults standardUserDefaults] synchronize];
 
 } else {
 NSLog(@"No First Launch");
 }
 }

*/
