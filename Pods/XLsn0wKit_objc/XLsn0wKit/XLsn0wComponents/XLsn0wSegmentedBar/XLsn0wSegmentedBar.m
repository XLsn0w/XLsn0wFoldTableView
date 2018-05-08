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

#import "XLsn0wSegmentedBar.h"

#define MainScreen_W [UIScreen mainScreen].bounds.size.width

@interface XLsn0wSegmentedBar () <UIScrollViewDelegate>

@end

@implementation XLsn0wSegmentedBar

- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray subviewArray:(NSArray *)subviewArray {
    if (self = [super initWithFrame:frame]) {
        _bottomScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, _xlsn0wSegmentedView.frame.size.height, MainScreen_W, self.bounds.size.height-_xlsn0wSegmentedView.bounds.size.height)];
        [self addSubview:_bottomScrollView];
        _bottomScrollView.contentSize=CGSizeMake(MainScreen_W*subviewArray.count, self.bounds.size.height-_xlsn0wSegmentedView.bounds.size.height);
        _bottomScrollView.backgroundColor=[UIColor whiteColor];
        _bottomScrollView.showsVerticalScrollIndicator=NO;
        _bottomScrollView.showsHorizontalScrollIndicator=NO;
        _bottomScrollView.delegate=self;
        _bottomScrollView.bounces=NO;
        _bottomScrollView.pagingEnabled=YES;
        
        //Click XLsn0wSegmentedBar Event
        _xlsn0wSegmentedView=[[XLsn0wSegmentedView alloc] initWithFrame:CGRectMake(0, 0, MainScreen_W, 35) titles:titleArray clickBlick:^void(NSInteger index) {
            [_bottomScrollView setContentOffset:CGPointMake(MainScreen_W * (index-1), 0)];
            [self.xlsn0wDelegate segmentedBar:self didSelectAtIndex:(index-1)];
        }];
        [self addSubview:_xlsn0wSegmentedView];
        
        //scroll XLsn0wSegmentedBar Event
        for (int i = 0; i < subviewArray.count; i++) {
            UIView *contentView = (UIView *)subviewArray[i];
            contentView.frame=CGRectMake(MainScreen_W * i, _xlsn0wSegmentedView.bounds.size.height, MainScreen_W, _bottomScrollView.frame.size.height-_xlsn0wSegmentedView.bounds.size.height);
            [_bottomScrollView addSubview:contentView];
        }
    }
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint point = scrollView.contentOffset;
    [_xlsn0wSegmentedView updateselectLineFrameWithoffset:point.x];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == _bottomScrollView) {
        NSInteger index = _bottomScrollView.contentOffset.x/MainScreen_W;
        _xlsn0wSegmentedView.defaultIndex = index+1;
        [self.xlsn0wDelegate segmentedBar:self didSelectAtIndex:index];
    }
    
}

@end

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

#define windowContentWidth  ([[UIScreen mainScreen] bounds].size.width)
#define SFQRedColor [UIColor colorWithRed:255/255.0 green:92/255.0 blue:79/255.0 alpha:1]
#define MAX_TitleNumInWindow 5

@interface XLsn0wSegmentedView()

@property (nonatomic,strong) NSMutableArray *btns;
@property (nonatomic,strong) NSArray *titles;
@property (nonatomic,strong) NSMutableArray *titlesStrWidthArray;
@property (nonatomic,strong) UIButton *titleBtn;
@property (nonatomic,strong) UIScrollView *backScrollView;
@property (nonatomic,strong) UIView *selectLine;
@property (nonatomic,assign) CGFloat btn_w;
@end

@implementation XLsn0wSegmentedView


- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titleArray clickBlick:(btnClickBlock)block {
    if (self = [super initWithFrame:frame]) {
        
        self.layer.shadowColor=[UIColor blackColor].CGColor;
        self.layer.shadowOffset=CGSizeMake(2, 2);
        self.layer.shadowRadius=2;
        self.layer.shadowOpacity=.2;
        
        self.isLoadAnimation = YES;
        self.titles=titleArray;
        self.block=block;
        
        [self initData];
        [self initViews];
    }
    return self;
}

