/**************************************************************************************************/

#import "XLsn0w.h"

#import "XLsn0wLog.h"
#import "MBProgressHUD.h"

#import <CommonCrypto/CommonCrypto.h>

#import "NSString+XL.h"
#define KFacialSizeWidth    32

#define KFacialSizeHeight   32

#define KCharacterWidth     8

#define VIEW_LINE_HEIGHT    32

#define VIEW_LEFT           0

#define VIEW_RIGHT          5

#define VIEW_TOP            8

#define VIEW_WIDTH_MAX      238

#define FACE_NAME_HEAD @"["
#define PATTERN_STR @"\\[[^\\[\\]]*\\]"

// 表情转义字符的长度（ /s占2个长度，xxx占3个长度，共5个长度 ）
#define FACE_NAME_LEN   4

#import "MBProgressHUD.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>
#include <arpa/inet.h>
#include <sys/sockio.h>
#include <net/if.h>
#include <errno.h>
#include <net/if_dl.h>
#include <ctype.h>
#include <sys/ioctl.h>
#include <fcntl.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <dirent.h>
#import <CommonCrypto/CommonDigest.h>
#include <unistd.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/sockio.h>
#import <objc/runtime.h>
#import <sys/utsname.h>
/*********************************************************************************************
 *   __      __   _         _________     _ _     _    _________   __         _         __   *
 *   \ \    / /  | |        | _______|   | | \   | |  |  ______ |  \ \       / \       / /   *
 *    \ \  / /   | |        | |          | |\ \  | |  | |     | |   \ \     / \ \     / /    *
 *     \ \/ /    | |        | |______    | | \ \ | |  | |     | |    \ \   / / \ \   / /     *
 *     /\/\/\    | |        |_______ |   | |  \ \| |  | |     | |     \ \ / /   \ \ / /      *
 *    / /  \ \   | |______   ______| |   | |   \ \ |  | |_____| |      \ \ /     \ \ /       *
 *   /_/    \_\  |________| |________|   |_|    \__|  |_________|       \_/       \_/        *
 *                                                                                           *
 *********************************************************************************************/
@interface XLsn0w () {
    NSMutableArray *stack;
}

@end
/*********************************************************************************************
 *   __      __   _         _________     _ _     _    _________   __         _         __   *
 *   \ \    / /  | |        | _______|   | | \   | |  |  ______ |  \ \       / \       / /   *
 *    \ \  / /   | |        | |          | |\ \  | |  | |     | |   \ \     / \ \     / /    *
 *     \ \/ /    | |        | |______    | | \ \ | |  | |     | |    \ \   / / \ \   / /     *
 *     /\/\/\    | |        |_______ |   | |  \ \| |  | |     | |     \ \ / /   \ \ / /      *
 *    / /  \ \   | |______   ______| |   | |   \ \ |  | |_____| |      \ \ /     \ \ /       *
 *   /_/    \_\  |________| |________|   |_|    \__|  |_________|       \_/       \_/        *
 *                                                                                           *
 *********************************************************************************************/
@implementation XLsn0w

///解决 warning:
///Autosynthesized property 'year' will use synthesized instance variable '_year', not existing instance variable 'year'.
@synthesize year  = _year;
@synthesize month = _month;
@synthesize day   = _day;

///单例 singleton
+ (instancetype)shared {
    static XLsn0w *singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[self alloc] init];
    });
    return singleton;
}

+ (NSMutableAttributedString *)makeRangeWithString:(NSString *)string
                                         textColor:(UIColor *)textColor
                                               loc:(NSUInteger)loc
                                               len:(NSUInteger)len {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    [attributedString addAttribute:NSForegroundColorAttributeName
                             value:textColor
                             range:NSMakeRange(loc, len)];
//  self.label.attributedText= attributedString;
    return attributedString;
}

+ (NSMutableAttributedString *)makeRangeWithString:(NSString *)string
                                          textFont:(UIFont *)textFont
                                               loc:(NSUInteger)loc
                                               len:(NSUInteger)len {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    [attributedString addAttribute:NSForegroundColorAttributeName
                             value:textFont///[UIFont systemFontOfSize:21.0]
                             range:NSMakeRange(loc, len)];
    //  self.label.attributedText= attributedString;
    return attributedString;
}

+ (NSMutableAttributedString *)makeRangeWithString:(NSString *)string
                                   textStyleNumber:(NSNumber *)textStyleNumber
                                               loc:(NSUInteger)loc
                                               len:(NSUInteger)len {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    [attributedString addAttribute:NSForegroundColorAttributeName
                             value:textStyleNumber///value:[NSNumber numberWithInteger:NSUnderlineStyleSingle]
                             range:NSMakeRange(loc, len)];
    //  self.label.attributedText= attributedString;
    return attributedString;
}

///需要导入头文件：#import <sys/utsname.h>
+ (NSString*)deviceModel {

    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString *platform = [NSString stringWithCString: systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if([platform isEqualToString:@"iPhone1,1"])  return@"iPhone 2G";
    
    if([platform isEqualToString:@"iPhone1,2"])  return@"iPhone 3G";
    
    if([platform isEqualToString:@"iPhone2,1"])  return@"iPhone 3GS";
    
    if([platform isEqualToString:@"iPhone3,1"])  return@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone3,2"])  return@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone3,3"])  return@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone4,1"])  return@"iPhone 4S";
    
    if([platform isEqualToString:@"iPhone5,1"])  return@"iPhone 5";
    
    if([platform isEqualToString:@"iPhone5,2"])  return@"iPhone 5";
    
    if([platform isEqualToString:@"iPhone5,3"])  return@"iPhone 5c";
    
    if([platform isEqualToString:@"iPhone5,4"])  return@"iPhone 5c";
    
    if([platform isEqualToString:@"iPhone6,1"])  return@"iPhone 5s";
    
    if([platform isEqualToString:@"iPhone6,2"])  return@"iPhone 5s";
    
    if([platform isEqualToString:@"iPhone7,1"])  return@"iPhone 6 Plus";
    
    if([platform isEqualToString:@"iPhone7,2"])  return@"iPhone 6";
    
    if([platform isEqualToString:@"iPhone8,1"])  return@"iPhone 6s";
    
    if([platform isEqualToString:@"iPhone8,2"])  return@"iPhone 6s Plus";
    
    if([platform isEqualToString:@"iPhone8,4"])  return@"iPhone SE";
    
    if([platform isEqualToString:@"iPhone9,1"])  return@"iPhone 7";
    
    if([platform isEqualToString:@"iPhone9,3"])  return@"iPhone 7";
    
    if([platform isEqualToString:@"iPhone9,2"])  return@"iPhone 7 Plus";
    
    if([platform isEqualToString:@"iPhone9,4"])  return@"iPhone 7 Plus";
    
    if([platform isEqualToString:@"iPhone10,1"]) return@"iPhone 8";
    
    if([platform isEqualToString:@"iPhone10,4"]) return@"iPhone 8";
    
    if([platform isEqualToString:@"iPhone10,2"]) return@"iPhone 8 Plus";
    
    if([platform isEqualToString:@"iPhone10,5"]) return@"iPhone 8 Plus";
    
    if([platform isEqualToString:@"iPhone10,3"]) return@"iPhone X";
    
    if([platform isEqualToString:@"iPhone10,6"]) return@"iPhone X";
    
    if([platform isEqualToString:@"iPod1,1"])  return@"iPod Touch 1G";
    
    if([platform isEqualToString:@"iPod2,1"])  return@"iPod Touch 2G";
    
    if([platform isEqualToString:@"iPod3,1"])  return@"iPod Touch 3G";
    
    if([platform isEqualToString:@"iPod4,1"])  return@"iPod Touch 4G";
    
    if([platform isEqualToString:@"iPod5,1"])  return@"iPod Touch 5G";
    
    if([platform isEqualToString:@"iPad1,1"])  return@"iPad 1G";
    
    if([platform isEqualToString:@"iPad2,1"])  return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,2"])  return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,3"])  return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,4"])  return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,5"])  return@"iPad Mini 1G";
    
    if([platform isEqualToString:@"iPad2,6"])  return@"iPad Mini 1G";
    
    if([platform isEqualToString:@"iPad2,7"])  return@"iPad Mini 1G";
    
    if([platform isEqualToString:@"iPad3,1"])  return@"iPad 3";
    
    if([platform isEqualToString:@"iPad3,2"])  return@"iPad 3";
    
    if([platform isEqualToString:@"iPad3,3"])  return@"iPad 3";
    
    if([platform isEqualToString:@"iPad3,4"])  return@"iPad 4";
    
    if([platform isEqualToString:@"iPad3,5"])  return@"iPad 4";
    
    if([platform isEqualToString:@"iPad3,6"])  return@"iPad 4";
    
    if([platform isEqualToString:@"iPad4,1"])  return@"iPad Air";
    
    if([platform isEqualToString:@"iPad4,2"])  return@"iPad Air";
    
    if([platform isEqualToString:@"iPad4,3"])  return@"iPad Air";
    
    if([platform isEqualToString:@"iPad4,4"])  return@"iPad Mini 2G";
    
    if([platform isEqualToString:@"iPad4,5"])  return@"iPad Mini 2G";
    
    if([platform isEqualToString:@"iPad4,6"])  return@"iPad Mini 2G";
    
    if([platform isEqualToString:@"iPad4,7"])  return@"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad4,8"])  return@"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad4,9"])  return@"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad5,1"])  return@"iPad Mini 4";
    
    if([platform isEqualToString:@"iPad5,2"])  return@"iPad Mini 4";
    
    if([platform isEqualToString:@"iPad5,3"])  return@"iPad Air 2";
    
    if([platform isEqualToString:@"iPad5,4"])  return@"iPad Air 2";
    
    if([platform isEqualToString:@"iPad6,3"])  return@"iPad Pro 9.7";
    
    if([platform isEqualToString:@"iPad6,4"])  return@"iPad Pro 9.7";
    
    if([platform isEqualToString:@"iPad6,7"])  return@"iPad Pro 12.9";
    
    if([platform isEqualToString:@"iPad6,8"])  return@"iPad Pro 12.9";
    
    if([platform isEqualToString:@"i386"])  return@"iPhone Simulator";
    
    if([platform isEqualToString:@"x86_64"])  return@"iPhone Simulator";
    
    return platform;
    
}

#pragma mark - JSON格式转换成iOS字典格式
+ (NSDictionary *_Nullable)convertToDictionaryWithJSON:(id _Nullable)JSON {
    if (!JSON || JSON == (id)kCFNull) return nil;
    NSDictionary *JSON2Dictionary = nil;
    NSData *jsonData = nil;
    if ([JSON isKindOfClass:[NSDictionary class]]) {
        JSON2Dictionary = JSON;
    } else if ([JSON isKindOfClass:[NSString class]]) {
        jsonData = [(NSString *)JSON dataUsingEncoding : NSUTF8StringEncoding];
    } else if ([JSON isKindOfClass:[NSData class]]) {
        jsonData = JSON;
    }
    if (jsonData) {
        JSON2Dictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:NULL];
        if (![JSON2Dictionary isKindOfClass:[NSDictionary class]]) JSON2Dictionary = nil;
    }
    return JSON2Dictionary;
}

//字典转字符串
+ (NSString*)convertToStringWithDictionary:(NSDictionary *)dictionary {
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

+ (NSDictionary *_Nullable)convertToDictionaryWithString:(NSString *_Nullable)string {
    if (string == nil) {
        return nil;
    }
    NSData *jsonData = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSError *parseError = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&parseError];
    if(parseError) {
        NSLog(@"parseError: %@",parseError);
        return nil;
    }
    return dic;
}

+ (NSBundle *)getCustomBundleWithFileName:(NSString *)fileName {
    NSBundle *customBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:fileName ofType :@"bundle"]];
    return customBundle;
}

+ (UIImage *)getCustomBundleWithFileName:(NSString *)fileName bundleImageName:(NSString *)bundleImageName {
    NSBundle *customBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:fileName ofType :@"bundle"]];
    UIImage *bundleImage  = [UIImage imageWithContentsOfFile: [customBundle pathForResource:bundleImageName ofType: @"png"]];///⭐️推荐 相对路径
    //UIImage *image = [UIImage imageWithContentsOfFile: [[customBundle resourcePath] stringByAppendingPathComponent:bundleImageName]];//绝对路径 不推荐
    //UIImage *image = [UIImage imageNamed:@"XLsn0wKit_objc.bundle/placeholder.png"];//绝对路径 不推荐
    return bundleImage;
}

