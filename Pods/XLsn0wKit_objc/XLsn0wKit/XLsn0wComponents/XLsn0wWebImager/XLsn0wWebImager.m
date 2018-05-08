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
#import "XLsn0wWebImager.h"
#import <CommonCrypto/CommonCrypto.h>//MD5

@implementation XLsn0wWebImager

// 单例创建方法
+ (instancetype)defaultWebImager {
    static XLsn0wWebImager *managar = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        managar = [XLsn0wWebImager new];
    });
    return managar;
}

// 请求的网络照片  并存进本地缓存
+ (instancetype)imageDownloaderWithImageUrlString:(NSString *)imageUrlStr
                                         delegate:(id<XLsn0wWebImagerDelegate>)dele
                                  successfulBlock:(ImageCacheBlock)returnImage {

    [[XLsn0wWebImager defaultWebImager] downloadImageWithURLString:imageUrlStr
                                                          delegate:dele
                                                     downloadImage:returnImage];
    return [XLsn0wWebImager defaultWebImager];
}
// 请求的网络照片  并存进本地缓存
- (instancetype)initWithImageUrlString:(NSString *)imageUrlStr delegate:(id<XLsn0wWebImagerDelegate>)dele successfulBlock:(ImageCacheBlock)returnImage {
    [[XLsn0wWebImager defaultWebImager] downloadImageWithURLString:imageUrlStr delegate:dele downloadImage:returnImage];
    
    return self;
}

// 获取照片  缓存有的话就从  缓存中去取到  否则网络请求
- (void)downloadImageWithURLString:(NSString *)URLString delegate:(id<XLsn0wWebImagerDelegate>)delegate downloadImage:(ImageCacheBlock)downloadImage {
    UIImage *image = [self getImageFromSubPath:URLString];
    if (image) {
        // 6.代理执行协议中的方法，将图片作为参数传过去
        dispatch_async(dispatch_get_main_queue(), ^{
            
            delegate != nil ? [delegate imageDownloader:self didFinishedLoading:image] : nil;
            // 6.用Block回调传递数据
            downloadImage != nil ? downloadImage(image) : nil ;
        });
    }else {
        __weak typeof(XLsn0wWebImager) *downloader = self;
        //1.准备url对象
        NSURL * url = [NSURL URLWithString:URLString];
        //2.创建request请求对象
        NSURLRequest * request = [NSURLRequest requestWithURL:url];
        //3.创建会话
        NSURLSession *session = [NSURLSession sharedSession];
        //4.创建请求任务
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            // 获取数据写入本地
            UIImage *image = nil;
            if (!data)
            {
                image = [UIImage imageNamed:@"LoopImg.bundle/占位"];
                
            }else
            {
                //5.将图片传值
                image = [UIImage imageWithData:data];
                [self writToCacheWithData:UIImageJPEGRepresentation(image, 1) subPath:URLString];
            }
            //6.代理执行协议中的方法，将图片作为参数传过去
            dispatch_async(dispatch_get_main_queue(), ^{
                
                delegate != nil ? [delegate imageDownloader:downloader didFinishedLoading:image] : nil;
                // 6.用Block回调传递数据
                downloadImage != nil ? downloadImage(image) : nil ;
            });
        }];
        //执行任务
        [task resume];
    }
}

// 获取照片  缓存有的话就从  缓存中去取到  否则网络请求
- (void)downloadImageWithURLString:(NSString *)URLString delegate:(id<XLsn0wWebImagerDelegate>)delegate {
    UIImage *image = [self getImageFromSubPath:URLString];
    if (image) {
        // 6.代理执行协议中的方法，将图片作为参数传过去
        dispatch_async(dispatch_get_main_queue(), ^{
            delegate != nil ? [delegate imageDownloader:self didFinishedLoading:image] : nil;
        });
    }else {
        __weak typeof(XLsn0wWebImager) *downloader = self;
        //1.准备url对象
        NSURL * url = [NSURL URLWithString:URLString];
        //2.创建request请求对象
        NSURLRequest * request = [NSURLRequest requestWithURL:url];
        //3.创建会话
        NSURLSession *session = [NSURLSession sharedSession];
        //4.创建请求任务
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            // 获取数据写入本地
            UIImage *image = nil;
            if (!data)
            {
                image = [UIImage imageNamed:@"LoopImg.bundle/占位"];
                
            }else
            {
                //5.将图片传值
                image = [UIImage imageWithData:data];
                [self writToCacheWithData:UIImageJPEGRepresentation(image, 1) subPath:URLString];
            }
            //6.代理执行协议中的方法，将图片作为参数传过去
            dispatch_async(dispatch_get_main_queue(), ^{
                delegate != nil ? [delegate imageDownloader:downloader didFinishedLoading:image] : nil;
            });
        }];
        //执行任务
        [task resume];
    }
}

