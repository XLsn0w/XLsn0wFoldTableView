
#import "NSString+XL.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (XL)

- (BOOL)hasString:(NSString * _Nonnull)substring {
    return [self hasString:substring caseSensitive:YES];
}

- (BOOL)hasString:(NSString *)substring caseSensitive:(BOOL)caseSensitive {
    if (caseSensitive) {
        return [self rangeOfString:substring].location != NSNotFound;
    } else {
        return [self.lowercaseString rangeOfString:substring.lowercaseString].location != NSNotFound;
    }
}


- (NSString * _Nonnull)stringByReplacingWithRegex:(NSString * _Nonnull)regexString withString:(NSString * _Nonnull)replacement {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexString options:NSRegularExpressionCaseInsensitive error:nil];
    return [regex stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, [self length]) withTemplate:@""];
}

/** 得到一串32位 MD5加密字符串 */
+ (NSString *)xl_getMD5String32bitWithInputString:(NSString *)string {
    //要进行UTF8的转码
    const char *input = [string UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *md5String32bit = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [md5String32bit appendFormat:@"%02x", result[i]];
    }
    
    return md5String32bit;
}

+ (NSString *)xl_getMD5String16bitWithInputString:(NSString *)string {
    const char *input = [string UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *md5String32bit = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [md5String32bit appendFormat:@"%02x", result[i]];
    }
    
    NSString  *md5String16bit = [NSString string];
    for (int i=0; i<24; i++) {
        md5String16bit = [md5String32bit substringWithRange:NSMakeRange(8, 16)];
    }
    return md5String16bit;
}

@end

@implementation NSString (XLDate)

+ (NSString *)xl_formatInfoFromDate:(NSDate *)date {
    NSString *returnString = @"";
    NSTimeInterval time = fabs([[NSDate date] timeIntervalSinceDate:date]);
    if(time < 60)
        returnString = @"刚刚";
    else if(time >=60 && time < 3600)
        returnString = [NSString stringWithFormat:@"%.0f分钟前",time/60];
    else if(time >= 3600 && time < 3600 * 24)
        returnString = [NSString stringWithFormat:@"%.0f小时前",time/(60 * 60)];
    else if(time >= 3600 * 24 && time < 3600 * 24 * 30)
        returnString = [NSString stringWithFormat:@"%.0f天前",time/(60 * 60 * 24)];
    else if(time >= 3600 * 24 * 30 && time < 3600 * 24 * 30 * 12)
        returnString = [NSString stringWithFormat:@"%.0f月前",time/(60 * 60 * 24 * 30)];
    else if(time >= 3600 * 24 * 30 * 12)
        returnString = [NSString stringWithFormat:@"%.0f年前",time/(60 * 60 * 24 * 30 * 12)];
    return returnString;
}

+ (NSString *)xl_formatDateFromDate:(NSDate *)date {
    NSString *returnString = @"";
    NSTimeInterval time = fabs([[NSDate date] timeIntervalSinceDate:date]);
    if(time < 60)
        returnString = @"刚刚";
    else if(time >=60 && time < 3600)
        returnString = [NSString stringWithFormat:@"%.0f分钟前",time/60];
    else if(time >= 3600 && time < 3600 * 24)
        returnString = [NSString stringWithFormat:@"%.0f小时前",time/(60 * 60)];
    else if(time >= 3600 * 24 && time < 3600 * 24 * 3)
        returnString = [NSString stringWithFormat:@"%.0f天前",time/(60 * 60 * 24)];
    else {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd";
        returnString = [formatter stringFromDate:date];
    }
    return returnString;
}


@end

@implementation NSString (XLPredicate)

+ (BOOL)xl_checkEmail:(NSString *)input {
    return [[self class] input:input andRegex:@"\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*"];
}

+ (BOOL)xl_checkChineseName:(NSString *)input {
    return [[self class] input:input andRegex:@"^[\u4E00-\uFA29]{2,8}$"];
}

+ (BOOL)xl_checkPhoneNumber:(NSString *)input {
    return [[self class] input:input andRegex:@"^(([0\\+]\\d{2,3}-?)?(0\\d{2,3})-?)?(\\d{7,8})"];
}

+ (BOOL)xl_checkMobileNumber:(NSString *)input {
    return [[self class] input:input andRegex:@"^1\\d{10}$"];
}

+ (BOOL)xl_checkValidateCode:(NSString *)input {
    return [[self class] input:input andRegex:@"(\\d{6})"];
}

+ (BOOL)xl_checkPassword:(NSString *)input {
    return [[self class] input:input andRegex:@"^\\w{6,20}"];
}

+ (BOOL)xl_checkWithDrawMoney:(NSString *)input {
    return [[self class] input:input andRegex:@"^[0-9]{3,}|[2-9][0-9]$"];
}

