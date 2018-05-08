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

NS_AVAILABLE_IOS(7_0) @interface XLsn0wFileHandle : NSObject

/**
 *  将路径或者url转成base64处理的字符串
 *
 *  @param path 需要处理的字符串
 *
 *  @return 处理完毕的字符串
 */
+ (NSString *)imageNameForBase64Handle:(NSString *)path NS_DEPRECATED_IOS(7.0, 9.0,"Use - stringForBase64Handle: instead.");



/**
 *  将路径或者url字符串转成base64处理的字符串
 *
 *  @param path 需要处理的字符串
 *
 *  @return 处理完毕的字符串
 */
+ (NSString *)stringForBase64Handle:(NSString *)path NS_AVAILABLE_IOS(9_0);



/**
 *  获得应用的沙盒路径
 *
 *  @return 沙盒路径
 */
+ (NSString *)documentPath NS_AVAILABLE_IOS(7_0);



/**
 *  在沙盒目录下拼接路径
 *
 *  @param fileName 拼接的文件名
 *
 *  @return 拼接好的沙盒目录
 */
+ (NSString *)documentAppendPath:(NSString *)fileName NS_AVAILABLE_IOS(7_0);




/**
 *  在沙盒目录下拼接多级目录
 *
 *  @param fileNames 存放多级目录的数组
 *
 *  @return 拼接好的沙盒目录
 */
+ (NSString *)documentAppendPaths:(NSArray <NSString *> *)fileNames NS_AVAILABLE_IOS(7_0);






/**
 *  获得当前存放下载图片的文件目录
 *
 *  @return 存放图片的沙盒目录
 */
+ (NSString *)documentYWebImageFile NS_AVAILABLE_IOS(7_0);


/**
 *  在当前存放下载图片的文件目录下拼接文件
 *
 *  @param fileName 需要拼接的文件名
 *
 *  @return 拼接完毕后的沙盒目录
 */
+ (NSString *)documentYWebImageFileAppendFile:(NSString *)fileName NS_AVAILABLE_IOS(7_0);


/**
 *  在当前存放下载图片的文件目录下拼接文件，文件名会进行base64转换
 *
 *  @param fileName 需要拼接的文件名
 *
 *  @return 拼接完毕后的沙盒目录
 */
+ (NSString *)documentYWebImageFileAppendBase64File:(NSString *)fileName NS_AVAILABLE_IOS(7_0);

@end
