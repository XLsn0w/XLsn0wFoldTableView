
#import "XLsn0wTextField.h"

@implementation XLsn0wTextField

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.maxNumberOfCharacters = 0;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:self];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.maxNumberOfCharacters = [aDecoder decodeIntForKey:@"MaxNumberOfCharacters"];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:self];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [super encodeWithCoder:aCoder];
    
    [aCoder encodeInt64:(long)self.maxNumberOfCharacters forKey:@"MaxNumberOfCharacters"];
}

- (void)textFieldDidChange:(NSNotification *)notification {
    if (self.maxNumberOfCharacters != 0 && self.text.length >= self.maxNumberOfCharacters) {
        self.text = [self.text substringToIndex:self.maxNumberOfCharacters];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//控制placeHolder的位置，左右缩20
- (CGRect)placeholderRectForBounds:(CGRect)bounds {
    CGRect inset = CGRectMake(bounds.origin.x + 40, bounds.origin.y, bounds.size.width -10, bounds.size.height);
    return inset;
}

//控制显示文本的位置
-(CGRect)textRectForBounds:(CGRect)bounds {
    CGRect inset = CGRectMake(bounds.origin.x + 40, bounds.origin.y, bounds.size.width -10, bounds.size.height);
    return inset;
    
}

//控制编辑文本的位置
-(CGRect)editingRectForBounds:(CGRect)bounds {
    CGRect inset = CGRectMake(bounds.origin.x + 40, bounds.origin.y, bounds.size.width -10, bounds.size.height);
    return inset;
}

//leftView 输入文字前的提示图片
- (CGRect)leftViewRectForBounds:(CGRect)bounds {
    CGRect textRect = [super leftViewRectForBounds:bounds];
    textRect.origin.x += 5;
    return textRect;
}

//rightView 多用于密码隐藏显示那个眼睛图片
- (CGRect)rightViewRectForBounds:(CGRect)bounds; {
    CGRect textRect = [super rightViewRectForBounds:bounds];
    textRect.origin.x -= 10;
    return textRect;
}

@end