+ (BOOL)input:(NSString *)input andRegex:(NSString *)regex {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:input];
}

@end

@implementation NSString (XLSubString)

- (NSString *)xl_getSubStringBeginKey:(NSString *)bKey endKey:(NSString *)eKey {
    if(bKey && eKey){
        NSRange rangeBegin = [self rangeOfString:bKey];
        NSRange rangeEnd = [self rangeOfString:eKey];
        if(rangeBegin.length > 0 && rangeEnd.length > 0){
            NSRange resultRange = NSMakeRange(rangeBegin.location+rangeBegin.length, rangeEnd.location - rangeBegin.location - rangeBegin.length);
            NSString *subString = [self substringWithRange:resultRange];
            return subString;
        }
        return nil;
    }else if(bKey && !eKey && [self rangeOfString:bKey].length > 0){
        NSRange rangeBegin = [self rangeOfString:bKey];
        return [self substringFromIndex:rangeBegin.location + rangeBegin.length];
    }else if(!bKey && eKey && [self rangeOfString:eKey].length > 0){
        NSRange rangeEnd = [self rangeOfString:eKey];
        return [self substringToIndex:rangeEnd.location + rangeEnd.length];
    }else{
        return nil;
    }
}

@end

@implementation NSString (XLPrice)

+ (NSString *)xl_formatPrice:(NSNumber *)price {
    price = @(price.floatValue);
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    return [NSString stringWithFormat:@"￥%@",[formatter stringFromNumber:price]];
}

@end



#import <objc/runtime.h>
#import <CommonCrypto/CommonDigest.h>

/*CC_MD5_DIGEST_LENGTH*/

#define  MD5_LENGTH   32
@implementation NSString (Extension)

+ (NSString*)md5HexDigest:(NSString*)inputStr {
    const char * str = [inputStr UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), result);
    
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}

- (unsigned long long)fileSize {
    // 计算self这个文件夹\文件的大小
    
    // 文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    // 文件类型
    NSDictionary *attrs = [mgr attributesOfItemAtPath:self error:nil];
    NSString *fileType = attrs.fileType;
    
    if ([fileType isEqualToString:NSFileTypeDirectory]) { // 文件夹
        // 获得文件夹的遍历器
        NSDirectoryEnumerator *enumerator = [mgr enumeratorAtPath:self];
        
        // 总大小
        unsigned long long fileSize = 0;
        
        // 遍历所有子路径
        for (NSString *subpath in enumerator) {
            // 获得子路径的全路径
            NSString *fullSubpath = [self stringByAppendingPathComponent:subpath];
            fileSize += [mgr attributesOfItemAtPath:fullSubpath error:nil].fileSize;
        }
        
        return fileSize;
    }
    
    // 文件
    return attrs.fileSize;
}

//- (unsigned long long)lx_fileSize
//{
//    // 计算self这个文件夹\文件的大小
//
//    // 文件管理者
//    NSFileManager *mgr = [NSFileManager defaultManager];
//
//    // 文件类型
//    BOOL isDirectory = NO;
//    BOOL exists = [mgr fileExistsAtPath:self isDirectory:&isDirectory];
//    if (!exists) return 0;
//
//    if (isDirectory) { // 文件夹
//        // 获得文件夹的遍历器
//        NSDirectoryEnumerator *enumerator = [mgr enumeratorAtPath:self];
//
//        // 总大小
//        unsigned long long fileSize = 0;
//
//        // 遍历所有子路径
//        for (NSString *subpath in enumerator) {
//            // 获得子路径的全路径
//            NSString *fullSubpath = [self stringByAppendingPathComponent:subpath];
//            fileSize += [mgr attributesOfItemAtPath:fullSubpath error:nil].fileSize;
//        }
//
//        return fileSize;
//    }
//
//    // 文件
//    return [mgr attributesOfItemAtPath:self error:nil].fileSize;
//}
- (instancetype)cacheDir
{
    NSString *dir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    return [dir stringByAppendingPathComponent:[self lastPathComponent]];
}
- (instancetype)docDir
{
    NSString *dir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    return [dir stringByAppendingPathComponent:[self lastPathComponent]];
}

- (instancetype)tmpDir
{
    NSString *dir = NSTemporaryDirectory();
    return [dir stringByAppendingPathComponent:[self lastPathComponent]];
}

- (CGSize)textSizeWithContentSize:(CGSize)size font:(UIFont *)font {
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size;
}

- (CGFloat)textHeightWithContentWidth:(CGFloat)width font:(UIFont *)font {
    CGSize size = CGSizeMake(width, MAXFLOAT);
    return [self textSizeWithContentSize:size font:font].height;
}

