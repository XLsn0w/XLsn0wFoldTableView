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
 *  下载成功后的回调
 *
 *  @param path  下载成功在本地的路径
 */
typedef void(^DownManagerFinishBlock)(NSString * path);


/**
 *  下载过程中的回调
 *
 *  @param didFinish      本次下载的文件大小
 *  @param didFinishTotal 至此一共下载文件的大小
 *  @param Total          一共需要下载文件的大小
 */
typedef void(^DownManagerProgressBlock)(CGFloat didFinish,CGFloat didFinishTotal,CGFloat Total);




NS_CLASS_AVAILABLE_IOS(7_0) @interface XLsn0wFileDownload : NSObject

//开始下载图片，如果存在文件，自动续点下载
- (void)startDownImagePath:(NSString *)imagePath NS_AVAILABLE_IOS(7_0);
- (void)startDownImageURL:(NSURL *)imageURL NS_AVAILABLE_IOS(7_0);



//设置相关回调
- (void)downManagerFinishBlockHandle:(DownManagerFinishBlock)downManagerFinishBlockHandle;
- (void)downManagerProgressBlockHandle:(DownManagerProgressBlock)downManagerProgressBlockHandle;

@end