- (void)initData {
    _btn_w=0.0;
    if (_titles.count<MAX_TitleNumInWindow+1) {
        _btn_w=windowContentWidth/_titles.count;
    }else{
        _btn_w=windowContentWidth/MAX_TitleNumInWindow;
    }
    
    _defaultIndex=1;
    _titleFont=[UIFont systemFontOfSize:15];
    _btns=[[NSMutableArray alloc] initWithCapacity:0];
    _titleNomalColor=[UIColor blackColor];
    _titleSelectColor=SFQRedColor;
}

- (void)initViews {
    self.backScrollView.contentSize=CGSizeMake(_btn_w*_titles.count, self.frame.size.height);
    [self addSubview:_backScrollView];
    
    [self.backScrollView addSubview:self.selectLine];
    
    for (int i=0; i<_titles.count; i++) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(_btn_w*i, 0, _btn_w, self.frame.size.height-2);
        btn.tag=i+1;
        [btn setTitle:_titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:_titleNomalColor forState:UIControlStateNormal];
        [btn setTitleColor:_titleSelectColor forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        [btn setBackgroundColor:[UIColor whiteColor]];
        btn.titleLabel.font=_titleFont;
        [_backScrollView addSubview:btn];
        [_btns addObject:btn];
        if (i==0) {
            _titleBtn=btn;
            btn.selected=YES;
        }
        
        //计算字串长度
        CGFloat strW = [self getlineWidth:i];
        [self.titlesStrWidthArray addObject:@(strW)];
    }
}

