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

/**
 *  删除过程的回调
 *
 *  @param fileName 删除的文件名字
 */
typedef void(^YWebManagerDeleteFileBlock)(NSString * fileName);


/**
 *  操作完成的无参数回调
 */
typedef void(^YWebManagerCompleteBlock)(void);


/**
 *  负责处理本地文件(沙盒存储)的管理者
 */
@interface XLsn0wImageCache : NSObject


/**
 *  默认存储文件夹的大小,单位为MB
 */
@property (nonatomic, copy, readonly) NSString *fileSize;



/**
 *  单例方法
 *
 *  @return 单例对象
 */
+ (instancetype)sharedImageCache;


/**
 *  在沙盒中目录中默认存储的文件夹中是否存在该文件
 *
 *  @param url 图片存在的url
 *
 *  @return true表示存在，false表示不存在
 */
- (BOOL)fileIsExist:(NSString *)url;


/**
 *  创建下载缓存的文件夹
 *
 *  @return true表示创建成功，false表示创建失败
 */
- (BOOL)createDownFile;


/**
 *  根据url获取存在本地的图片
 *
 *  @param url 下载的url
 *
 *  @return 存在的返回UIImage,不存在返回nil
 */
- (UIImage *)imageWithURL:(NSString *)url NS_AVAILABLE_IOS(7_0);

#pragma mark - 删除缓存文件的方法

/**
 *  删除所有的缓存在本地的文件
 *
 *  @return true为删除成功，false为失败
 */
- (BOOL)deleteAllCaches NS_AVAILABLE_IOS(7_0);


/**
 *  删除所有的缓存在本地的文件
 *
 *  @param deleteProgressBlockHandle 删除过程的回调
 *  @param completeBlockHandle       完成后的回调
 *
 *  @return true为删除成功，fasle为失败
 */
- (BOOL)deleteAllCAchesProgress:(YWebManagerDeleteFileBlock)deleteProgressBlockHandle
                       Complete:(YWebManagerCompleteBlock)completeBlockHandle NS_AVAILABLE_IOS(7_0);


@end
