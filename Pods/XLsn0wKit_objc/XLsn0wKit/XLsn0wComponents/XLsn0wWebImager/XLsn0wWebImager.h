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
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/*
 创建一个获取网络照片的管理类，只需要传入照片的网络地址，就可以请求成功缓存起来。
 发起网络请求之前先根据网址进行判断本地是否已经缓存了该图片。
 缓存中有的话从缓存取出，没有则利用 Session 请求获取该图片并缓存到本地。
 注意的是我们根据网址去判断，那么我们存储到沙盒缓存的文件名称要和网址字符串一一对应。
 这里不能直接用网址作为文件名称，所以我考虑把网址字符串用 MD5 转化后作为文件名称存储在缓存中。
*/

@class XLsn0wWebImager;

@protocol XLsn0wWebImagerDelegate <NSObject>

//当获取到UIImage数据的时候，代理对象执行这个方法
- (void)imageDownloader:(XLsn0wWebImager *)downloader didFinishedLoading:(UIImage *)image;

@end

typedef void(^ImageCacheBlock)(UIImage *downloadImage);

@interface XLsn0wWebImager : NSObject

//请求图片的类，获取到图片代理执行协议方法 或者 Block 传回请求下来的图片
#pragma mark-- 实例方法
- (instancetype)initWithImageUrlString:(NSString *)imageUrlStr
                              delegate:(id<XLsn0wWebImagerDelegate>)dele
                       successfulBlock:(ImageCacheBlock)returnImage;
#pragma mark-- 类方法
+ (instancetype)imageDownloaderWithImageUrlString:(NSString *)imageUrlStr
                                         delegate:(id<XLsn0wWebImagerDelegate>)dele
                                  successfulBlock:(ImageCacheBlock)returnImage;

// 单例创建
+ (instancetype)defaultWebImager;

- (void)downloadImageWithURLString:(NSString *)URLString
                     downloadImageCallback:(ImageCacheBlock)downloadImageCallback;

- (void)downloadImageWithURLString:(NSString *)URLString
                          delegate:(id<XLsn0wWebImagerDelegate>)delegate;

- (void)clearXLsn0wWebImagerPathImageCache;

@end