// 获取照片  缓存有的话就从  缓存中去取到  否则网络请求
- (void)downloadImageWithURLString:(NSString *)URLString
                     downloadImageCallback:(ImageCacheBlock)downloadImageCallback {
    UIImage *image = [self getImageFromSubPath:URLString];
    if (image) {//缓存中有, 直接取出, 不再网络下载
        dispatch_async(dispatch_get_main_queue(), ^{
            downloadImageCallback != nil ? downloadImageCallback(image) : nil;
        });
    } else {//缓存中没有, 则网络下载

        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URLString]];

        NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            UIImage *downloadImage = nil;
            if (data) {
                downloadImage = [UIImage imageWithData:data];
                [self writToCacheWithData:UIImageJPEGRepresentation(downloadImage, 1) subPath:URLString];
            } else {
                downloadImage = [UIImage imageNamed:@""];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                downloadImageCallback != nil ? downloadImageCallback(downloadImage) : nil ;
            });
        }];

        [task resume];
    }
}

// 创建缓存文件夹
- (NSString *)getXLsn0wWebImagerPath {
    NSString *DocumentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *XLsn0wWebImagerPath = [DocumentPath stringByAppendingPathComponent:@"XLsn0wWebImager"];
    if(![[NSFileManager defaultManager] fileExistsAtPath:XLsn0wWebImagerPath]) {// 是否存在文件 没有就创建
        NSError *createError = nil;
        [[NSFileManager defaultManager] createDirectoryAtPath:XLsn0wWebImagerPath withIntermediateDirectories:YES attributes:nil error:&createError];
        if (createError != nil) {
            NSLog(@"%@", createError);
        }
    }
    return XLsn0wWebImagerPath;
}

// 缓存到本地文件夹
- (void)writToCacheWithData:(NSData *)data subPath:(NSString *)subPath {
    // 直接写入本地
    subPath = [self convertToMD5StringWithURLString:subPath];
    [data writeToFile:[[self getXLsn0wWebImagerPath] stringByAppendingPathComponent:subPath] atomically:YES];
}
// 清除缓存的照片
- (void)clearXLsn0wWebImagerPathImageCache {
    NSError *removeError = nil;
    [[NSFileManager defaultManager] removeItemAtPath:[self getXLsn0wWebImagerPath] error:&removeError];
    if (removeError != nil) {
        NSLog(@"%@", removeError);
    }
}

// 获取图片从本地
- (UIImage *)getImageFromSubPath:(NSString *)subPath {
    subPath = [self convertToMD5StringWithURLString:subPath];
    NSData *data = [NSData dataWithContentsOfFile:[[self getXLsn0wWebImagerPath] stringByAppendingPathComponent:subPath]];
    return [UIImage imageWithData:data];
}

// 把字符串转化成 MD5字符串 去掉特殊的标记
- (NSString *)convertToMD5StringWithURLString:(NSString *)URLString {
    // 转成 C 语言的字符串
    const char *mdData = [URLString UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(mdData, (CC_LONG)strlen(mdData), result);
    
    // 化成 OC 不可变 字符串
    NSMutableString *MD5String  = [NSMutableString new];
    for (int i =0 ; i < CC_MD5_DIGEST_LENGTH; i++) {
        [MD5String appendFormat:@"%02X",result[i]];
    }
    return MD5String;
}

@end
