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

#import "XLsn0wFileManager.h"

@interface XLsn0wCacher : NSObject

/*
 memory cache
 memoryCacheEnabled by default is YES
*/
@property (nonatomic, readonly, getter = isMemoryCacheEnabled) BOOL memoryCacheEnabled;

/*!
 * @author XLsn0w
 *
 * [XLsn0wCacher defaultCacher]
 */
+ (XLsn0wCacher *)defaultCacher;

+ (instancetype)sharedInstance;

- (void)setCacheInMemory:(BOOL)enabled;

- (UIImage *)imageByKey:(NSString *)key;

- (void)performWithImage:(UIImage *)image andKey:(NSString *)key;

- (NSData *)imageDataByKey:(NSString *)key;

- (void)performWithImageData:(NSData *)imgData andKey:(NSString *)key;


@end