+ (NSData *)xl_receiveStringDataWithString:(NSString *)string encoding:(NSStringEncoding)encoding {
    NSData *stringData = [string dataUsingEncoding:encoding];
    return stringData;
}

+ (NSDictionary *)xl_receiveJSONDictionaryWithData:(NSData *)data {
    NSDictionary *JSONDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    return JSONDictionary;
}

+ (NSString *)xl_receiveJSONStringWithDictionary:(NSDictionary *)dictionary {
    NSString *JSONString = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
    //格式化变成纯净的{JSON}
    JSONString = [JSONString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];//去除掉首尾的空白字符和换行字符
    JSONString = [JSONString stringByReplacingOccurrencesOfString:@"\n" withString:@""];//去除多余的换行
    JSONString = [JSONString stringByReplacingOccurrencesOfString:@" " withString:@""];//去除多余的空格
    JSONString = [JSONString stringByReplacingOccurrencesOfString:@"\\" withString:@""];//去除多余的\
    
    return JSONString;
}

+ (PasswordStrengthLevel)checkPasswordStrength:(NSString * _Nonnull)password {
    NSInteger length = [password length];
    int lowercase = [self countLowercaseLetters:password];
    int uppercase = [self countUppercaseLetters:password];
    int numbers = [self countNumbers:password];
    int symbols = [self countSymbols:password];
    
    int score = 0;
    
    if (length < 5)
        score += 5;
    else
        if (length > 4 && length < 8)
            score += 10;
        else
            if (length > 7)
                score += 20;
    
    if (numbers == 1)
        score += 10;
    else
        if (numbers == 2)
            score += 15;
        else
            if (numbers > 2)
                score += 20;
    
    if (symbols == 1)
        score += 10;
    else
        if (symbols == 2)
            score += 15;
        else
            if (symbols > 2)
                score += 20;
    
    if (lowercase == 1)
        score += 10;
    else
        if (lowercase == 2)
            score += 15;
        else
            if (lowercase > 2)
                score += 20;
    
    if (uppercase == 1)
        score += 10;
    else
        if (uppercase == 2)
            score += 15;
        else
            if (uppercase > 2)
                score += 20;
    
    if (score == 100)
        return PasswordStrengthLevelVerySecure;
    else
        if (score >= 90)
            return PasswordStrengthLevelSecure;
        else
            if (score >= 80)
                return PasswordStrengthLevelVeryStrong;
            else
                if (score >= 70)
                    return PasswordStrengthLevelStrong;
                else
                    if (score >= 60)
                        return PasswordStrengthLevelAverage;
                    else
                        if (score >= 50)
                            return PasswordStrengthLevelWeak;
                        else
                            return PasswordStrengthLevelVeryWeak;
}

+ (int)countLowercaseLetters:(NSString * _Nonnull)password {
    int count = 0;
    
    for (int i = 0; i < [password length]; i++) {
        BOOL isLowercase = [[NSCharacterSet lowercaseLetterCharacterSet] characterIsMember:[password characterAtIndex:i]];
        if (isLowercase == YES) {
            count++;
        }
    }
    
    return count;
}

+ (int)countUppercaseLetters:(NSString * _Nonnull)password {
    int count = 0;
    
    for (int i = 0; i < [password length]; i++) {
        BOOL isUppercase = [[NSCharacterSet uppercaseLetterCharacterSet] characterIsMember:[password characterAtIndex:i]];
        if (isUppercase == YES) {
            count++;
        }
    }
    
    return count;
}

+ (int)countNumbers:(NSString * _Nonnull)password {
    int count = 0;
    
    for (int i = 0; i < [password length]; i++) {
        BOOL isNumber = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] characterIsMember:[password characterAtIndex:i]];
        if (isNumber == YES) {
            count++;
        }
    }
    
    return count;
}

+ (int)countSymbols:(NSString * _Nonnull)password {
    int count = 0;
    
    for (int i = 0; i < [password length]; i++) {
        BOOL isSymbol = [[NSCharacterSet characterSetWithCharactersInString:@"`~!?@#$€£¥§%^&*()_+-={}[]:\";.,<>'•\\|/"] characterIsMember:[password characterAtIndex:i]];
        if (isSymbol == YES) {
            count++;
        }
    }
    
    return count;
}

+ (void)playSystemSound:(AudioID)audioID {
    AudioServicesPlaySystemSound(audioID);
}

+ (void)playSystemSoundVibrate {
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

+ (SystemSoundID)playCustomSound:(NSURL * _Nonnull)soundURL {
    SystemSoundID soundID;
    
    OSStatus error = AudioServicesCreateSystemSoundID((CFURLRef)CFBridgingRetain(soundURL), &soundID);
    if (error != kAudioServicesNoError) {
        XLsn0wLog(@"Could not load %@", soundURL);
    }
    return soundID;
}

+ (BOOL)disposeSound:(SystemSoundID)soundID {
    OSStatus error = AudioServicesDisposeSystemSoundID(soundID);
    if (error != kAudioServicesNoError) {
        XLsn0wLog(@"Error while disposing sound %i", (unsigned int)soundID);
        return NO;
    }
    
    return YES;
}



+ (NSString *)xl_getNSStringWithNumber:(NSNumber *)number {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    NSString *numberString = [numberFormatter stringFromNumber:number];
    return numberString;
}

+ (NSNumber *)xl_getNSNumberWithString:(NSString *)string {
    NSInteger integer = [string integerValue];
    NSNumber *number = @(integer);
    return number;
}

//压缩图片
+ (UIImage *)xl_getCompressedImageWithNewSize:(CGSize)newSize currentImage:(UIImage *)currentImage {
    UIImage *sourceImage = currentImage;
    UIImage *compressedImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = newSize.width;
    CGFloat targetHeight = newSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, newSize) == NO) {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth= width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else if (widthFactor < heightFactor)
        {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(newSize); // this will crop
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width= scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    compressedImage = UIGraphicsGetImageFromCurrentImageContext();
    if(compressedImage == nil)
        NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    
    return compressedImage;
}

+ (NSData *)xl_getImageDataWithCurrentImage:(UIImage *)currentImage {
    NSData *imageData = UIImagePNGRepresentation(currentImage);
    return imageData;
}

+ (NSString *)xl_getBase64EncodedStringWithCurrentImage:(UIImage *)currentImage {
    NSData *imageData = UIImagePNGRepresentation(currentImage);
    NSString *base64EncodedString = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return base64EncodedString;
}

+ (UIImage *)xl_getImageWithBase64EncodedString:(NSString *)base64EncodedString {
    NSData *imageData = [[NSData alloc] initWithBase64EncodedString:base64EncodedString options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage *image = [UIImage imageWithData:imageData];
    return image;
}

+ (void)xl_showTipText:(NSString *)tipText {
    MBProgressHUD *messageHud = [MBProgressHUD showHUDAddedTo:[[[UIApplication sharedApplication] windows] lastObject] animated:YES];
    messageHud.mode = MBProgressHUDModeText;
    messageHud.label.text = [tipText isKindOfClass:[NSString class]] ? tipText : @"";
    [messageHud setOffset:(CGPointMake(0, -50))];
    messageHud.userInteractionEnabled = NO;
    [messageHud hideAnimated:YES afterDelay:1.5f];
}

+ (void)xl_saveImageToAlbumWithCurrentImage:(UIImage *)currentImage {
    UIImageWriteToSavedPhotosAlbum(currentImage, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
}

- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (!error) {
        [XLsn0w xl_showTipText:@"成功保存到相册"];
    } else {
        [XLsn0w xl_showTipText:@"保存图片失败"];
    }
}

+ (UIImage *)xl_getURLImageWithURLString:(NSString *)URLString {
    NSURL *URL = [NSURL URLWithString:URLString];
    NSData *URLData = [NSData dataWithContentsOfURL:URL];
    UIImage *URLImage = [UIImage imageWithData:URLData];
    return URLImage;
}

+ (void)xl_getCurrentNavigationController:(UINavigationController *)currentNavigationController popToViewControllerAtTargetIndex:(NSUInteger)targetIndex {
    [currentNavigationController popToViewController:[currentNavigationController.viewControllers objectAtIndex:targetIndex] animated:YES];
}

+ (NSUInteger)xl_getCurrentIndexWithCurrentNavigationController:(UINavigationController *)currentNavigationController currentViewController:(UIViewController *)currentViewController {
    NSUInteger currentViewControllerIndex = [currentNavigationController.viewControllers indexOfObject:currentViewController];
    return currentViewControllerIndex;
}

+ (void)xl_getPhoneNumber:(NSString *)phoneNumber currentViewController:(UIViewController *)currentViewController {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示"
                                                                             message:[NSString stringWithFormat:@"确定拨打: %@ ?", phoneNumber]
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAlertAction = [UIAlertAction actionWithTitle:@"确定"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * _Nonnull action) {
                                                              
                                                              [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", phoneNumber]]];
                                                          }];
    
    UIAlertAction *cancleAlertAction = [UIAlertAction actionWithTitle:@"取消"
                                                                style:UIAlertActionStyleDefault
                                                              handler:nil];
    [alertController addAction:okAlertAction];
    [alertController addAction:cancleAlertAction];
    [currentViewController presentViewController:alertController animated:YES completion:nil];
}

+ (BOOL)xl_isPhoneNumber:(NSString *)phoneNumber {
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$"];
    return [predicate evaluateWithObject:phoneNumber];
}

+ (void)xl_showTimeoutWithCurrentSelf:(UIViewController *)currentSelf statusCode:(NSInteger)statusCode {
    if (statusCode == 408) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"超时提醒" message:@"网络请求超时 !" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAlertAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:okAlertAction];
        [currentSelf presentViewController:alertController animated:YES completion:nil];
    }
}

static NSString *BFHasBeenOpened = @"BFHasBeenOpened";
static NSString *BFHasBeenOpenedForCurrentVersion = @"";

+ (void)onFirstStart:(void (^ _Nullable)(BOOL isFirstStart))block {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL hasBeenOpened = [defaults boolForKey:BFHasBeenOpened];
    if (hasBeenOpened != true) {
        [defaults setBool:YES forKey:BFHasBeenOpened];
        [defaults synchronize];
    }
    
    block(!hasBeenOpened);
}

+ (void)onFirstStartForCurrentVersion:(void (^ _Nullable)(BOOL isFirstStartForCurrentVersion))block {
    BFHasBeenOpenedForCurrentVersion = [NSString stringWithFormat:@"%@%@", BFHasBeenOpened, APP_VERSION];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL hasBeenOpenedForCurrentVersion = [defaults boolForKey:BFHasBeenOpenedForCurrentVersion];
    if (hasBeenOpenedForCurrentVersion != true) {
        [defaults setBool:YES forKey:BFHasBeenOpenedForCurrentVersion];
        [defaults synchronize];
    }
    
    block(!hasBeenOpenedForCurrentVersion);
}

+ (void)onFirstStartForVersion:(NSString * _Nonnull)version block:(void (^ _Nullable)(BOOL isFirstStartForCurrentVersion))block {
    NSString *BFHasBeenOpenedForVersion = [NSString stringWithFormat:@"%@%@", BFHasBeenOpened, version];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL hasBeenOpenedForVersion = [defaults boolForKey:BFHasBeenOpenedForCurrentVersion];
    if (hasBeenOpenedForVersion != true) {
        [defaults setBool:YES forKey:BFHasBeenOpenedForVersion];
        [defaults synchronize];
    }
    
    block(!hasBeenOpenedForVersion);
}

+ (BOOL)isFirstStart {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL hasBeenOpened = [defaults boolForKey:BFHasBeenOpened];
    if (hasBeenOpened != true) {
        return YES;
    } else {
        return NO;
    }
}

+ (BOOL)isFirstStartForCurrentVersion {
    BFHasBeenOpenedForCurrentVersion = [NSString stringWithFormat:@"%@%@", BFHasBeenOpened, APP_VERSION];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL hasBeenOpenedForCurrentVersion = [defaults boolForKey:BFHasBeenOpenedForCurrentVersion];
    if (hasBeenOpenedForCurrentVersion != true) {
        return YES;
    } else {
        return NO;
    }
}