- (void)btnClick:(UIButton *)btn {
    
    if (self.block) {
        self.block(btn.tag);
    }
    
    if (btn.tag==_defaultIndex) {
        return;
    }else{
        _titleBtn.selected=!_titleBtn.selected;
        _titleBtn=btn;
        _titleBtn.selected=YES;
        _defaultIndex=btn.tag;
    }
    
    //计算偏移量
    CGFloat offsetX=btn.frame.origin.x - 2*_btn_w;
    if (offsetX<0) {
        offsetX=0;
    }
    CGFloat maxOffsetX= _backScrollView.contentSize.width-windowContentWidth;
    if (offsetX>maxOffsetX) {
        offsetX=maxOffsetX;
    }
    
    [UIView animateWithDuration:.2 animations:^{
        
        CGFloat lineW = [self.titlesStrWidthArray[btn.tag-1] floatValue];
        [_backScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
        _selectLine.frame=CGRectMake(btn.frame.origin.x+(_btn_w-lineW)/2, self.frame.size.height-2, lineW, 2);
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)updateselectLineFrameWithoffset:(CGFloat)offsetx {//NSLog(@"====%f",offsetx);
    
    for (UIButton *btn in _btns) {
        
        if (btn.tag-1==_defaultIndex-1) {
            _titleBtn=btn;
            
            CGFloat w = [self.titlesStrWidthArray[btn.tag-1] floatValue];//字的宽度
            CGFloat line_x = (_btn_w-w)/2+(btn.tag-1)*_btn_w;
            CGFloat nextw=0;
            
            if (offsetx<(btn.tag-1)*windowContentWidth) {//NSLog(@"向左");

                nextw = [self.titlesStrWidthArray[btn.tag-2] floatValue];
                CGFloat max_w = (_btn_w*2 + w +nextw)/2;
                CGFloat endoffsetx = (btn.tag-1)*windowContentWidth-offsetx;
                
                if (_isLoadAnimation == YES) {
                    if (_selectLine.layer.width<max_w) {
                        _selectLine.layer.width=w+MIN(endoffsetx, max_w);
                    }else{
                        _selectLine.layer.width=max_w;
                    }
                    _selectLine.layer.right=line_x+w;
                }
                
            } else {//NSLog(@"向右");
                
                nextw = [self.titlesStrWidthArray[btn.tag] floatValue];
                CGFloat max_w = (_btn_w*2 + w +nextw)/2;
                CGFloat endoffsetx = offsetx - (btn.tag-1)*windowContentWidth;
                
                if (_isLoadAnimation == YES) {
                    if (_selectLine.layer.width<max_w) {
                        _selectLine.layer.width=w+MIN(endoffsetx, max_w);
                    }else{
                        _selectLine.layer.width=max_w;
                    }
                }
            }
            
        }else{
            
        }
    }
}

- (void)setTitleNomalColor:(UIColor *)titleNomalColor {
    _titleNomalColor=titleNomalColor;
    [self updateView];
}

- (void)setTitleSelectColor:(UIColor *)titleSelectColor {
    _titleSelectColor=titleSelectColor;
    [self updateView];
}

- (void)setTitleFont:(UIFont *)titleFont {
    _titleFont=titleFont;
    [self updateView];
}

- (void)setDefaultIndex:(NSInteger)defaultIndex {
    _defaultIndex=defaultIndex;
    [self updateView];
}

- (void)updateView {
    
    for (UIButton *btn in _btns) {
        [btn setTitleColor:_titleNomalColor forState:UIControlStateNormal];
        [btn setTitleColor:_titleSelectColor forState:UIControlStateSelected];
        btn.titleLabel.font=_titleFont;
        _selectLine.backgroundColor=_titleSelectColor;
        
        if (btn.tag-1==_defaultIndex-1) {
            _titleBtn=btn;
            btn.selected=YES;
            CGFloat lineW = [self.titlesStrWidthArray[btn.tag-1] floatValue];
            
            [UIView animateWithDuration:0.3 animations:^{
                _selectLine.layer.left=btn.frame.origin.x+(_btn_w-lineW)/2;
                _selectLine.layer.width=lineW;
            }];
            
        }else{
            btn.selected=NO;
        }
    }
}

//获取线的宽度
- (CGFloat)getlineWidth:(NSInteger )strIndex {
    NSString *firstStr = _titles[strIndex];
    CGFloat lineW = [firstStr widthWithFont:_titleFont constrainedToHeight:self.frame.size.height-2]+4;

    return lineW;
}

#pragma mark - 懒加载

- (NSMutableArray *)titlesStrWidthArray {
    if (!_titlesStrWidthArray) {
        _titlesStrWidthArray = [[NSMutableArray alloc] init];
    }
    return _titlesStrWidthArray;
}

- (UIScrollView *)backScrollView {
    if (!_backScrollView) {
        _backScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, self.frame.size.height)];
        _backScrollView.backgroundColor=[UIColor whiteColor];
        _backScrollView.showsHorizontalScrollIndicator=NO;
        
    }
    return _backScrollView;
}

- (UIView *)selectLine {
    if (!_selectLine) {
        CGFloat lineW = [self getlineWidth:0];
        _selectLine=[[UIView alloc] initWithFrame:CGRectMake((_btn_w-lineW)/2, self.frame.size.height-2, lineW, 2)];
        _selectLine.backgroundColor=_titleSelectColor;
    }
    return _selectLine;
}

@end

/**************************************************************************************************/

@implementation CALayer (XLsn0wSegmentedBar)

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}



- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGPoint)center {
    return CGPointMake(self.frame.origin.x + self.frame.size.width * 0.5,
                       self.frame.origin.y + self.frame.size.height * 0.5);
}

- (void)setCenter:(CGPoint)center {
    CGRect frame = self.frame;
    frame.origin.x = center.x - frame.size.width * 0.5;
    frame.origin.y = center.y - frame.size.height * 0.5;
    self.frame = frame;
}

- (CGFloat)centerX {
    return self.frame.origin.x + self.frame.size.width * 0.5;
}

- (void)setCenterX:(CGFloat)centerX {
    CGRect frame = self.frame;
    frame.origin.x = centerX - frame.size.width * 0.5;
    self.frame = frame;
}

- (CGFloat)centerY {
    return self.frame.origin.y + self.frame.size.height * 0.5;
}

- (void)setCenterY:(CGFloat)centerY {
    CGRect frame = self.frame;
    frame.origin.y = centerY - frame.size.height * 0.5;
    self.frame = frame;
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)frameSize {
    return self.frame.size;
}

- (void)setFrameSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGFloat)transformRotation {
    NSNumber *v = [self valueForKeyPath:@"transform.rotation"];
    return v.doubleValue;
}