- (CGFloat)textWidthWithContentHeight:(CGFloat)height font:(UIFont *)font {
    CGSize size = CGSizeMake(MAXFLOAT, height);
    return [self textSizeWithContentSize:size font:font].width;
}

@end

/**************************************************************************************************/

//引入iOS自带密码库
#import <CommonCrypto/CommonCryptor.h>

static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

@implementation NSString (Base64)

+ (NSString *)xl_getBase64StringWithInputString:(NSString *)string {
    if (string && ![string isEqualToString:@""]) {
        //取项目的bundleIdentifier作为KEY
        NSString *keyString = [[NSBundle mainBundle] bundleIdentifier];
        NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
        //IOS 自带DES加密 Begin
        data = [self DESEncrypt:data keyString:keyString];
        //IOS 自带DES加密 End
        return [self base64EncodedStringFrom:data];
    } else {
        return @"";
    }
}

+ (NSString *)xl_getStringWithInputBase64String:(NSString *)base64String {
    if (base64String && ![base64String isEqualToString:@""]) {
        //取项目的bundleIdentifier作为KEY
        NSString *keyString = [[NSBundle mainBundle] bundleIdentifier];
        NSData *data = [self dataWithBase64EncodedString:base64String];
        //IOS 自带DES解密 Begin
        data = [self DESDecrypt:data keyString:keyString];
        //IOS 自带DES加密 End
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    } else {
        return @"";
    }
}

/*************************DES Encrypt**********************************/

+ (NSData *)DESEncrypt:(NSData *)data keyString:(NSString *)keyString {
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [keyString getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeDES,
                                          NULL,
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    
    free(buffer);
    return nil;
}

/*******************DES Encrypt***************************************/

+ (NSData *)DESDecrypt:(NSData *)data keyString:(NSString *)keyString {
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [keyString getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeDES,
                                          NULL,
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    
    free(buffer);
    return nil;
}

+ (NSData *)dataWithBase64EncodedString:(NSString *)string {
    if (string == nil)
        [NSException raise:NSInvalidArgumentException format:@""];
    if ([string length] == 0)
        return [NSData data];
    
    static char *decodingTable = NULL;
    if (decodingTable == NULL)
    {
        decodingTable = malloc(256);
        if (decodingTable == NULL)
            return nil;
        memset(decodingTable, CHAR_MAX, 256);
        NSUInteger i;
        for (i = 0; i < 64; i++)
            decodingTable[(short)encodingTable[i]] = i;
    }
    
    const char *characters = [string cStringUsingEncoding:NSASCIIStringEncoding];
    if (characters == NULL)     //  Not an ASCII string!
        return nil;
    char *bytes = malloc((([string length] + 3) / 4) * 3);
    if (bytes == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (YES)
    {
        char buffer[4];
        short bufferLength;
        for (bufferLength = 0; bufferLength < 4; i++)
        {
            if (characters[i] == '\0')
                break;
            if (isspace(characters[i]) || characters[i] == '=')
                continue;
            buffer[bufferLength] = decodingTable[(short)characters[i]];
            if (buffer[bufferLength++] == CHAR_MAX)      //  Illegal character!
            {
                free(bytes);
                return nil;
            }
        }
        
        if (bufferLength == 0)
            break;
        if (bufferLength == 1)      //  At least two characters are needed to produce one byte!
        {
            free(bytes);
            return nil;
        }
        
        //  Decode the characters in the buffer to bytes.
        bytes[length++] = (buffer[0] << 2) | (buffer[1] >> 4);
        if (bufferLength > 2)
            bytes[length++] = (buffer[1] << 4) | (buffer[2] >> 2);
        if (bufferLength > 3)
            bytes[length++] = (buffer[2] << 6) | buffer[3];
    }
    
    bytes = realloc(bytes, length);
    return [NSData dataWithBytesNoCopy:bytes length:length];
}

+ (NSString *)base64EncodedStringFrom:(NSData *)data {
    if ([data length] == 0)
        return @"";
    
    char *characters = malloc((([data length] + 2) / 3) * 4);
    if (characters == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (i < [data length])
    {
        char buffer[3] = {0,0,0};
        short bufferLength = 0;
        while (bufferLength < 3 && i < [data length])
            buffer[bufferLength++] = ((char *)[data bytes])[i++];
        
        //  Encode the bytes in the buffer to four characters, including padding "=" characters if necessary.
        characters[length++] = encodingTable[(buffer[0] & 0xFC) >> 2];
        characters[length++] = encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
        if (bufferLength > 1)
            characters[length++] = encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
        else characters[length++] = '=';
        if (bufferLength > 2)
            characters[length++] = encodingTable[buffer[2] & 0x3F];
        else characters[length++] = '=';
    }
    
    return [[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES];
}

@end