+ (BOOL)isFirstStartForVersion:(NSString * _Nonnull)version {
    NSString *BFHasBeenOpenedForVersion = [NSString stringWithFormat:@"%@%@", BFHasBeenOpened, version];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL hasBeenOpenedForVersion = [defaults boolForKey:BFHasBeenOpenedForVersion];
    if (hasBeenOpenedForVersion != true) {
        return YES;
    } else {
        return NO;
    }
}

+ (NSString * _Nullable)MD5:(NSString * _Nonnull)string {
    if (string == nil || [string length] == 0) {
        return nil;
    }
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH], i;
    CC_MD5([string UTF8String], (int)[string lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
    NSMutableString *ms = [NSMutableString string];
    for (i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [ms appendFormat: @"%02x", (int)(digest[i])];
    }
    return [ms copy];
}

+ (NSString * _Nullable)SHA1:(NSString * _Nonnull)string {
    if (string == nil || [string length] == 0) {
        return nil;
    }
    
    unsigned char digest[CC_SHA1_DIGEST_LENGTH], i;
    CC_SHA1([string UTF8String], (int)[string lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
    NSMutableString *ms = [NSMutableString string];
    for (i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [ms appendFormat: @"%02x", (int)(digest[i])];
    }
    return [ms copy];
}

+ (NSString * _Nullable)SHA256:(NSString * _Nonnull)string {
    if (string == nil || [string length] == 0) {
        return nil;
    }
    
    unsigned char digest[CC_SHA256_DIGEST_LENGTH], i;
    CC_SHA256([string UTF8String], (int)[string lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
    NSMutableString *ms = [NSMutableString string];
    for (i = 0; i < CC_SHA256_DIGEST_LENGTH; i++) {
        [ms appendFormat: @"%02x", (int)(digest[i])];
    }
    return [ms copy];
}

+ (NSString * _Nullable)SHA512:(NSString * _Nonnull)string {
    if (string == nil || [string length] == 0) {
        return nil;
    }
    
    unsigned char digest[CC_SHA512_DIGEST_LENGTH], i;
    CC_SHA512([string UTF8String], (int)[string lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
    NSMutableString *ms = [NSMutableString string];
    for (i = 0; i < CC_SHA512_DIGEST_LENGTH; i++)
    {
        [ms appendFormat: @"%02x", (int)(digest[i])];
    }
    return [ms copy];
}

+ (NSData * _Nullable)AES128EncryptData:(NSData * _Nonnull)data withKey:(NSString * _Nonnull)key {
    char keyPtr[kCCKeySizeAES128+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding, keyPtr, kCCKeySizeAES128, NULL, [data bytes], dataLength, buffer, bufferSize, &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    
    free(buffer);
    return nil;
}

+ (NSData *)AES128DecryptData:(NSData * _Nonnull)data withKey:(NSString * _Nonnull)key {
    char keyPtr[kCCKeySizeAES128+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding, keyPtr, kCCKeySizeAES128, NULL, [data bytes], dataLength, buffer, bufferSize, &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    
    free(buffer);
    return nil;
}

+ (NSData * _Nullable)AES256EncryptData:(NSData * _Nonnull)data withKey:(NSString * _Nonnull)key {
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding, keyPtr, kCCKeySizeAES256, NULL, [data bytes], dataLength, buffer, bufferSize, &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    
    free(buffer);
    return nil;
}

+ (NSData *)AES256DecryptData:(NSData * _Nonnull)data withKey:(NSString * _Nonnull)key {
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding, keyPtr, kCCKeySizeAES256, NULL, [data bytes], dataLength, buffer, bufferSize, &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    
    free(buffer);
    return nil;
}

+ (NSString *)xl_nullDefultString: (NSString *)fromString null:(NSString *)nullStr {
    if ([fromString isEqualToString:@""] || [fromString isEqualToString:@"(null)"] || [fromString isEqualToString:@"<null>"] || [fromString isEqualToString:@"null"] || fromString==nil) {
        return nullStr;
    }else{
        return fromString;
    }
}

+ (NSString *)xl_htmlShuangyinhao:(NSString *)values {
    if (values == nil) {
        return @"";
    }
    /*
     字符串的替换
     注：将字符串中的参数进行替换
     参数1：目标替换值
     参数2：替换成为的值
     参数3：类型为默认：NSLiteralSearch
     参数4：替换的范围
     */
    NSMutableString *temp = [NSMutableString stringWithString:values];
    [temp replaceOccurrencesOfString:@"\"" withString:@"'" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"\r" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    return temp;
}

+ (UIColor *)xl_colorWithHexString:(NSString *)stringToConvert {
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor colorWithWhite:1.0 alpha:0.5];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor colorWithWhite:1.0 alpha:0.5];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}




#pragma 正则匹配邮箱号
+ (BOOL)checkMailAccount:(NSString *)mail {
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:mail];
}

#pragma 正则匹配手机号
+ (BOOL)checkPhoneNumber:(NSString *)phoneNumber {
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,183,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[356])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:phoneNumber] == YES)
        || ([regextestcm evaluateWithObject:phoneNumber] == YES)
        || ([regextestct evaluateWithObject:phoneNumber] == YES)
        || ([regextestcu evaluateWithObject:phoneNumber] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
    
}


#pragma 正则匹配用户密码6-18位数字和字母组合
+ (BOOL)checkPassword:(NSString *)password {
    NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:password];
    return isMatch;
    
}

#pragma 正则匹配用户姓名,20位的中文或英文
+ (BOOL)checkUserName:(NSString *)userName {
    NSString *pattern = @"^[a-zA-Z\u4E00-\u9FA5]{1,20}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:userName];
    return isMatch;
}


#pragma 正则匹配用户身份证号15或18位
+ (BOOL)checkUserIDCard:(NSString *)IDCard {
    BOOL flag;
    if (IDCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    BOOL isMatch = [pred evaluateWithObject:IDCard];
    return isMatch;
}

#pragma 正则匹配URL
+ (BOOL)checkURL:(NSString *)url {
    NSString *pattern = @"^[0-9A-Za-z]{1,50}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:url];
    return isMatch;
    
}

#pragma 正则匹员工号,12位的数字
+ (BOOL)checkEmployeeNumber:(NSString *)number {
    NSString *pattern = @"^[0-9]{12}";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:number];
    return isMatch;
    
}

#pragma 正则匹配昵称
+ (BOOL)checkNickname:(NSString *)nickname {
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    BOOL isMatch = [pred evaluateWithObject:nickname];
    return isMatch;
}

#pragma 正则匹配以C开头的18位字符
+ (BOOL)checkCtooNumberTo18:(NSString *)nickNumber {
    NSString *nickNum=@"^C{1}[0-9]{18}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nickNum];
    BOOL isMatch = [pred evaluateWithObject:nickNumber];
    return isMatch;
}

#pragma 正则匹配以C开头字符
+ (BOOL)checkCtooNumber:(NSString *) nickNumber {
    NSString *nickNum=@"^C{1}[0-9]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nickNum];
    BOOL isMatch = [pred evaluateWithObject:nickNumber];
    return isMatch;
}

#pragma 正则匹配银行卡号是否正确
+ (BOOL)checkBankNumber:(NSString *)bankNumber {
    NSString *bankNum=@"^([0-9]{16}|[0-9]{19})$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",bankNum];
    BOOL isMatch = [pred evaluateWithObject:bankNumber];
    return isMatch;
}
#pragma 正则匹配17位车架号
+ (BOOL)checkCheJiaNumber:(NSString *) CheJiaNumber {
    NSString *bankNum=@"^(\\d{17})$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",bankNum];
    BOOL isMatch = [pred evaluateWithObject:CheJiaNumber];
    return isMatch;
}

#pragma 正则只能输入数字和字母
+ (BOOL)checkTeshuZifuNumber:(NSString *)cheJiaNumber {
    NSString *bankNum=@"^[A-Za-z0-9]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",bankNum];
    BOOL isMatch = [pred evaluateWithObject:cheJiaNumber];
    return isMatch;
}
#pragma 车牌号验证
+ (BOOL)checkCarNumber:(NSString *)carNumber {
    NSString *bankNum = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",bankNum];
    BOOL isMatch = [pred evaluateWithObject:carNumber];
    return isMatch;
}

+(NSDictionary*)dictionaryFromBundleWithName:(NSString*)fileName withType:(NSString*)typeName {
    NSDictionary * dict = nil;
    NSString *infoPlist = [[NSBundle mainBundle] pathForResource:fileName ofType:typeName];
    
    if ([[NSFileManager defaultManager] isReadableFileAtPath:infoPlist]) {
        NSDictionary * dict = [[NSDictionary alloc] initWithContentsOfFile:infoPlist];
        return dict;
    }
    return dict;
}

//MD5转换
+ (NSString *)md5HexDigest:(NSString *)inputString {
    const char * str = [inputString UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), result);
    
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];//
    
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}

+(void)removeLoadingViewAndLabelInView:(UIView*)viewToLoadData
{
    //viewToLoadData.hidden = NO;
    UIActivityIndicatorView * breakingLoadingView = (UIActivityIndicatorView*)[viewToLoadData  viewWithTag:10087];
    [breakingLoadingView stopAnimating];
    
    [[viewToLoadData  viewWithTag:10086] removeFromSuperview];
}



+(void)addLoadingViewAndLabelInView:(UIView*)viewToLoadData usingOrignalYPosition:(CGFloat)yPosition
{
    
    UIView * loadingView = [[UIView alloc]initWithFrame:CGRectMake(0, yPosition, viewToLoadData.frame.size.width , 60)];
    loadingView.tag = 10086;
    
    
    NSString *string = @"加载中";
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f]};
    CGSize labelSize = [string sizeWithAttributes:attributes];
    if (![viewToLoadData viewWithTag:10087]) {
        UIActivityIndicatorView * activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        activityIndicatorView.frame = CGRectMake(( loadingView.frame.size.width - labelSize.width-20-5)/2, 15.0f, 20.0f, 20.0f);
        activityIndicatorView.tag = 10087;
        [loadingView addSubview:activityIndicatorView];
        [activityIndicatorView startAnimating];
    }
    
    
    if (![viewToLoadData viewWithTag:10088]) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake([loadingView viewWithTag:10087] .frame.origin.x + 20+5, 10.0f, labelSize.width, 30.0f)];
        label.tag = 10088;
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        label.font = [UIFont systemFontOfSize:14.0f];
        label.textColor = [UIColor whiteColor];
        // label.shadowColor = [UIColor colorWithWhite:.9f alpha:1.0f];
        //label.shadowOffset = CGSizeMake(0.0f, 1.0f);
        label.backgroundColor = [UIColor clearColor];
        //        label.textAlignment = UITextAlignmentLeft;
        label.text = @"加载中";
        [loadingView addSubview:label];
    }
    [viewToLoadData addSubview:loadingView];
    
}

#pragma mark - Only ActivityView

+(void)addLoadingViewInView:(UIView*)viewToLoadData usingUIActivityIndicatorViewStyle:(UIActivityIndicatorViewStyle)aStyle usingColor:(UIColor*)color
{
    UIActivityIndicatorView * breakingLoadingView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:aStyle];
    breakingLoadingView.tag = 99;
    breakingLoadingView.center = CGPointMake( (viewToLoadData.frame.size.width-40)/2+20, (viewToLoadData.frame.size.height-40)/2+20);
    breakingLoadingView.color = color;
    [breakingLoadingView startAnimating];
    [viewToLoadData addSubview:breakingLoadingView];
    
    
}


+(void)addLoadingViewInView:(UIView*)viewToLoadData usingUIActivityIndicatorViewStyle:(UIActivityIndicatorViewStyle)aStyle
{
    
    //    [self addLoadingViewInView:viewToLoadData usingUIActivityIndicatorViewStyle:aStyle usingColor:[UIColor redColor]];
}

+(void)removeLoadingViewInView:(UIView*)viewToLoadData
{
    UIActivityIndicatorView * breakingLoadingView = (UIActivityIndicatorView*)[viewToLoadData  viewWithTag:99];
    [breakingLoadingView stopAnimating];
    [breakingLoadingView removeFromSuperview];
}

+ (NSDate *)getNowTime
{
    return [NSDate date];
}

