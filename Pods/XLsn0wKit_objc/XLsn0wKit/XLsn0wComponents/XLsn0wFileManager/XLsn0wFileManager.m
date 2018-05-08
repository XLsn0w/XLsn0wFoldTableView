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

#import "XLsn0wFileManager.h"

#define CachesDirectory    ([NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject])
#define DocumentDirectory  ([NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject])
#define BundleID           ([[NSBundle mainBundle] bundleIdentifier])

@implementation XLsn0wFileManager

/*!
 * @author XLsn0w
 *
 * Create Singleton
 */
static XLsn0wFileManager *xlsn0wFileManager = nil;
+ (XLsn0wFileManager *)defaultManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        xlsn0wFileManager = [[self alloc] init];
    });
    return xlsn0wFileManager;
}

//判断文件是否已经在沙盒中已经存在？
- (BOOL)isCachesExistsAtPath:(NSString *)path {
    
    NSString *cachesDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];

    BOOL isCachesExists = [[NSFileManager defaultManager] fileExistsAtPath:[cachesDirectory stringByAppendingPathComponent:path]];

    NSLog(@"这个文件已经存在：%@", isCachesExists? @"是的" : @"不存在");

    return isCachesExists;
}

- (BOOL)isDocumentExistsAtPath:(NSString *)path {

    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    BOOL isDocumentExists = [[NSFileManager defaultManager] fileExistsAtPath:[documentDirectory stringByAppendingPathComponent:path]];

    NSLog(@"这个文件已经存在：%@",isDocumentExists?@"是的":@"不存在");
    
    return isDocumentExists;
}

- (void)removeAnyFilesAtPath:(NSString *)path {
    if([[NSFileManager defaultManager] fileExistsAtPath:path] == true) {
        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    } else {
        NSLog(@"文件不存在!");
    }
}

- (void)removeLibraryCachesWithBundleID:(NSString *)bundleID {

    NSString *bundlePath = [CachesDirectory stringByAppendingPathComponent:bundleID];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:bundlePath] == true) {
        [[NSFileManager defaultManager] removeItemAtPath:bundlePath error:nil];
    } else {
        NSLog(@"文件不存在!");
    }
}

- (void)removeLibraryCaches {
    if([[NSFileManager defaultManager] fileExistsAtPath:CachesDirectory] == true) {
        [[NSFileManager defaultManager] removeItemAtPath:CachesDirectory error:nil];
    } else {
        NSLog(@"文件不存在!");
    }
}

/*!
 * @author XLsn0w
 *
 * 单个文件大小的计算
 */
- (long long)fileSizeAtPath:(NSString *)path {
    
    if([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        
        long long size = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil].fileSize;
        
        return size;
    }
    return 0;
}

/*!
 * @author XLsn0w
 *
 * 文件夹大小的计算
 */
- (float)folderSizeAtPath:(NSString *)path {
    NSFileManager *fileManager=[NSFileManager defaultManager];
    NSString *cachePath=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    cachePath=[cachePath stringByAppendingPathComponent:path];
    long long folderSize=0;
    if ([fileManager fileExistsAtPath:cachePath])
    {
        NSArray *childerFiles=[fileManager subpathsAtPath:cachePath];
        for (NSString *fileName in childerFiles)
        {
            NSString *fileAbsolutePath=[cachePath stringByAppendingPathComponent:fileName];
            long long size=[self fileSizeAtPath:fileAbsolutePath];
            folderSize += size;
            NSLog(@"fileAbsolutePath=%@",fileAbsolutePath);
            
        }

        
    }
    return 0;
}

//同样也是利用NSFileManager API进行文件操作，SDWebImage框架自己实现了清理缓存操作，我们可以直接调用。
- (void)clearCache:(NSString *)path {
    
    NSString *cachePath=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    
    cachePath = [cachePath stringByAppendingPathComponent:path];
    
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:cachePath]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:cachePath];
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            NSString *fileAbsolutePath=[cachePath stringByAppendingPathComponent:fileName];
            NSLog(@"fileAbsolutePath=%@",fileAbsolutePath);
            [fileManager removeItemAtPath:fileAbsolutePath error:nil];
        }
    }

}


//获取缓存文件路径
- (NSString *)getLibraryCachesBundleIDPath {
    // 获取Caches目录路径
    NSString *cachesDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *bundleIDPath = [cachesDirectory stringByAppendingPathComponent:BundleID];
    
    return bundleIDPath;
}

///计算缓存文件的大小的M
- (long long)fileSizeAtFilePath:(NSString*)filePath{
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]){
        
        //        //取得一个目录下得所有文件名
        //        NSArray *files = [manager subpathsAtPath:filePath];
        //        NSLog(@"files1111111%@ == %ld",files,files.count);
        //
        //        // 从路径中获得完整的文件名（带后缀）
        //        NSString *exe = [filePath lastPathComponent];
        //        NSLog(@"exeexe ====%@",exe);
        //
        //        // 获得文件名（不带后缀）
        //        exe = [exe stringByDeletingPathExtension];
        //
        //        // 获得文件名（不带后缀）
        //        NSString *exestr = [[files objectAtIndex:1] stringByDeletingPathExtension];
        //        NSLog(@"files2222222%@  ==== %@",[files objectAtIndex:1],exestr);
        
        
        return [[[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    
    return 0;
}

- (float)folderSizeAtFolderPath:(NSString*)folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];//从前向后枚举器／／／／//
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSLog(@"fileName ==== %@",fileName);
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        NSLog(@"fileAbsolutePath ==== %@",fileAbsolutePath);
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    NSLog(@"folderSize ==== %lld",folderSize);
    return folderSize/(1024.0*1024.0);
}


- (void)getBundleIDCaches {
    // 获取Caches目录路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDir = [paths objectAtIndex:0];
    
   
    
    //读取缓存里面的具体单个文件/或全部文件//
    NSString *filePath = [cachesDir stringByAppendingPathComponent:BundleID];
//    NSArray *array = [[NSArray alloc]initWithContentsOfFile:filePath];
 
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath]){
       
        //取得一个目录下得所有文件名
        NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:filePath];
        
        // 获得文件名（不带后缀）
        NSString * exestr = [[files objectAtIndex:1] stringByDeletingPathExtension];
        NSLog(@"files2222222%@  ==== %@",[files objectAtIndex:1],exestr);
    }
    
}

#pragma mark - 计算Library/Caches缓存大小
- (NSString *)getLibraryCachesSize {
         //定义变量存储总的缓存大小
         long long sumSize = 0;
    
         //01.获取当前图片缓存路径
         NSString *cacheFilePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"];
    
         //02.创建文件管理对象
         NSFileManager *filemanager = [NSFileManager defaultManager];
    
             //获取当前缓存路径下的所有子路径
         NSArray *subPaths = [filemanager subpathsOfDirectoryAtPath:cacheFilePath error:nil];
    
             //遍历所有子文件
         for (NSString *subPath in subPaths) {
                     //1）.拼接完整路径
                 NSString *filePath = [cacheFilePath stringByAppendingFormat:@"/%@",subPath];
                     //2）.计算文件的大小
                 long long fileSize = [[filemanager attributesOfItemAtPath:filePath error:nil]fileSize];
                     //3）.加载到文件的大小
                 sumSize += fileSize;
             }
         float size_m = sumSize/(1000*1000);
    
    return [NSString stringWithFormat:@"%.2fM",size_m];
    
}

@end
