
#import "UIFont+Extension.h"
#import "XLsn0wMacro.h"

@implementation UIFont (Extension)
+ (UIFont *)fontWithDevice:(CGFloat)fontSize {
    if (kScreenWidth > 375) {
        fontSize = fontSize + 3;
    }else if (kScreenWidth == 375){
        fontSize = fontSize + 1.5;
    }else if (kScreenWidth == 320){
        fontSize = fontSize;
    }
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    return font;
}

/**
 *  专门为客户性别，年龄电话写的
 */
+ (UIFont *)fontWithCustomer:(CGFloat)fontSize {
    if (kScreenWidth > 375) {
        fontSize = fontSize + 2;
    }else if (kScreenWidth == 375){
        fontSize = fontSize + 1.5;
    }else if (kScreenWidth == 320){
        fontSize = fontSize;
    }
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    return font;
}

+ (UIFont *)navItemFontWithDevice:(CGFloat)fontSize {
    if (kScreenWidth > 375) {
        fontSize = fontSize + 2;
    }else if (kScreenWidth == 375){
        fontSize = fontSize + 1;
    }else if (kScreenWidth == 320){
        fontSize = fontSize;
    }
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    return font;
}

+ (UIFont *)fontWithTwoLine:(CGFloat)fontSize {
    if (kScreenWidth > 375) {
        fontSize = fontSize + 2;
    }else if (kScreenWidth == 375){
        fontSize = fontSize + 1;
    }else if (kScreenWidth == 320){
        fontSize = fontSize;
    }
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    return font;
}

+ (UIFont *)insuranceCellFont:(CGFloat)fontSize {
    if (kScreenWidth > 375) {
        fontSize = fontSize + 3.5;
    }else if (kScreenWidth == 375){
        fontSize = fontSize + 2;
    }else if (kScreenWidth == 320){
        fontSize = fontSize;
    }
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    return font;
}

@end
