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

#import "XLsn0wFileHandle.h"

@implementation XLsn0wFileHandle

//将路径或者url转成base64处理的字符串
+ (NSString *)imageNameForBase64Handle:(NSString *)path {
    
    NSData * data = [path dataUsingEncoding:NSUTF8StringEncoding];//将路径通过UTF-8编码
    
    NSString * imageNameBase = [data base64EncodedStringWithOptions:0];//将字符串进行base64处理
    
    //iOS9.0之前进行重新编码
    return [imageNameBase stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}



//将路径或者url转成base64处理的字符串
+(NSString *)stringForBase64Handle:(NSString *)path
{
    NSData * data = [path dataUsingEncoding:NSUTF8StringEncoding];//将路径通过UTF-8编码
    
    NSString * imageNameBase = [data base64EncodedStringWithOptions:0];//将字符串进行base64处理
    
    //进行重新编码
    return [imageNameBase stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}


//获得应用的沙盒路径
+ (NSString *)documentPath {
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, true) firstObject];
}


//在沙盒目录下拼接路径
+(NSString *)documentAppendPath:(NSString *)fileName
{
    return [[[self class] documentPath] stringByAppendingPathComponent:fileName];
}



//在沙盒目录下拼接多级目录
+(NSString *)documentAppendPaths:(NSArray<NSString *> *)fileNames
{
    NSMutableString * path = [NSMutableString stringWithString:[[self class] documentPath]];
    
    //开始拼接
    for (NSString * fileName in fileNames)
    {
        [path appendFormat:@"/%@",fileName];
    }
    
    return [NSString stringWithString:path];
}


//获得当前存放下载图片的文件目录
+(NSString *)documentYWebImageFile {
    return [[self class] documentAppendPath:@"XLsn0wImageCache"];
}


//在当前存放下载图片的文件目录下拼接文件
+(NSString *)documentYWebImageFileAppendFile:(NSString *)fileName
{
    return [[[self class] documentYWebImageFile] stringByAppendingPathComponent:fileName];
}

//在当前存放下载图片的文件目录下拼接文件，文件名会进行base64转换
+(NSString *)documentYWebImageFileAppendBase64File:(NSString *)fileName
{
    
    if (__IPHONE_9_0)
    {
        return [[self class]documentYWebImageFileAppendFile:[[self class] stringForBase64Handle:fileName]];
    }
    
    return [[self class] documentYWebImageFileAppendFile:[[self class] imageNameForBase64Handle:fileName]];
}

@end
