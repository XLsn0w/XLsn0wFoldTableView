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

#import "XLsn0wImageCache.h"

#import "XLsn0wFileHandle.h"

@interface XLsn0wImageCache ()

@property (nonatomic, strong) NSFileManager * fileManager; //文件管理者的单例

@end

@implementation XLsn0wImageCache

+ (instancetype)sharedImageCache {
    
    static XLsn0wImageCache *xlsn0wImageCache = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //初始化单例对象
        xlsn0wImageCache = [[XLsn0wImageCache alloc] init];
        
    });
    
    return xlsn0wImageCache;
}


//文件夹是否在沙盒存在
- (BOOL)folderIsExist:(NSString *)folderPath
{
    return [self.fileManager fileExistsAtPath:folderPath];
}



//沙盒目录中默认存储文件夹中是否存在这个文件
- (BOOL)fileIsExist:(NSString *)url
{

    //拼接路径
    NSString * path = [XLsn0wFileHandle documentYWebImageFileAppendBase64File:url];
    
    return [self.fileManager fileExistsAtPath:path];
}




//根据保存的路径获取图片对象
-(UIImage *)imageWithURL:(NSString *)url
{
    //不存在图片返回nil
    if (![self fileIsExist:url])
    {
        return nil;
    }
    
    //拼接路径
    NSString * path = [XLsn0wFileHandle documentYWebImageFileAppendBase64File:url];
    
    //存在图片返回图片
    return [UIImage  imageWithContentsOfFile:path];
}



//删除所有的缓存
-(BOOL)deleteAllCaches
{
    return [self deleteAllCAchesProgress:^(NSString *fileName) {} Complete:^{}];
}


//带过程回调的删除所有缓存
-(BOOL)deleteAllCAchesProgress:(YWebManagerDeleteFileBlock)deleteProgressBlockHandle
                      Complete:(YWebManagerCompleteBlock)completeBlockHandle
{
    //获得存储位置的路径字符串
    NSString * path = [XLsn0wFileHandle documentYWebImageFile];
    
    //判断缓存文件夹存在不存在
    if (![self folderIsExist:path])
    {
        completeBlockHandle();
        return true;
    }
    
    //如果存在，开始遍历文件
    for (NSString * fileName in [self.fileManager subpathsAtPath:path])
    {
        //拼接路径
        NSString * fileAbsolutePath = [path stringByAppendingPathComponent:fileName];
        
        //删除过程的回调
        deleteProgressBlockHandle(fileName);
        
        //开始删除
        [self.fileManager removeItemAtPath:fileAbsolutePath error:nil];
    
    }
    
    //删除完毕进行的回调
    completeBlockHandle();
    
    return true;
}


//创建下载的文件夹
-(BOOL)createDownFile
{
    //获得存储位置的路径字符串
    NSString * path = [XLsn0wFileHandle documentYWebImageFile];
    
    //如果存在
    if ([self folderIsExist:path])
    {
        return true;
    }
    
    //创建文件夹
    return [self.fileManager createDirectoryAtPath:path withIntermediateDirectories:true attributes:nil error:nil];
    
}



#pragma mark - Getter

-(NSFileManager *)fileManager
{
    return [NSFileManager defaultManager];
}

-(NSString *)fileSize
{
    //拼接路径
    NSString * path = [XLsn0wFileHandle documentYWebImageFile];
    
    return  [NSString stringWithFormat:@"%.2f",[self folderSizeAtPath:path]];
}


#pragma mark - File Size
//单个文件的大小
- (long long) fileSizeAtPath:(NSString * ) filePath
{
    //如果存在这个文件
    if ([self.fileManager fileExistsAtPath:filePath])
    {
        return [[self.fileManager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    
    return 0;
}


//遍历文件夹获得文件夹大小，返回多少M
- (float ) folderSizeAtPath:(NSString *) folderPath
{
    //如果不存在这个文件夹
    if (![self.fileManager fileExistsAtPath:folderPath])
    {
        return 0;
    }
    
    //需要返回的大小
    long long folderSize = 0;
    
    for (NSString * fileName in [self.fileManager subpathsAtPath:folderPath])
    {
        //拼接路径
        NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        
        //计算大小
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    
    return folderSize/(1024.0*1024.0);
}


@end