+(NSString *)getyyyymmddHHmmss{
    NSDate *now = [NSDate date];
    NSDateFormatter *formatDay = [[NSDateFormatter alloc] init];
    formatDay.dateFormat = @"yyyyMMddHHmmss";
    NSString *dayStr = [formatDay stringFromDate:now];
    
    return dayStr;
    
}

+(NSString *)getyyyymmdd{
    NSDate *now = [NSDate date];
    NSDateFormatter *formatDay = [[NSDateFormatter alloc] init];
    formatDay.dateFormat = @"yyyyMMdd";
    NSString *dayStr = [formatDay stringFromDate:now];
    
    return dayStr;
    
}
+(NSString *)gethhmmss{
    NSDate *now = [NSDate date];
    NSDateFormatter *formatTime = [[NSDateFormatter alloc] init];
    formatTime.dateFormat = @"HHmmss";
    NSString *timeStr = [formatTime stringFromDate:now];
    
    return timeStr;
    
}
+ (NSString *)get1970timeString{
    return [NSString stringWithFormat:@"%lld",(long long)[[NSDate date] timeIntervalSince1970] * 1000];
}
+ (NSString *)getTimeString:(NSDate *)date{
    return [NSString stringWithFormat:@"%lld",(long long)[date timeIntervalSince1970] * 1];
}
+ (NSString *)documentsDirectoryPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    return documentsDirectoryPath;
}
+ (void)showTipsWithHUD:(NSString *)labelText showTime:(CGFloat)time {
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:[[[UIApplication sharedApplication] delegate] window]];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabel.text = labelText;
    hud.detailsLabel.font = [UIFont systemFontOfSize:15.0];
    hud.removeFromSuperViewOnHide = YES;
    [hud showAnimated:YES];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:hud];
    
    [hud hideAnimated:YES afterDelay:time];
}

+ (void)showTipsWithHUD:(NSString *)labelText
{
    [self showTipsWithHUD:labelText showTime:1.5];
}

+ (void)showTipsWithHUD:(NSString*)labelText inView:(UIView *)inView
{
    [XLsn0w showTipsWithView:inView labelText:labelText showTime:1.5];
}

+ (void)showTipsWithView:(UIView *)uiview labelText:(NSString *)labelText showTime:(CGFloat)time
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:uiview] ;
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabel.text = labelText;
    hud.detailsLabel.font = [UIFont systemFontOfSize:15.0];
    hud.removeFromSuperViewOnHide = YES;
    [hud showAnimated:YES];
    [uiview addSubview:hud];
    
    [hud hideAnimated:YES afterDelay:time];
}
+ (void)showProgessInView:(UIView *)view withExtBlock:(void (^)(void))exBlock withComBlock:(void (^)(void))comBlock
{
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:view];
    hud.bezelView.color = [UIColor colorWithWhite:0.8 alpha:0.6];
    //    hud.dimBackground = NO;
    [view addSubview:hud];
    hud.label.text = @"正在加载...";
    if (exBlock) {
        [hud removeFromSuperview];
    }else {
        [hud removeFromSuperview];
    }
}

+ (void) showHudMessage:(NSString*) msg hideAfterDelay:(NSInteger) sec uiview:(UIView *)uiview
{
    
    MBProgressHUD* hud2 = [MBProgressHUD showHUDAddedTo:uiview animated:YES];
    hud2.mode = MBProgressHUDModeText;
    hud2.label.text = msg;
    hud2.margin = 12.0f;
    [hud2 setOffset:(CGPointMake(0, 20))];
    hud2.removeFromSuperViewOnHide = YES;
    [hud2 hideAnimated:YES afterDelay:sec];
}




+ (void)showNotReachabileTips {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"与服务端连接已断开,请检查您的网络连接是否正常."
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"确定", nil];
    [alertView show];
}

+(NSDate *)dateFromString:(NSString *)dateString usingFormat:(NSString*)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: format];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    
    return destDate;
    
}

+ (NSDate *)dateFromString:(NSString *)dateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    
    return destDate;
}
+ (NSString *)stringFromDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
}

+ (NSString *)stringFromDate:(NSDate *)date usingFormat:(NSString*)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
    
}
+ (NSString *)getDeviceOSType
{
    NSString *systemVersion =  [NSString stringWithFormat:@"%@", [[UIDevice currentDevice] systemVersion]];
    return systemVersion;
}
+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation //图片旋转
{
    long double rotate = 0.0;
    CGRect rect;
    float translateX = 0;
    float translateY = 0;
    float scaleX = 1.0;
    float scaleY = 1.0;
    
    switch (orientation) {
        case UIImageOrientationLeft:
            rotate = M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = 0;
            translateY = -rect.size.width;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationRight:
            rotate = 3 * M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = -rect.size.height;
            translateY = 0;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationDown:
            rotate = M_PI;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = -rect.size.width;
            translateY = -rect.size.height;
            break;
        default:
            rotate = 0.0;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = 0;
            translateY = 0;
            break;
    }
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //做CTM变换
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextRotateCTM(context, rotate);
    CGContextTranslateCTM(context, translateX, translateY);
    
    CGContextScaleCTM(context, scaleX, scaleY);
    //绘制图片
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), image.CGImage);
    
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    
    return newPic;
}

//将图片保存到应用程序沙盒中去,imageNameString的格式为 @"upLoad.png"
+ (void)saveImagetoLocal:(UIImage*)image imageName:(NSString *)imageNameString
{
    if (image == nil || imageNameString.length == 0) {
        return;
    }
    NSArray*paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentsDirectory=[paths objectAtIndex:0];
    NSString *saveImagePath=[documentsDirectory stringByAppendingPathComponent:imageNameString];
    NSData *imageDataJPG=UIImageJPEGRepresentation(image, 0);//将图片大小进行压缩
    //    NSData *imageData=UIImagePNGRepresentation(image);
    [imageDataJPG writeToFile:saveImagePath atomically:YES];
}

//md5转换
+ (NSString *) fileMd5sum:(NSString * )filename
{
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:filename];
    if( handle== nil ) {
        return nil;
    }
    CC_MD5_CTX md5;
    CC_MD5_Init(&md5);
    BOOL done = NO;
    while(!done)
    {
        NSData* fileData = [handle readDataOfLength: 256 ];
        CC_MD5_Update(&md5, (const void *)[fileData bytes], (CC_LONG)[fileData length]);
        if( [fileData length] == 0 ) done = YES;
    }
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(digest, &md5);
    NSString* s = [NSString stringWithFormat: @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                   digest[0], digest[1],
                   digest[2], digest[3],
                   digest[4], digest[5],
                   digest[6], digest[7],
                   digest[8], digest[9],
                   digest[10], digest[11],
                   digest[12], digest[13],
                   digest[14], digest[15]];
    
    return s;
}


#pragma mark - 将字符串中的文字和表情解析出来
+ (NSMutableArray *)decorateString:(NSString *)string
{
    NSMutableArray *array =[NSMutableArray array];
    
    NSRegularExpression* regex = [[NSRegularExpression alloc]
                                  initWithPattern:PATTERN_STR
                                  options:NSRegularExpressionCaseInsensitive|NSRegularExpressionDotMatchesLineSeparators
                                  error:nil];
    NSArray* chunks = [regex matchesInString:string options:0
                                       range:NSMakeRange(0, [string length])];
    NSMutableArray *matchRanges = [NSMutableArray array];
    
    for (NSTextCheckingResult *result in chunks) {
        NSString *resultStr = [string substringWithRange:[result range]];
        
        if ([resultStr hasPrefix:@"["] && [resultStr hasSuffix:@"]"]) {
            NSString *name = [resultStr substringWithRange:NSMakeRange(1, [resultStr length]-2)];
            name=[NSString stringWithFormat:@"[%@]",name];
            NSLog(@"name:%@",name);
            NSDictionary *faceMap = [[NSUserDefaults standardUserDefaults] objectForKey:@"FaceMap"];
            if ([[faceMap allValues] containsObject:name]) {
                //                [array addObject:name];
                [matchRanges addObject:[NSValue valueWithRange:result.range]];
            }
        }
    }
    
    NSRange r = NSMakeRange([string length], 0);
    [matchRanges addObject:[NSValue valueWithRange:r]];
    
    NSUInteger lastLoc = 0;
    for (NSValue *v in matchRanges) {
        
        NSRange resultRange = [v rangeValue];
        if (resultRange.location==0) {
            NSString *faceString = [string substringWithRange:resultRange];
            NSLog(@"aaaaaaaaa:faceString:%@",faceString);
            if (faceString.length!=0) {
                [array addObject:faceString];
            }
            
            NSRange normalStringRange = NSMakeRange(lastLoc, resultRange.location - lastLoc);
            NSString *normalString = [string substringWithRange:normalStringRange];
            lastLoc = resultRange.location + resultRange.length;
            NSLog(@"aaaaaaa:normalString:%@",normalString);
            if (normalString.length!=0) {
                [array addObject:normalString];
            }
        }else{
            NSRange normalStringRange = NSMakeRange(lastLoc, resultRange.location - lastLoc);
            NSString *normalString = [string substringWithRange:normalStringRange];
            lastLoc = resultRange.location + resultRange.length;
            NSLog(@"bbbbbbb:normalString:%@",normalString);
            if (normalString.length!=0) {
                [array addObject:normalString];
            }
            
            NSString *faceString = [string substringWithRange:resultRange];
            NSLog(@"bbbbbbbb:faceString:%@",faceString);
            if (faceString.length!=0) {
                [array addObject:faceString];
            }
        }
    }
    if ([matchRanges count]==0) {
        if (string.length!=0) {
            [array addObject:string];
        }
    }
    NSLog(@"array:%@",array);
    
    return array;
}

#pragma mark - 获取文本尺寸
/*
 + (CGFloat)getContentSize:(NSArray *)messageRange
 {
 @synchronized ( self ) {
 CGFloat upX;
 
 CGFloat upY;
 
 CGFloat lastPlusSize;
 
 CGFloat viewWidth;
 
 CGFloat viewHeight;
 
 BOOL isLineReturn;
 
 //        RelayBottleList *mineBottleListObject = [relayBottleArray objectAtIndex:indexPath.row];
 //        NSArray *messageRange = mineBottleListObject.messageRange;
 
 NSDictionary *faceMap = [[NSUserDefaults standardUserDefaults] objectForKey:@"FaceMap"];
 
 UIFont *font = [UIFont systemFontOfSize:16.0f];
 
 isLineReturn = NO;
 
 upX = VIEW_LEFT;
 upY = VIEW_TOP;
 
 for (int index = 0; index < [messageRange count]; index++) {
 
 NSString *str = [messageRange objectAtIndex:index];
 if ( [str hasPrefix:FACE_NAME_HEAD] ) {
 
 //NSString *imageName = [str substringWithRange:NSMakeRange(1, str.length - 2)];
 
 NSArray *imageNames = [faceMap allKeysForObject:str];
 NSString *imageName = nil;
 NSString *imagePath = nil;
 
 if ( imageNames.count > 0 ) {
 
 imageName = [imageNames objectAtIndex:0];
 imagePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
 }
 
 if ( imagePath ) {
 
 if ( upX > ( VIEW_WIDTH_MAX - KFacialSizeWidth ) ) {
 
 isLineReturn = YES;
 
 upX = VIEW_LEFT;
 upY += VIEW_LINE_HEIGHT;
 }
 
 upX += KFacialSizeWidth;
 
 lastPlusSize = KFacialSizeWidth;
 }
 else {
 
 for ( int index = 0; index < str.length; index++) {
 
 NSString *character = [str substringWithRange:NSMakeRange( index, 1 )];
 
 CGSize size = [character sizeWithFont:font
 constrainedToSize:CGSizeMake(VIEW_WIDTH_MAX, VIEW_LINE_HEIGHT * 1.5)];
 
 if ( upX > ( VIEW_WIDTH_MAX - KCharacterWidth ) ) {
 
 isLineReturn = YES;
 
 upX = VIEW_LEFT;
 upY += VIEW_LINE_HEIGHT;
 }
 
 upX += size.width;
 
 lastPlusSize = size.width;
 }
 }
 }
 else {
 
 for ( int index = 0; index < str.length; index++) {
 
 NSString *character = [str substringWithRange:NSMakeRange( index, 1 )];
 
 CGSize size = [character sizeWithFont:font
 constrainedToSize:CGSizeMake(VIEW_WIDTH_MAX, VIEW_LINE_HEIGHT * 1.5)];
 
 if ( upX > ( VIEW_WIDTH_MAX - KCharacterWidth ) ) {
 
 isLineReturn = YES;
 
 upX = VIEW_LEFT;
 upY += VIEW_LINE_HEIGHT;
 }
 
 upX += size.width;
 
 lastPlusSize = size.width;
 }
 }
 }
 
 if ( isLineReturn ) {
 
 viewWidth = VIEW_WIDTH_MAX + VIEW_LEFT * 2;
 }
 else {
 
 viewWidth = upX + VIEW_LEFT;
 }
 
 viewHeight = upY + VIEW_LINE_HEIGHT + VIEW_TOP;
 
 NSValue *sizeValue = [NSValue valueWithCGSize:CGSizeMake( viewWidth, viewHeight )];
 NSLog(@"%@",sizeValue);
 //        [sizeList setObject:sizeValue forKey:indexPath];
 //        [sizeList addObject:sizeValue];
 return viewHeight;
 }
 }
 */
