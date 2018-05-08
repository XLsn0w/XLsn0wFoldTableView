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

#import "XLsn0wTextView.h"

#define kTopY 7.0
#define kLeftX 5.0

@interface XLsn0wTextView() <UITextViewDelegate>

@property (strong, nonatomic, readonly) UILabel *placeholderLabel;

@property (nonatomic, strong) UIColor *placeholder_color;
@property (nonatomic, strong) UIFont  *placeholder_font;
@property (nonatomic, assign) float   placeholdeWidth;

@property (nonatomic, copy) id eventBlock;
@property (nonatomic, copy) id BeginBlock;
@property (nonatomic, copy) id EndBlock;

@end

@implementation XLsn0wTextView

#pragma mark - life cycle

/*!
 * @author XLsn0w
 *
 * 绘制UIView子类 必须重新写init初始化方法 因为这是UIView子类最开始执行的方法
 */
- (instancetype)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self drawUI];
    }
    return self;
}

- (void)drawUI {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(DidChange:)
                                                 name:UITextViewTextDidChangeNotification
                                               object:self];
    
    //UITextViewTextDidBeginEditingNotification
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textViewBeginNoti:)
                                                 name:UITextViewTextDidBeginEditingNotification
                                               object:self];
    
    //UITextViewTextDidEndEditingNotification
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textViewEndNoti:)
                                                 name:UITextViewTextDidEndEditingNotification
                                               object:self];
    
    float left=kLeftX,top=kTopY,hegiht=30;
    
    self.placeholdeWidth=CGRectGetWidth(self.frame)-2*left;
    
    _placeholderLabel=[[UILabel alloc] initWithFrame:CGRectMake(left, top, _placeholdeWidth, hegiht)];
   
    _placeholderLabel.numberOfLines=0;
    _placeholderLabel.lineBreakMode=NSLineBreakByCharWrapping|NSLineBreakByWordWrapping;
    [self addSubview:_placeholderLabel];
    
    
    [self defaultConfig];
    
}

- (void)layoutSubviews {
    float left=kLeftX,top=kTopY,hegiht=self.bounds.size.height;
    self.placeholdeWidth=CGRectGetWidth(self.frame)-2*left;
    CGRect frame=_placeholderLabel.frame;
    frame.origin.x=left;
    frame.origin.y=top;
    frame.size.height=hegiht;
    frame.size.width=self.placeholdeWidth;
    _placeholderLabel.frame=frame;
    
    [_placeholderLabel sizeToFit];
}

- (void)dealloc {
    [_placeholderLabel removeFromSuperview];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - System Delegate
#pragma mark - custom Delegate
#pragma mark - Event response

- (void)defaultConfig {
    self.placeholder_color = [UIColor lightGrayColor];
    self.placeholder_font  = [UIFont systemFontOfSize:14];
    self.maxTextLength = 1000;
    self.layoutManager.allowsNonContiguousLayout = NO;
}

- (void)addMaxTextLengthWithMaxLength:(NSInteger)maxLength andEvent:(void (^)(XLsn0wTextView *text))limit {
    if (maxLength>0) {
        _maxTextLength=maxLength;
    }
    
    if (limit) {
        _eventBlock=limit;
    }
}

- (void)addTextViewBeginEvent:(void (^)(XLsn0wTextView *))begin {
    _BeginBlock=begin;
}

- (void)addTextViewEndEvent:(void (^)(XLsn0wTextView *))End {
    _EndBlock=End;
}

- (void)setUpdateHeight:(float)updateHeight {
    CGRect frame=self.frame;
    frame.size.height=updateHeight;
    self.frame=frame;
    _updateHeight=updateHeight;
}

#pragma mark - 供外部使用的公开方法 api

- (void)setPlaceholderFont:(UIFont *)font {
    self.placeholder_font=font;
}

- (void)setPlaceholderColor:(UIColor *)color {
    self.placeholder_color=color;

}

- (void)setPlaceholderOpacity:(float)opacity {
    if (opacity<0) {
        opacity=1;
    }
    self.placeholderLabel.layer.opacity=opacity;
}

#pragma mark - Noti Event

- (void)textViewBeginNoti:(NSNotification*)noti {
    
    if (_BeginBlock) {
        void(^begin)(XLsn0wTextView *text)=_BeginBlock;
        begin(self);
    }
}

- (void)textViewEndNoti:(NSNotification*)noti {
    
    if (_EndBlock) {
        void(^end)(XLsn0wTextView *text)=_EndBlock;
        end(self);
    }
}

- (void)DidChange:(NSNotification*)noti {
    
    if (self.placeholder.length == 0 || [self.placeholder isEqualToString:@""]) {
        _placeholderLabel.hidden=YES;
    }
    
    if (self.text.length > 0) {
        _placeholderLabel.hidden=YES;
    }
    else{
        _placeholderLabel.hidden=NO;
    }
    
    NSString *lang = [[self.nextResponder textInputMode] primaryLanguage]; // 键盘输入模式
    
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [self markedTextRange];
        //获取高亮部分
        UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (self.text.length > self.maxTextLength) {
                self.text = [self.text substringToIndex:self.maxTextLength];
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        if (self.text.length > self.maxTextLength) {
             self.text = [ self.text substringToIndex:self.maxTextLength];
        }
    }
    
    
    if (_eventBlock && self.text.length > self.maxTextLength) {
        
        void (^limint)(XLsn0wTextView *text) =_eventBlock;
        
        limint(self);
    }
    
}

#pragma mark - private method

+ (float)boundingRectWithSize:(CGSize)size withLabel:(NSString *)label withFont:(UIFont *)font {
    NSDictionary *attribute = @{NSFontAttributeName:font};
    
    // CGSize retSize;
    CGSize retSize = [label boundingRectWithSize:size
                                         options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                      attributes:attribute
                                         context:nil].size;
    
    return retSize.height;
}

#pragma mark - getters and Setters

- (void)setText:(NSString *)tex {
    if (tex.length>0) {
        _placeholderLabel.hidden=YES;
    }
    [super setText:tex];
}

- (void)setPlaceholder:(NSString *)placeholder {
    if (placeholder.length == 0 || [placeholder isEqualToString:@""]) {
        _placeholderLabel.hidden=YES;
    } else {
        _placeholderLabel.text=placeholder;
        _placeholder=placeholder;
        
//        float  height=  [BRPlaceholderTextView boundingRectWithSize:CGSizeMake(_placeholdeWidth, MAXFLOAT) withLabel:_placeholder withFont:_PlaceholderLabel.font];
//        if (height>CGRectGetHeight(_PlaceholderLabel.frame) && height< CGRectGetHeight(self.frame)) {
//            
//            CGRect frame=_PlaceholderLabel.frame;
//            frame.size.height=height;
//            _PlaceholderLabel.frame=frame;
//            
//        }
    }
}

-(void)setPlaceholder_font:(UIFont *)placeholder_font {
    _placeholder_font=placeholder_font;
    _placeholderLabel.font=placeholder_font;
}

-(void)setPlaceholder_color:(UIColor *)placeholder_color {
    _placeholder_color=placeholder_color;
    _placeholderLabel.textColor=placeholder_color;
}

@end