- (void)setTransformRotation:(CGFloat)v {
    [self setValue:@(v) forKeyPath:@"transform.rotation"];
}

- (CGFloat)transformRotationX {
    NSNumber *v = [self valueForKeyPath:@"transform.rotation.x"];
    return v.doubleValue;
}

- (void)setTransformRotationX:(CGFloat)v {
    [self setValue:@(v) forKeyPath:@"transform.rotation.x"];
}

- (CGFloat)transformRotationY {
    NSNumber *v = [self valueForKeyPath:@"transform.rotation.y"];
    return v.doubleValue;
}

- (void)setTransformRotationY:(CGFloat)v {
    [self setValue:@(v) forKeyPath:@"transform.rotation.y"];
}

- (CGFloat)transformRotationZ {
    NSNumber *v = [self valueForKeyPath:@"transform.rotation.z"];
    return v.doubleValue;
}

- (void)setTransformRotationZ:(CGFloat)v {
    [self setValue:@(v) forKeyPath:@"transform.rotation.z"];
}

- (CGFloat)transformScaleX {
    NSNumber *v = [self valueForKeyPath:@"transform.scale.x"];
    return v.doubleValue;
}

- (void)setTransformScaleX:(CGFloat)v {
    [self setValue:@(v) forKeyPath:@"transform.scale.x"];
}

- (CGFloat)transformScaleY {
    NSNumber *v = [self valueForKeyPath:@"transform.scale.y"];
    return v.doubleValue;
}

- (void)setTransformScaleY:(CGFloat)v {
    [self setValue:@(v) forKeyPath:@"transform.scale.y"];
}

- (CGFloat)transformScaleZ {
    NSNumber *v = [self valueForKeyPath:@"transform.scale.z"];
    return v.doubleValue;
}

- (void)setTransformScaleZ:(CGFloat)v {
    [self setValue:@(v) forKeyPath:@"transform.scale.z"];
}

- (CGFloat)transformScale {
    NSNumber *v = [self valueForKeyPath:@"transform.scale"];
    return v.doubleValue;
}

- (void)setTransformScale:(CGFloat)v {
    [self setValue:@(v) forKeyPath:@"transform.scale"];
}

- (CGFloat)transformTranslationX {
    NSNumber *v = [self valueForKeyPath:@"transform.translation.x"];
    return v.doubleValue;
}

- (void)setTransformTranslationX:(CGFloat)v {
    [self setValue:@(v) forKeyPath:@"transform.translation.x"];
}

- (CGFloat)transformTranslationY {
    NSNumber *v = [self valueForKeyPath:@"transform.translation.y"];
    return v.doubleValue;
}

- (void)setTransformTranslationY:(CGFloat)v {
    [self setValue:@(v) forKeyPath:@"transform.translation.y"];
}

- (CGFloat)transformTranslationZ {
    NSNumber *v = [self valueForKeyPath:@"transform.translation.z"];
    return v.doubleValue;
}

- (void)setTransformTranslationZ:(CGFloat)v {
    [self setValue:@(v) forKeyPath:@"transform.translation.z"];
}


@end

/**************************************************************************************************/

@implementation NSString (XLsn0wSegmentedBar)
/**
 *  @brief 计算文字的高度
 *
 *  @param font  字体(默认为系统字体)
 *  @param width 约束宽度
 */
- (CGFloat)heightWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width
{
    UIFont *textFont = font ? font : [UIFont systemFontOfSize:[UIFont systemFontSize]];
    
    CGSize textSize;
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                     NSParagraphStyleAttributeName: paragraph};
        textSize = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                      options:(NSStringDrawingUsesLineFragmentOrigin |
                                               NSStringDrawingTruncatesLastVisibleLine)
                                   attributes:attributes
                                      context:nil].size;
    } else {
        textSize = [self sizeWithFont:textFont
                    constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)
                        lineBreakMode:NSLineBreakByWordWrapping];
    }
#else
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                 NSParagraphStyleAttributeName: paragraph};
    textSize = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                  options:(NSStringDrawingUsesLineFragmentOrigin |
                                           NSStringDrawingTruncatesLastVisibleLine)
                               attributes:attributes
                                  context:nil].size;