//正则表达式判断～～～
//#define MOBILE_REG "^1[0-9]{10}$"                                                /* 手机号正则表达式     */
//#define EMAIL_REG  "^[a-zA-Z0-9_+.-]{2,}@([a-zA-Z0-9-]+[.])+[a-zA-Z0-9]{2,4}$"    /* 邮箱正则表达式       */
//#define USRNAM_REG "^[A-Za-z0-9_]{6,20}$"                                         /* 用户名正则表达式     */

//邮箱
+ (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
//手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}
//用户名
+ (BOOL) validateUserName:(NSString *)name
{
    //    NSString *userNameRegex = @"^[A-Za-z0-9]{4,20}+$";
    NSString *userNameRegex = @"^[A-Za-z0-9_]{6,20}$";
    
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:name];
    return B;
}
//密码
+ (BOOL) validatePassword:(NSString *)passWord
{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,16}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}
//昵称
+ (BOOL) validateNickname:(NSString *)nickname
{
    NSString *nicknameRegex = @"([\u4e00-\u9fa5]{2,5})(&middot;[\u4e00-\u9fa5]{2,5})*";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:nickname];
}
//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}
//银行卡
+ (BOOL) validateBankCardNumber: (NSString *)bankCardNumber
{
    BOOL flag;
    if (bankCardNumber.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{15,30})";
    NSPredicate *bankCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [bankCardPredicate evaluateWithObject:bankCardNumber];
}
//银行卡后四位
+ (BOOL) validateBankCardLastNumber: (NSString *)bankCardNumber
{
    BOOL flag;
    if (bankCardNumber.length != 4) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{4})";
    NSPredicate *bankCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [bankCardPredicate evaluateWithObject:bankCardNumber];
}
//CVN
+ (BOOL) validateCVNCode: (NSString *)cvnCode
{
    BOOL flag;
    if (cvnCode.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{3})";
    NSPredicate *cvnCodePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [cvnCodePredicate evaluateWithObject:cvnCode];
}
//month
+ (BOOL) validateMonth: (NSString *)month
{
    BOOL flag;
    if (!(month.length == 2)) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"(^(0)([0-9])$)|(^(1)([0-2])$)";
    NSPredicate *monthPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [monthPredicate evaluateWithObject:month];
}
//year
+ (BOOL) validateYear: (NSString *)year
{
    BOOL flag;
    if (!(year.length == 2)) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^([1-3])([0-9])$";
    NSPredicate *yearPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [yearPredicate evaluateWithObject:year];
}
//verifyCode
+ (BOOL) validateVerifyCode: (NSString *)verifyCode
{
    BOOL flag;
    if (!(verifyCode.length == 6)) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{6})";
    NSPredicate *verifyCodePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [verifyCodePredicate evaluateWithObject:verifyCode];
}



//加载XIB
//+(id)loadFromXIB:(NSString *)XIBName{
//    NSArray *array = [[NSBundle mainBundle] loadNibNamed:XIBName owner:nil options:nil];
//    if (array && [array count]) {
//        return array[0];
//    }else {
//        return nil;
//    }
//}
+ (int)convertToInt:(NSString*)strtemp
{
    int strlength = 0;
    char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }else {
            p++;
        }
    }
    return strlength;
}

- (int)getToInt:(NSString*)strtemp
{
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData* da = [strtemp dataUsingEncoding:enc];
    return (int)[da length];
}
//压缩图片质量
+(UIImage *)reduceImage:(UIImage *)image percent:(float)percent
{
    NSData *imageData = UIImageJPEGRepresentation(image, percent);
    UIImage *newImage = [UIImage imageWithData:imageData];
    return newImage;
}
//压缩图片尺寸
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}

