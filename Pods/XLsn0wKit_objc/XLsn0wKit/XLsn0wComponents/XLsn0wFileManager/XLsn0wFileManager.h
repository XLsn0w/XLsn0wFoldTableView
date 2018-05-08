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

@interface XLsn0wFileManager : NSObject

+ (XLsn0wFileManager *)defaultManager;
/*****************************************************/

- (long long)fileSizeAtPath:(NSString *)path;

- (float)folderSizeAtPath:(NSString *)path;

- (BOOL)isCachesExistsAtPath:(NSString *)path;


- (NSString *)getLibraryCachesSize;

- (void)removeLibraryCachesWithBundleID:(NSString *)bundleID;

- (void)removeLibraryCaches;

- (void)removeAnyFilesAtPath:(NSString *)path;

@end