#endif
    
    return ceil(textSize.height);
}

/**
 *  @brief 计算文字的宽度
 *
 *  @param font   字体(默认为系统字体)
 *  @param height 约束高度
 */
- (CGFloat)widthWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height
{
    UIFont *textFont = font ? font : [UIFont systemFontOfSize:[UIFont systemFontSize]];
    
    CGSize textSize;
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                     NSParagraphStyleAttributeName: paragraph};
        textSize = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height)
                                      options:(NSStringDrawingUsesLineFragmentOrigin |
                                               NSStringDrawingTruncatesLastVisibleLine)
                                   attributes:attributes
                                      context:nil].size;
    } else {
        textSize = [self sizeWithFont:textFont
                    constrainedToSize:CGSizeMake(CGFLOAT_MAX, height)
                        lineBreakMode:NSLineBreakByWordWrapping];
    }
#else
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                 NSParagraphStyleAttributeName: paragraph};
    textSize = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height)
                                  options:(NSStringDrawingUsesLineFragmentOrigin |
                                           NSStringDrawingTruncatesLastVisibleLine)
                               attributes:attributes
                                  context:nil].size;
#endif
    
    return ceil(textSize.width);
}

/**
 *  @brief 计算文字的大小
 *
 *  @param font  字体(默认为系统字体)
 *  @param width 约束宽度
 */
- (CGSize)sizeWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width
{
    UIFont *textFont = font ? font : [UIFont systemFontOfSize:[UIFont systemFontSize]];
    
    CGSize textSize;
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                     NSParagraphStyleAttributeName: paragraph};
        textSize = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                      options:(NSStringDrawingUsesLineFragmentOrigin |
                                               NSStringDrawingTruncatesLastVisibleLine)
                                   attributes:attributes
                                      context:nil].size;
    } else {
        textSize = [self sizeWithFont:textFont
                    constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)
                        lineBreakMode:NSLineBreakByWordWrapping];
    }
#else
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                 NSParagraphStyleAttributeName: paragraph};
    textSize = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                  options:(NSStringDrawingUsesLineFragmentOrigin |
                                           NSStringDrawingTruncatesLastVisibleLine)
                               attributes:attributes
                                  context:nil].size;
#endif
    
    return CGSizeMake(ceil(textSize.width), ceil(textSize.height));
}

/**
 *  @brief 计算文字的大小
 *
 *  @param font   字体(默认为系统字体)
 *  @param height 约束高度
 */
- (CGSize)sizeWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height
{
    UIFont *textFont = font ? font : [UIFont systemFontOfSize:[UIFont systemFontSize]];
    
    CGSize textSize;
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                     NSParagraphStyleAttributeName: paragraph};
        textSize = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height)
                                      options:(NSStringDrawingUsesLineFragmentOrigin |
                                               NSStringDrawingTruncatesLastVisibleLine)
                                   attributes:attributes
                                      context:nil].size;
    } else {
        textSize = [self sizeWithFont:textFont
                    constrainedToSize:CGSizeMake(CGFLOAT_MAX, height)
                        lineBreakMode:NSLineBreakByWordWrapping];
    }
#else
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                 NSParagraphStyleAttributeName: paragraph};
    textSize = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height)
                                  options:(NSStringDrawingUsesLineFragmentOrigin |
                                           NSStringDrawingTruncatesLastVisibleLine)
                               attributes:attributes
                                  context:nil].size;
#endif
    
    return CGSizeMake(ceil(textSize.width), ceil(textSize.height));
}


/**
 *  @brief  反转字符串
 *
 *  @param strSrc 被反转字符串
 *
 *  @return 反转后字符串
 */
+ (NSString *)reverseString:(NSString *)strSrc {
    NSMutableString* reverseString = [[NSMutableString alloc] init];
    NSInteger charIndex = [strSrc length];
    while (charIndex > 0) {
        charIndex --;
        NSRange subStrRange = NSMakeRange(charIndex, 1);
        [reverseString appendString:[strSrc substringWithRange:subStrRange]];
    }
    return reverseString;
}

@end