+ (UIColor *)colorWithHexString:(NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}
//自定义字符串长度
+ (CGSize)getWidthByString:(NSString*)string withFont:(UIFont*)stringFont withStringSize:(CGSize)stringSize
{
    NSDictionary *attribute = @{NSFontAttributeName: stringFont};
    CGSize size = [string boundingRectWithSize:stringSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    //MyLog(@"withd:%f,height:%f",size.width,size.height);
    return size;
}

+ (BOOL)checkNum:(NSString *)str
{
    NSString *regex = @"^[0-9]*$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:str];
    if (!isMatch) {
        return NO;
    }
    return YES;
}
//一键赋值
+ (NSArray*)propertyKeys:(id)selfObject

{
    
    unsigned int outCount, i;
    
    objc_property_t *properties = class_copyPropertyList([selfObject class], &outCount);
    
    NSMutableArray *keys = [[NSMutableArray alloc] initWithCapacity:outCount];
    
    for (i = 0; i < outCount; i++) {
        
        objc_property_t property = properties[i];
        
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        if ([propertyName isEqualToString:@"selfId"]) {
            propertyName=@"id";
        }
        [keys addObject:propertyName];
        
    }
    
    free(properties);
    
    return keys;
    
}


// View转化为图片
+ (UIImage *)getImageFromView:(UIView *)view
{
    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

// imageView转化为图片
+ (UIImage *)getImageFromImageView:(UIImageView *)imageView
{
    UIGraphicsBeginImageContext(imageView.bounds.size);
    [imageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


+ (NSInteger)getCellMaxNum:(CGFloat)cellHeight maxHeight:(CGFloat)height
{
    CGFloat num=height/cellHeight;
    int num1=(int)(height/cellHeight);
    NSInteger num2;
    if (num>num1*1.0) {
        num2=num1+1;
    }else
    {
        num2=num1;
    }
    return num2;
}
//匹配数字和英文字母
+ (BOOL) isNumberOrEnglish:(NSString *)string
{
    int i=0;
    if (i<string.length) {
        NSString *passWordRegex = @"^[A-Za-z0-9]+$";
        NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
        return [passWordPredicate evaluateWithObject:string];
    }
    return YES;
}
//匹配数字
+ (BOOL) isKimiNumber:(NSString *)number
{
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}
//是否存在字段
+ (BOOL)rangeString:(NSString *)string searchString:(NSString *)searchString
{
    NSRange range = [string rangeOfString:searchString];
    if (range.length > 0) {
        return YES;
    } else {
        return NO;
    }
}

/// 把对象归档存到沙盒里
+(void)saveObject:(id)object byFileName:(NSString*)fileName
{
    NSString *path  = [self appendFilePath:fileName];
    
    [NSKeyedArchiver archiveRootObject:object toFile:path];
    
}
/// 通过文件名从沙盒中找到归档的对象
+(id)getObjectByFileName:(NSString*)fileName
{
    
    NSString *path  = [self appendFilePath:fileName];
    
    return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}

// 根据文件名删除沙盒中的 plist 文件
+(void)removeFileByFileName:(NSString*)fileName
{
    NSString *path  = [self appendFilePath:fileName];
    
    [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
}

/// 拼接文件路径
+(NSString*)appendFilePath:(NSString*)fileName
{
    
    NSString *documentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    NSString *file = [NSString stringWithFormat:@"%@/%@.archiver",documentsPath,fileName];
    
    return file;
}

/// 存储用户偏好设置 到 NSUserDefults
+(void)saveUserData:(id)data forKey:(NSString*)key
{
    if (data)
    {
        [[NSUserDefaults standardUserDefaults]setObject:data forKey:key];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
}
/// 读取用户偏好设置
+(id)readUserDataForKey:(NSString*)key
{
    return [[NSUserDefaults standardUserDefaults]objectForKey:key];
    
}
/// 删除用户偏好设置
+(void)removeUserDataForkey:(NSString*)key
{
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:key];
}

+ (NSDate *)fireDateWithWeek:(NSInteger)week
                        hour:(NSInteger)hour
                      minute:(NSInteger)minute
                      second:(NSInteger)second {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setTimeZone:[NSTimeZone defaultTimeZone]];
    
    unsigned currentFlag = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitSecond;
    
    NSDateComponents *component = [calendar components:currentFlag fromDate:[NSDate date]];
    
    if (week) {
        component.weekday = week;
    }
    if (hour) {
        component.hour = hour;
    }
    
    if (minute) {
        component.minute = minute;
    }
    if (second) {
        component.second = second;
    } else {
        component.second = 0;
    }
    
    return [[calendar dateFromComponents:component] dateByAddingTimeInterval:0];
}

#pragma mark - 本地推送
+ (void)localPushForDate:(NSDate *)fireDate
                  forKey:(NSString *)key
               alertBody:(NSString *)alertBody
             alertAction:(NSString *)alertAction
               soundName:(NSString *)soundName
             launchImage:(NSString *)launchImage
                userInfo:(NSDictionary *)userInfo
              badgeCount:(NSUInteger)badgeCount
          repeatInterval:(NSCalendarUnit)repeatInterval {
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    if (!localNotification) {
        return;
    }
    
    [self cancleLocalPushWithKey:key];
    
    //    NSUInteger notificationType; //UIUserNotificationType(>= iOS8) and UIRemoteNotificatioNType(< iOS8) use same value
    //    UIApplication *application = [UIApplication sharedApplication];
    //    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1) {
    //        notificationType = [[application currentUserNotificationSettings] types];
    //    } else {
    //        notificationType = [application enabledRemoteNotificationTypes];
    //    }
    //    if (notificationType == UIRemoteNotificationTypeNone) {
    //        return;
    //    }
    
    // ios8后，需要添加这个注册，才能得到授权
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationType type = UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        // 通知重复提示的单位，可以是天、周、月
        localNotification.alertBody        = alertBody;
        localNotification.alertAction      = alertAction;
        localNotification.alertLaunchImage = launchImage;
        localNotification.repeatInterval   = repeatInterval;
    } else {
        localNotification.alertBody        = alertBody;
        localNotification.alertAction      = alertAction;
        localNotification.alertLaunchImage = launchImage;
        localNotification.repeatInterval   = repeatInterval;
    }
    
    //Sound
    if (soundName) {
        localNotification.soundName = soundName;
    } else {
        localNotification.soundName = UILocalNotificationDefaultSoundName;
    }
    
    //Badge
    //    if ((notificationType & UIRemoteNotificationTypeBadge) != UIRemoteNotificationTypeBadge) {
    //    } else {
    //        localNotification.applicationIconBadgeNumber = badgeCount;
    //    }
    
    if (!fireDate) {
        [[UIApplication sharedApplication] presentLocalNotificationNow:localNotification];
    } else {
        localNotification.fireDate = fireDate;
        localNotification.timeZone = [NSTimeZone defaultTimeZone];
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    }
    
}

#pragma mark - 退出
+ (void)cancelAllLocalPhsh {
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

+ (void)cancleLocalPushWithKey:(NSString *)key {
    NSArray *notiArray = [[UIApplication sharedApplication] scheduledLocalNotifications];
    if (notiArray) {
        for (UILocalNotification *notification in notiArray) {
            NSDictionary *dic = notification.userInfo;
            if (dic) {
                for (NSString *key in dic) {
                    if ([key isEqualToString:key]) {
                        [[UIApplication sharedApplication] cancelLocalNotification:notification];
                    }
                }
            }
        }
    }
}

//数组存入阴历1900年到2100年每年中的月天数信息，
//阴历每月只能是29或30天，一年用12（或13）个二进制位表示，对应位为1表30天，否则为29天
int LunarCalendarInfo[] = {
    0x04bd8,0x04ae0,0x0a570,0x054d5,0x0d260,0x0d950,0x16554,0x056a0,0x09ad0,0x055d2,
    0x04ae0,0x0a5b6,0x0a4d0,0x0d250,0x1d255,0x0b540,0x0d6a0,0x0ada2,0x095b0,0x14977,
    0x04970,0x0a4b0,0x0b4b5,0x06a50,0x06d40,0x1ab54,0x02b60,0x09570,0x052f2,0x04970,
    0x06566,0x0d4a0,0x0ea50,0x06e95,0x05ad0,0x02b60,0x186e3,0x092e0,0x1c8d7,0x0c950,
    0x0d4a0,0x1d8a6,0x0b550,0x056a0,0x1a5b4,0x025d0,0x092d0,0x0d2b2,0x0a950,0x0b557,
    
    0x06ca0,0x0b550,0x15355,0x04da0,0x0a5b0,0x14573,0x052b0,0x0a9a8,0x0e950,0x06aa0,
    0x0aea6,0x0ab50,0x04b60,0x0aae4,0x0a570,0x05260,0x0f263,0x0d950,0x05b57,0x056a0,
    0x096d0,0x04dd5,0x04ad0,0x0a4d0,0x0d4d4,0x0d250,0x0d558,0x0b540,0x0b6a0,0x195a6,
    0x095b0,0x049b0,0x0a974,0x0a4b0,0x0b27a,0x06a50,0x06d40,0x0af46,0x0ab60,0x09570,
    0x04af5,0x04970,0x064b0,0x074a3,0x0ea50,0x06b58,0x055c0,0x0ab60,0x096d5,0x092e0,
    
    0x0c960,0x0d954,0x0d4a0,0x0da50,0x07552,0x056a0,0x0abb7,0x025d0,0x092d0,0x0cab5,
    0x0a950,0x0b4a0,0x0baa4,0x0ad50,0x055d9,0x04ba0,0x0a5b0,0x15176,0x052b0,0x0a930,
    0x07954,0x06aa0,0x0ad50,0x05b52,0x04b60,0x0a6e6,0x0a4e0,0x0d260,0x0ea65,0x0d530,
    0x05aa0,0x076a3,0x096d0,0x04bd7,0x04ad0,0x0a4d0,0x1d0b6,0x0d250,0x0d520,0x0dd45,
    0x0b5a0,0x056d0,0x055b2,0x049b0,0x0a577,0x0a4b0,0x0aa50,0x1b255,0x06d20,0x0ada0,
    
    0x04b63,0x0937f,0x049f8,0x04970,0x064b0,0x068a6,0x0ea5f,0x06b20,0x0a6c4,0x0aaef,
    0x092e0,0x0d2e3,0x0c960,0x0d557,0x0d4a0,0x0da50,0x05d55,0x056a0,0x0a6d0,0x055d4,
    0x052d0,0x0a9b8,0x0a950,0x0b4a0,0x0b6a6,0x0ad50,0x055a0,0x0aba4,0x0a5b0,0x052b0,
    0x0b273,0x06930,0x07337,0x06aa0,0x0ad50,0x04b55,0x04b6f,0x0a570,0x054e4,0x0d260,
    0x0e968,0x0d520,0x0daa0,0x06aa6,0x056df,0x04ae0,0x0a9d4,0x0a4d0,0x0d150,0x0f252,
    0x0d520};

-(id)init {
    self = [super init];
    
    HeavenlyStems = [NSArray arrayWithObjects:@"甲",@"乙",@"丙",@"丁",@"戊",@"己",@"庚",@"辛",@"壬",@"癸",nil];
    EarthlyBranches = [NSArray arrayWithObjects:@"子",@"丑",@"寅",@"卯",@"辰",@"巳",@"午",@"未",@"申",@"酉",@"戌",@"亥",nil];
    LunarZodiac = [NSArray arrayWithObjects:@"鼠",@"牛",@"虎",@"兔",@"龙",@"蛇",@"马",@"羊",@"猴",@"鸡",@"狗",@"猪",nil];
    
    SolarTerms = [NSArray arrayWithObjects:@"立春", @"雨水", @"惊蛰", @"春分", @"清明", @"谷雨", @"立夏", @"小满", @"芒种", @"夏至", @"小暑", @"大暑", @"立秋", @"处暑", @"白露", @"秋分", @"寒露", @"霜降", @"立冬", @"小雪", @"大雪", @"冬至", @"小寒", @"大寒", nil];
    
    arrayMonth = [NSArray arrayWithObjects:@"正月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月", @"九月",  @"十月", @"冬月", @"腊月", nil];
    
    arrayDay = [NSArray arrayWithObjects:@"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十", @"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十", @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十", @"三一", nil];
    
    holiday=[[NSMutableArray alloc] init];
    
    if(!self)
    {
        return nil;
    }
    
    return self;
}

- (void)loadWithDate:(NSDate *)adate {
    if (adate == nil)
        [self loadWithDate:[NSDate date]];
    else
    {
        HeavenlyStems = [NSArray arrayWithObjects:@"甲",@"乙",@"丙",@"丁",@"戊",@"己",@"庚",@"辛",@"壬",@"癸",nil];
        EarthlyBranches = [NSArray arrayWithObjects:@"子",@"丑",@"寅",@"卯",@"辰",@"巳",@"午",@"未",@"申",@"酉",@"戌",@"亥",nil];
        LunarZodiac = [NSArray arrayWithObjects:@"鼠",@"牛",@"虎",@"兔",@"龙",@"蛇",@"马",@"羊",@"猴",@"鸡",@"狗",@"猪",nil];
        
        SolarTerms = [NSArray arrayWithObjects:@"立春", @"雨水", @"惊蛰", @"春分", @"清明", @"谷雨", @"立夏", @"小满", @"芒种", @"夏至", @"小暑", @"大暑", @"立秋", @"处暑", @"白露", @"秋分", @"寒露", @"霜降", @"立冬", @"小雪", @"大雪", @"冬至", @"小寒", @"大寒", nil];
        
        arrayMonth = [NSArray arrayWithObjects:@"正月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月", @"九月",  @"十月", @"冬月", @"腊月", nil];
        
        arrayDay = [NSArray arrayWithObjects:@"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十", @"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十", @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十", @"三一", nil];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
        
        [dateFormatter setDateFormat:@"yyyy"];
        year = [[dateFormatter stringFromDate:adate] intValue];
        
        [dateFormatter setDateFormat:@"MM"];
        month = [[dateFormatter stringFromDate:adate] intValue];
        
        [dateFormatter setDateFormat:@"dd"];
        day = [[dateFormatter stringFromDate:adate] intValue];
        
        thisdate = adate;
    }
}

-(void)InitializeValue {
    NSString *start = @"1900-01-31";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *end = [dateFormatter stringFromDate:thisdate];
    
    NSDateFormatter *f = [[NSDateFormatter alloc] init] ;
    [f setDateFormat:@"yyyy-MM-dd"];
    NSDate *startDate = [f dateFromString:start];
    NSDate *endDate = [f dateFromString:end];
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay fromDate:startDate toDate:endDate options:0];
    
    int dayCyclical=(int)(([components day] + 30)/(86400/(3600*24)))+10;
    
    int sumdays = (int)[components day];
    
    int tempdays = 0;
    
    //计算农历年
    for (lunarYear = 1900; lunarYear < 2100 && sumdays > 0; lunarYear++)
    {
        tempdays = [self LunarYearDays:lunarYear];
        sumdays -= tempdays;
    }
    
    if (sumdays < 0)
    {
        sumdays += tempdays;
        lunarYear--;
    }
    
    //计算闰月
    doubleMonth = [self DoubleMonth:lunarYear];
    isLeap = false;
    
    //计算农历月
    for (lunarMonth = 1; lunarMonth < 13 && sumdays > 0; lunarMonth++)
    {
        //闰月
        if (doubleMonth > 0 && lunarMonth == (doubleMonth + 1) && isLeap == false)
        {
            --lunarMonth;
            isLeap = true;
            tempdays = [self DoubleMonthDays:lunarYear];
        }
        else
        {
            tempdays = [self MonthDays:lunarYear:lunarMonth];
        }
        
        //解除闰月
        if (isLeap == true && lunarMonth == (doubleMonth + 1))
        {
            isLeap = false;
        }
        sumdays -= tempdays;
    }
    
    //计算农历日
    if (sumdays == 0 && doubleMonth > 0 && lunarMonth == doubleMonth + 1)
    {
        if (isLeap)
        {
            isLeap = false;
        }
        else
        {
            isLeap = true;
            --lunarMonth;
        }
    }
    
    if (sumdays < 0)
    {
        sumdays += tempdays;
        --lunarMonth;
    }
    
    lunarDay = sumdays + 1;
    
    //计算节气
    [self ComputeSolarTerm];
    
    solarTermTitle = @"";
    for (int i=0; i<2; i++)
    {
        NSDateFormatter *currentFormatter = [[NSDateFormatter alloc] init];
        
        [currentFormatter setDateFormat:@"yyyyMMdd"];
        
        if (solarTerm[i].solarDate == [[currentFormatter stringFromDate:thisdate] intValue])
            solarTermTitle = solarTerm[i].solarName;
    }
    
    monthLunar = (NSString *)[arrayMonth objectAtIndex:(lunarMonth - 1)];
    dayLunar = (NSString *)[arrayDay objectAtIndex:(lunarDay - 1)];
    
    NSString *chineseHoliday= [self getChineseHoliday:lunarMonth day:lunarDay];
    if(chineseHoliday!=nil)
    {
        [holiday addObject:chineseHoliday];
    }
    
    NSString *normalHoliday=[self getWorldHoliday:month day:day];
    if (normalHoliday!=nil)
    {
        [holiday addObject:normalHoliday];
    }
    
    NSString *weekHoliday=[self getWeekHoliday:year month:month day:day];
    if (weekHoliday!=nil)
    {
        [holiday addObject:weekHoliday];
    }
    
    zodiacLunar = (NSString *)[LunarZodiac objectAtIndex:((lunarYear - 4) % 60 % 12)];
    
    yearHeavenlyStem = (NSString *)[HeavenlyStems objectAtIndex:((lunarYear - 4) % 60 % 10)];
    if ((((year-1900)*12+month+13)%10) == 0)
        monthHeavenlyStem = (NSString *)[HeavenlyStems objectAtIndex:9];
    else
        monthHeavenlyStem = (NSString *)[HeavenlyStems objectAtIndex:(((year-1900)*12+month+13)%10-1)];
    
    dayHeavenlyStem = (NSString *)[HeavenlyStems objectAtIndex:(dayCyclical%10)];
    
    yearEarthlyBranch = (NSString *)[EarthlyBranches objectAtIndex:((lunarYear - 4) % 60 % 12)];
    if ((((year-1900)*12+month+13)%12) == 0)
        monthEarthlyBranch = (NSString *)[EarthlyBranches objectAtIndex:11];
    else
        monthEarthlyBranch = (NSString *)[EarthlyBranches objectAtIndex:(((year-1900)*12+month+13)%12-1)];
    dayEarthlyBranch = (NSString *)[EarthlyBranches objectAtIndex:(dayCyclical%12)];
}

-(NSString *)getChineseHoliday:(int)aMonth day:(int)aDay
{
    NSDictionary *chineseHolidayDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                        @"春节", @"1|1",
                                        @"元宵", @"1|15",
                                        @"端午", @"5|5",
                                        @"七夕", @"7|7",
                                        @"中元", @"7|15",
                                        @"中秋", @"8|15",
                                        @"重阳", @"9|9",
                                        @"腊八", @"12|8",
                                        @"小年", @"12|24",
                                        @"除夕", @"12|30",
                                        nil];
    
    return [chineseHolidayDict objectForKey:[NSString stringWithFormat:@"%d|%d",aMonth,aDay]];
}

-(NSString *)getWorldHoliday:(int)aMonth day:(int)aDay
{
    NSString *monthDay;
    if(aMonth<10 && aDay<10)
    {
        monthDay=[NSString stringWithFormat:@"0%i0%i",aMonth,aDay] ;
    }
    else if(aMonth<10 && aDay>9)
    {
        monthDay=[NSString stringWithFormat:@"0%i%i",aMonth,aDay] ;
    }
    else if(aMonth>9 && aDay<10)
    {
        monthDay=[NSString stringWithFormat:@"%i0%i",aMonth,aDay] ;
    }
    else
    {
        monthDay=[NSString stringWithFormat:@"%i%i",aMonth,aDay] ;
    }
    
    NSMutableDictionary *dict= [[NSMutableDictionary alloc] init];
    [dict setObject:@"元旦" forKey:@"0101"];
    [dict setObject:@"中国第13亿人口日" forKey:@"0106"];
    [dict setObject:@"周恩来逝世纪念日" forKey:@"0108"];
    [dict setObject:@"释迦如来成道日" forKey:@"0115"];
    [dict setObject:@"列宁逝世纪念日 国际声援南非日 弥勒佛诞辰" forKey:@"0121"];
    [dict setObject:@"世界湿地日" forKey:@"0202"];
    [dict setObject:@"二七大罢工纪念日" forKey:@"0207"];
    [dict setObject:@"国际气象节" forKey:@"0210"];
    [dict setObject:@"情人节" forKey:@"0214"];
    [dict setObject:@"中国12亿人口日" forKey:@"0215"];
    [dict setObject:@"邓小平逝世纪念日" forKey:@"0219"];
    [dict setObject:@"国际母语日 反对殖民制度斗争日" forKey:@"0221"];
    [dict setObject:@"苗族芦笙节" forKey:@"0222"];
    [dict setObject:@"第三世界青年日" forKey:@"0224"];
    [dict setObject:@"世界居住条件调查日" forKey:@"0228"];
    [dict setObject:@"国际海豹日" forKey:@"0301"];
    [dict setObject:@"全国爱耳日" forKey:@"0303"];
    [dict setObject:@"学雷锋纪念日 中国青年志愿者服务日" forKey:@"0305"];
    [dict setObject:@"妇女节" forKey:@"0308"];
    [dict setObject:@"保护母亲河日" forKey:@"0309"];
    [dict setObject:@"国际尊严尊敬日" forKey:@"0311"];
    [dict setObject:@"国际警察日 白色情人节" forKey:@"0314"];
    [dict setObject:@"消费者权益日" forKey:@"0315"];
    [dict setObject:@"手拉手情系贫困小伙伴全国统一行动日" forKey:@"0316"];
    [dict setObject:@"中国国医节 国际航海日 爱尔兰圣帕特里克节" forKey:@"0317"];
    [dict setObject:@"全国科技人才活动日" forKey:@"0318"];
    [dict setObject:@"世界森林日 消除种族歧视国际日 世界儿歌日 世界睡眠日" forKey:@"0321"];
    [dict setObject:@"世界水日" forKey:@"0322"];
    [dict setObject:@"世界气象日" forKey:@"0323"];
    [dict setObject:@"世界防治结核病日" forKey:@"0324"];
    [dict setObject:@"全国中小学生安全教育日" forKey:@"0325"];
    [dict setObject:@"中国黄花岗七十二烈士殉难纪念" forKey:@"0329"];
    [dict setObject:@"巴勒斯坦国土日" forKey:@"0330"];
    [dict setObject:@"愚人节 全国爱国卫生运动月 税收宣传月" forKey:@"0401"];
    [dict setObject:@"国际儿童图书日" forKey:@"0402"];
    [dict setObject:@"世界卫生日" forKey:@"0407"];
    [dict setObject:@"世界帕金森病日" forKey:@"0411"];
    [dict setObject:@"全国企业家活动日" forKey:@"0421"];
    [dict setObject:@"世界地球日 世界法律日" forKey:@"0422"];
    [dict setObject:@"世界图书和版权日" forKey:@"0423"];
    [dict setObject:@"亚非新闻工作者日 世界青年反对殖民主义日" forKey:@"0424"];
    [dict setObject:@"全国预防接种宣传日" forKey:@"0425"];
    [dict setObject:@"世界知识产权日" forKey:@"0426"];
    [dict setObject:@"世界交通安全反思日" forKey:@"0430"];
    [dict setObject:@"国际劳动节" forKey:@"0501"];
    [dict setObject:@"世界哮喘日 世界新闻自由日" forKey:@"0503"];
    [dict setObject:@"中国五四青年节 科技传播日" forKey:@"0504"];
    [dict setObject:@"碘缺乏病防治日 日本男孩节" forKey:@"0505"];
    [dict setObject:@"世界红十字日" forKey:@"0508"];
    [dict setObject:@"国际护士节" forKey:@"0512"];
    [dict setObject:@"国际家庭日" forKey:@"0515"];
    [dict setObject:@"国际电信日" forKey:@"0517"];
    [dict setObject:@"国际博物馆日" forKey:@"0518"];
    [dict setObject:@"全国学生营养日 全国母乳喂养宣传日" forKey:@"0520"];
    [dict setObject:@"国际牛奶日" forKey:@"0523"];
    [dict setObject:@"世界向人体条件挑战日" forKey:@"0526"];
    [dict setObject:@"中国“五卅”运动纪念日" forKey:@"0530"];
    [dict setObject:@"世界无烟日 英国银行休假日" forKey:@"0531"];
    [dict setObject:@"国际儿童节" forKey:@"0601"];
    [dict setObject:@"世界环境保护日" forKey:@"0605"];
    [dict setObject:@"世界献血者日" forKey:@"0614"];
    [dict setObject:@"防治荒漠化和干旱日" forKey:@"0617"];
    [dict setObject:@"世界难民日" forKey:@"0620"];
    [dict setObject:@"中国儿童慈善活动日" forKey:@"0622"];
    [dict setObject:@"国际奥林匹克日" forKey:@"0623"];
    [dict setObject:@"全国土地日" forKey:@"0625"];
    [dict setObject:@"国际禁毒日 国际宪章日 禁止药物滥用和非法贩运国际日 支援酷刑受害者国际日" forKey:@"0626"];
    [dict setObject:@"世界青年联欢节" forKey:@"0630"];
    [dict setObject:@"建党节 香港回归纪念日 中共诞辰 世界建筑日" forKey:@"0701"];
    [dict setObject:@"国际体育记者日" forKey:@"0702"];
    [dict setObject:@"朱德逝世纪念日" forKey:@"0706"];
    [dict setObject:@"抗日战争纪念日" forKey:@"0707"];
    [dict setObject:@"世界人口日 中国航海日" forKey:@"0711"];
    [dict setObject:@"世界语创立日" forKey:@"0726"];
    [dict setObject:@"第一次世界大战爆发" forKey:@"0728"];
    [dict setObject:@"非洲妇女日" forKey:@"0730"];
    [dict setObject:@"建军节" forKey:@"0801"];
    [dict setObject:@"恩格斯逝世纪念日" forKey:@"0805"];
    [dict setObject:@"国际电影节" forKey:@"0806"];
    [dict setObject:@"中国男子节" forKey:@"0808"];
    [dict setObject:@"国际青年节" forKey:@"0812"];
    [dict setObject:@"国际左撇子日" forKey:@"0813"];
    [dict setObject:@"抗日战争胜利纪念" forKey:@"0815"];
    [dict setObject:@"全国律师咨询日" forKey:@"0826"];
    [dict setObject:@"日本签署无条件投降书日" forKey:@"0902"];
    [dict setObject:@"中国抗日战争胜利纪念日" forKey:@"0903"];
    [dict setObject:@"瑞士萨永中世纪节" forKey:@"0905"];
    [dict setObject:@"帕瓦罗蒂去世" forKey:@"0906"];
    [dict setObject:@"国际扫盲日 国际新闻工作者日" forKey:@"0908"];
    [dict setObject:@"毛泽东逝世纪念日" forKey:@"0909"];
    [dict setObject:@"中国教师节 世界预防自杀日" forKey:@"0910"];
    [dict setObject:@"世界清洁地球日" forKey:@"0914"];
    [dict setObject:@"国际臭氧层保护日 中国脑健康日" forKey:@"0916"];
    [dict setObject:@"九·一八事变纪念日" forKey:@"0918"];
    [dict setObject:@"国际爱牙日" forKey:@"0920"];
    [dict setObject:@"世界停火日 预防世界老年性痴呆宣传日" forKey:@"0921"];
    [dict setObject:@"世界旅游日" forKey:@"0927"];
    [dict setObject:@"孔子诞辰" forKey:@"0928"];
    [dict setObject:@"国际翻译日" forKey:@"0930"];
    [dict setObject:@"国庆节 世界音乐日 国际老人节" forKey:@"1001"];
    [dict setObject:@"国际和平与民主自由斗争日" forKey:@"1002"];
    [dict setObject:@"世界动物日" forKey:@"1004"];
    [dict setObject:@"国际教师节" forKey:@"1005"];
    [dict setObject:@"中国老年节" forKey:@"1006"];
    [dict setObject:@"全国高血压日 世界视觉日" forKey:@"1008"];
    [dict setObject:@"世界邮政日 万国邮联日" forKey:@"1009"];
    [dict setObject:@"辛亥革命纪念日 世界精神卫生日 世界居室卫生日" forKey:@"1010"];
    [dict setObject:@"世界保健日 国际教师节 中国少年先锋队诞辰日 世界保健日" forKey:@"1013"];
    [dict setObject:@"世界标准日" forKey:@"1014"];
    [dict setObject:@"国际盲人节(白手杖节)" forKey:@"1015"];
    [dict setObject:@"世界粮食日" forKey:@"1016"];
    [dict setObject:@"世界消除贫困日" forKey:@"1017"];
    [dict setObject:@"世界骨质疏松日" forKey:@"1020"];
    [dict setObject:@"世界传统医药日" forKey:@"1022"];
    [dict setObject:@"联合国日 世界发展新闻日" forKey:@"1024"];
    [dict setObject:@"中国男性健康日" forKey:@"1028"];
    [dict setObject:@"万圣节 世界勤俭日" forKey:@"1031"];
    [dict setObject:@"达摩祖师圣诞" forKey:@"1102"];
    [dict setObject:@"柴科夫斯基逝世悼念日" forKey:@"1106"];
    [dict setObject:@"十月社会主义革命纪念日" forKey:@"1107"];
    [dict setObject:@"中国记者日" forKey:@"1108"];
    [dict setObject:@"全国消防安全宣传教育日" forKey:@"1109"];
    [dict setObject:@"世界青年节" forKey:@"1110"];
    [dict setObject:@"光棍节 国际科学与和平周" forKey:@"1111"];
    [dict setObject:@"孙中山诞辰纪念日" forKey:@"1112"];
    [dict setObject:@"世界糖尿病日" forKey:@"1114"];
    [dict setObject:@"泰国大象节" forKey:@"1115"];
    [dict setObject:@"国际大学生节 世界学生节 世界戒烟日" forKey:@"1117"];
    [dict setObject:@"世界儿童日" forKey:@"1120"];
    [dict setObject:@"世界问候日 世界电视日" forKey:@"1121"];
    [dict setObject:@"国际声援巴勒斯坦人民国际日" forKey:@"1129"];
    [dict setObject:@"世界艾滋病日" forKey:@"1201"];
    [dict setObject:@"废除一切形式奴役世界日" forKey:@"1202"];
    [dict setObject:@"世界残疾人日" forKey:@"1203"];
    [dict setObject:@"全国法制宣传日" forKey:@"1204"];
    [dict setObject:@"国际经济和社会发展志愿人员日 世界弱能人士日" forKey:@"1205"];
    [dict setObject:@"国际民航日" forKey:@"1207"];
    [dict setObject:@"国际儿童电视日" forKey:@"1208"];
    [dict setObject:@"世界足球日 一二·九运动纪念日" forKey:@"1209"];
    [dict setObject:@"世界人权日" forKey:@"1210"];
    [dict setObject:@"世界防止哮喘日" forKey:@"1211"];
    [dict setObject:@"西安事变纪念日" forKey:@"1212"];
    [dict setObject:@"南京大屠杀纪念日" forKey:@"1213"];
    [dict setObject:@"国际儿童广播电视节" forKey:@"1214"];
    [dict setObject:@"世界强化免疫日" forKey:@"1215"];
    [dict setObject:@"澳门回归纪念" forKey:@"1220"];
    [dict setObject:@"国际篮球日" forKey:@"1221"];
    [dict setObject:@"平安夜" forKey:@"1224"];
    [dict setObject:@"圣诞节" forKey:@"1225"];
    [dict setObject:@"毛泽东诞辰纪念日 节礼日" forKey:@"1226"];
    [dict setObject:@"国际生物多样性日" forKey:@"1229"];
    
    return [dict objectForKey:monthDay];
}

-(NSString *)getWeekHoliday:(int)aYear month:(int)aMonth day:(int)aDay
{
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
    [dict setObject:@"世界哮喘日" forKey:@"0512"];
    [dict setObject:@"国际母亲节 救助贫困母亲日" forKey:@"0520"];
    [dict setObject:@"全国助残日" forKey:@"0530"];
    [dict setObject:@"国际牛奶日" forKey:@"0532"];
    [dict setObject:@"中国文化遗产日" forKey:@"0626"];
    [dict setObject:@"国际父亲节" forKey:@"0630"];
    [dict setObject:@"国际合作节" forKey:@"0716"];
    [dict setObject:@"被奴役国家周" forKey:@"0730"];
    [dict setObject:@"国际和平日" forKey:@"0932"];
    [dict setObject:@"全民国防教育日" forKey:@"0936"];
    [dict setObject:@"国际聋人节 世界儿童日" forKey:@"0940"];
    [dict setObject:@"世界海事日 世界心脏病日" forKey:@"0950"];
    [dict setObject:@"国际住房日 世界建筑日 世界人居日" forKey:@"1011"];
    [dict setObject:@"国际减灾日" forKey:@"1023"];
    [dict setObject:@"世界视觉日" forKey:@"1024"];
    [dict setObject:@"感恩节" forKey:@"1144"];
    [dict setObject:@"国际儿童电视广播日" forKey:@"1220"];
    
    NSString *result=nil;
    for (id key in [dict allKeys]) {
        NSString *dictMonth=[key substringToIndex:2];
        int dictWeek=[[[key substringFromIndex:2] substringToIndex:1] intValue];
        int dictDayInWeek=[[[key substringFromIndex:3] substringToIndex:1] intValue];
        
        if(aMonth==[dictMonth intValue])
        {
            NSString *resultDay=[self getWeekDay:aYear month:aMonth week:dictWeek dayInWeek:dictDayInWeek];
            
            if(resultDay)
            {
                if([resultDay intValue]==aDay )
                {
                    result=[dict objectForKey:key];
                }
            }
        }
    }
    
    return result;
}

-(NSString *)getWeekDay:(int)aYear month:(int)aMonth week:(int)aWeek dayInWeek:(int)aDay
{
    NSString* dateStr =[NSString stringWithFormat:@"%i 1 %i +0000",aMonth,aYear];
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"M d yyyy zzzz"];
    NSDate* date = [formater dateFromString:dateStr];
    
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components: NSCalendarUnitWeekday | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
    int firstWeek = (int)[components weekday]-1;
    int result=0;
    aDay=aDay+1;
    
    if(aWeek<5)
    {
        result=(firstWeek>aDay?7:0)+7*(aWeek-1)+aDay-firstWeek;
    }
    
    if(result==0)
    {
        return nil;
    }
    else
    {
        return [NSString stringWithFormat:@"%i",result];
    }
}

-(int)LunarYearDays:(int)y
{
    int i, sum = 348;
    for (i = 0x8000; i > 0x8; i >>= 1)
    {
        if ((LunarCalendarInfo[y - 1900] & i) != 0)
            sum += 1;
    }
    return (sum + [self DoubleMonthDays:y]);
}

-(int)DoubleMonth:(int)y
{
    return (LunarCalendarInfo[y - 1900] & 0xf);
}

///返回农历年闰月的天数
-(int)DoubleMonthDays:(int)y
{
    if ([self DoubleMonth:y] != 0)
        return (((LunarCalendarInfo[y - 1900] & 0x10000) != 0) ? 30 : 29);
    else
        return (0);
}

///返回农历年月份的总天数
-(int)MonthDays:(int)y :(int)m
{
    return (((LunarCalendarInfo[y - 1900] & (0x10000 >> m)) != 0) ? 30 : 29);
}

-(void)ComputeSolarTerm
{
    for (int n = month * 2 - 1; n <= month * 2; n++)
    {
        double Termdays = [self Term:year:n:YES];
        double mdays = [self AntiDayDifference:year:floor(Termdays)];
        //double sm1 = floor(mdays / 100);
        int hour = (int)floor((double)[self Tail:Termdays] * 24);
        int minute = (int)floor((double)([self Tail:Termdays] * 24 - hour) * 60);
        int tMonth = (int)ceil((double)n / 2);
        int tday = (int)mdays % 100;
        
        if (n >= 3)
            solarTerm[n - month * 2 + 1].solarName = [SolarTerms objectAtIndex:(n - 3)];
        else
            solarTerm[n - month * 2 + 1].solarName = [SolarTerms objectAtIndex:(n + 21)];
        
        NSDateComponents *components = [[NSDateComponents alloc] init];
        [components setYear:year];
        [components setMonth:tMonth];
        [components setDay:tday];
        [components setHour:hour];
        [components setMinute:minute];
        
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDate *ldate = [gregorian dateFromComponents:components];
        
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        
        [dateFormatter setDateFormat:@"yyyyMMdd"];
        
        solarTerm[n - month * 2 + 1].solarDate = [[dateFormatter stringFromDate:ldate] intValue];
    }
}

-(double)Tail:(double)x
{
    return x - floor(x);
}

-(double)Term:(int)y :(int)n :(bool)pd
{
    //儒略日
    double juD = y * (365.2423112 - 6.4e-14 * (y - 100) * (y - 100) - 3.047e-8 * (y - 100)) + 15.218427 * n + 1721050.71301;
    
    //角度
    double tht = 3e-4 * y - 0.372781384 - 0.2617913325 * n;
    
    //年差实均数
    double yrD = (1.945 * sin(tht) - 0.01206 * sin(2 * tht)) * (1.048994 - 2.583e-5 * y);
    
    //朔差实均数
    double shuoD = -18e-4 * sin(2.313908653 * y - 0.439822951 - 3.0443 * n);
    
    double vs = (pd) ? (juD + yrD + shuoD - [self EquivalentStandardDay:y:1:0] - 1721425) : (juD - [self EquivalentStandardDay:y:1:0] - 1721425);
    return vs;
}

-(double)AntiDayDifference:(int)y :(double)x
{
    int m = 1;
    for (int j = 1; j <= 12; j++)
    {
        int mL = [self DayDifference:y:(j+1):1] - [self DayDifference:y:j:1];
        if (x <= mL || j == 12)
        {
            m = j;
            break;
        }
        else
            x -= mL;
    }
    return 100 * m + x;
}

-(double)EquivalentStandardDay:(int)y :(int)m :(int)d
{
    //Julian的等效标准天数
    double v = (y - 1) * 365 + floor((double)((y - 1) / 4)) + [self DayDifference:y:m:d] - 2;
    
    if (y > 1582)
    {//Gregorian的等效标准天数
        v += -floor((double)((y - 1) / 100)) + floor((double)((y - 1) / 400)) + 2;
    }
    return v;
}

-(int)DayDifference:(int)y :(int)m :(int)d
{
    int ifG = [self IfGregorian:y:m:d:1];
    //NSArray *monL = [NSArray arrayWithObjects:, nil];
    NSInteger monL[] = {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
    if (ifG == 1)
    {
        if ((y % 100 != 0 && y % 4 == 0) || (y % 400 == 0))
            monL[2] += 1;
        else
        {
            if (y % 4 == 0)
                monL[2] += 1;
        }
    }
    
    int v = 0;
    
    for (int i = 0; i <= m - 1; i++)
        v += monL[i];
    
    v += d;
    if (y == 1582)
    {
        if (ifG == 1)
            v -= 10;
        if (ifG == -1)
            v = 0;  //infinity
    }
    return v;
}

-(int)IfGregorian:(int)y :(int)m :(int)d :(int)opt
{
    if (opt == 1)
    {
        if (y > 1582 || (y == 1582 && m > 10) || (y == 1582 && m == 10 && d > 14))
            return (1);     //Gregorian
        else
            if (y == 1582 && m == 10 && d >= 5 && d <= 14)
                return (-1);  //空
            else
                return (0);  //Julian
    }
    
    if (opt == 2)
        return (1);     //Gregorian
    if (opt == 3)
        return (0);     //Julian
    return (-1);
}

-(NSString *)MonthLunar
{
    return monthLunar;
}

-(NSString *)DayLunar
{
    return dayLunar;
}

-(NSString *)ZodiacLunar
{
    return zodiacLunar;
}

-(NSString *)YearHeavenlyStem
{
    return yearHeavenlyStem;
}

-(NSString *)MonthHeavenlyStem
{
    return monthHeavenlyStem;
}

-(NSString *)DayHeavenlyStem
{
    return dayHeavenlyStem;
}

-(NSString *)YearEarthlyBranch
{
    return yearEarthlyBranch;
}

-(NSString *)MonthEarthlyBranch
{
    return monthEarthlyBranch;
}

-(NSString *)DayEarthlyBranch
{
    return dayEarthlyBranch;
}

-(NSString *)SolarTermTitle
{
    return solarTermTitle;
}

-(NSMutableArray *)Holiday
{
    return holiday;
}

-(bool)IsLeap
{
    return isLeap;
}

-(int)GregorianYear
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    int ret = [[formatter stringFromDate:thisdate] intValue];
    
    return ret;
}

-(int)GregorianMonth
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM"];
    int ret = [[formatter stringFromDate:thisdate] intValue];
    
    return ret;
}

-(int)GregorianDay
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd"];
    int ret = [[formatter stringFromDate:thisdate] intValue];
    return ret;
}

-(int)Weekday
{
    NSCalendar* cal = [NSCalendar currentCalendar];
    NSDateComponents* weekday = [cal components:NSCalendarUnitWeekday fromDate:thisdate];
    return (int)[weekday weekday];
}

//计算星座
-(NSString *)Constellation
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMdd"];
    int intConstellation = [[formatter stringFromDate:thisdate] intValue];
    
    if (intConstellation >= 120 && intConstellation <= 218)
        return @"水瓶座";
    else if (intConstellation >= 219 && intConstellation <= 320)
        return @"双鱼座";
    else if (intConstellation >= 321 && intConstellation <= 420)
        return @"白羊座";
    else if (intConstellation >= 421 && intConstellation <= 520)
        return @"金牛座";
    else if (intConstellation >= 521 && intConstellation <= 621)
        return @"双子座";
    else if (intConstellation >= 622 && intConstellation <= 722)
        return @"巨蟹座";
    else if (intConstellation >= 723 && intConstellation <= 822)
        return @"狮子座";
    else if (intConstellation >= 823 && intConstellation <= 922)
        return @"处女座";
    else if (intConstellation >= 923 && intConstellation <= 1022)
        return @"天秤座";
    else if (intConstellation >= 1023 && intConstellation <= 1121)
        return @"天蝎座";
    else if (intConstellation >= 1122 && intConstellation <= 1221)
        return @"射手座";
    else
        return @"摩羯座";
}

