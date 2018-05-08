
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (XL)

- (BOOL)hasString:(NSString * _Nonnull)substring;

- (BOOL)hasString:(NSString *_Nullable)substring
    caseSensitive:(BOOL)caseSensitive;

/**
 *  Returns a new string containing matching regular expressions replaced with the template string
 *
 *  @param regexString The regex string
 *  @param replacement The replacement string
 *
 *  @return Returns a new string containing matching regular expressions replaced with the template string
 */
- (NSString * _Nonnull)stringByReplacingWithRegex:(NSString * _Nonnull)regexString
                                       withString:(NSString * _Nonnull)replacement;

+ (NSString *_Nullable)xl_getMD5String32bitWithInputString:(NSString *_Nullable)string;

+ (NSString *_Nullable)xl_getMD5String16bitWithInputString:(NSString *_Nullable)string;

@end

@interface NSString (XLDate)

/**
 *  Get date info string from a date type object
 *
 *  @param date date type object
 *
 *  @return a date info string
 */
+ (NSString *_Nullable)xl_formatInfoFromDate:(NSDate *_Nullable)date;

/**
 *  Get sns date info string form date type object
 *
 *  @param date date type object
 *
 *  @return a date info string of sns
 */
+ (NSString *_Nullable)xl_formatDateFromDate:(NSDate *_Nullable)date;

@end

@interface NSString (XLPredicate)

/**
 *  check the string is email
 *
 *  @param input input string
 *
 *  @return true/false value
 */
+ (BOOL)xl_checkEmail:(NSString *_Nullable)input;

/**
 *  check the string is phone Number
 *
 *  @param input input string
 *
 *  @return true/false value
 */
+ (BOOL)xl_checkPhoneNumber:(NSString *_Nullable)input;

/**
 *  check the string is chinese name
 *
 *  @param input input string
 *
 *  @return true/false value
 */
+ (BOOL)xl_checkChineseName:(NSString *_Nullable)input;

/**
 *  check the string is valudate code
 *
 *  @param input input string
 *
 *  @return true/false value
 */
+ (BOOL)xl_checkValidateCode:(NSString *_Nullable)input;

/**
 *  check the string is strong password string
 *
 *  @param input input string
 *
 *  @return true/false value
 */
+ (BOOL)xl_checkPassword:(NSString *_Nullable)input;


/**
 *  check the string is mobile number
 *
 *  @param input input string
 *
 *  @return true/false value
 */
+ (BOOL)xl_checkMobileNumber:(NSString *_Nullable)input;

/**
 *  check the string is validate money
 *
 *  @param input input string
 *
 *  @return true/false value
 */
+ (BOOL)xl_checkWithDrawMoney:(NSString *_Nullable)input;

@end

@interface NSString (XLSubString)

/**
 *  Get substring from origin string with condition
 *
 *  @param bKey The begin key
 *  @param eKey The end key
 *
 *  @return The result string
 */
- (NSString *_Nullable)xl_getSubStringBeginKey:(NSString *_Nullable)bKey endKey:(NSString *_Nullable)eKey;

@end

@interface NSString (XLPrice)

+ (NSString *_Nullable)xl_formatPrice:(NSNumber *_Nullable)price;

@end

/*****************************************************************************/


#import <Foundation/Foundation.h>

@interface NSString (Extension)
/**
 *  md5加密
 */
+ (NSString*_Nullable)md5HexDigest:(NSString*_Nullable)inputStr;
/**
 *  根据文件名计算出文件大小
 */
- (unsigned long long)fileSize;
/**
 *  生成缓存目录全路径
 */
- (instancetype _Nullable )cacheDir;
/**
 *  生成文档目录全路径
 */
- (instancetype _Nullable )docDir;
/**
 *  生成临时目录全路径
 */
- (instancetype _Nullable )tmpDir;

/**
 *  @brief 根据字数的不同,返回UILabel中的text文字需要占用多少Size
 *  @param size 约束的尺寸
 *  @param font 文本字体
 *  @return 文本的实际尺寸
 */
- (CGSize)textSizeWithContentSize:(CGSize)size font:(UIFont *_Nullable)font;

/**
 *  @brief  根据文本字数/文本宽度约束/文本字体 求得text的Size
 *  @param width 宽度约束
 *  @param font  文本字体
 *  @return 文本的实际高度
 */
- (CGFloat)textHeightWithContentWidth:(CGFloat)width font:(UIFont *_Nullable)font;

/**
 *  @brief  根据文本字数/文本宽度约束/文本字体 求得text的Size
 *  @param height 宽度约束
 *  @param font  文本字体
 *  @return 文本的实际长度
 */
- (CGFloat)textWidthWithContentHeight:(CGFloat)height font:(UIFont *_Nullable)font;

@end

/********************************字符串转base64（包括DES加密）****************************************/

@interface NSString (Base64)

/************************************************************
 函数描述 : 将普通字符串转换为base64格式字符串
 输入参数 : (NSString *)普通字符串
 返回参数 : (NSString *)base64格式字符串
 **********************************************************/
+ (NSString *_Nullable)xl_getBase64StringWithInputString:(NSString *_Nullable)string;

/************************************************************
 函数描述 : 将base64格式字符串转换为普通字符串
 输入参数 : (NSString *)base64格式字符串
 返回参数 : (NSString *)字符串
 **********************************************************/
+ (NSString *_Nullable)xl_getStringWithInputBase64String:(NSString *_Nullable)base64String;

@end