- (NSDate *)convertDate {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year = self.year;
    components.month = self.month;
    components.day = self.day;
    
    return [[NSCalendar currentCalendar] dateFromComponents:components];
}

@end

/********************************************************************************************************************************/
/********************************************************************************************************************************/
/********************************************************************************************************************************/
/********************************************************************************************************************************/
/********************************************************************************************************************************/
/********************************************************************************************************************************/
/********************************************************************************************************************************/
/********************************************************************************************************************************/
/********************************************************************************************************************************/
/********************************************************************************************************************************/
/********************************************************************************************************************************/
/********************************************************************************************************************************/
/********************************************************************************************************************************/
/********************************************************************************************************************************/
/********************************************************************************************************************************/
/********************************************************************************************************************************/
/********************************************************************************************************************************/
/********************************************************************************************************************************/
/********************************************************************************************************************************/
/********************************************************************************************************************************/
/********************************************************************************************************************************/
/********************************************************************************************************************************/
/********************************************************************************************************************************/
/********************************************************************************************************************************/

//方法获取农历数具包的方法
@implementation NSDate (chineseCalendarDate)

/****************************************************
 *@Description:获得NSDate对应的中国日历（农历）的NSDate
 *@Params:nil
 *@Return:NSDate对应的中国日历（农历）的LunarCalendar
 ****************************************************/
- (XLsn0w *)chineseCalendarDate {
    XLsn0w *lunarCalendar = [[XLsn0w alloc] init];
    [lunarCalendar loadWithDate:self];
    [lunarCalendar InitializeValue];
    return lunarCalendar;
}

@end

