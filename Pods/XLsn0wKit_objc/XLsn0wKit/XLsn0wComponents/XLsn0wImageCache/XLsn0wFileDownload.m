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

#import "XLsn0wFileDownload.h"

#import "XLsn0wFileHandle.h"
#import "XLsn0wImageCache.h"

@interface XLsn0wFileDownload () <NSURLSessionDownloadDelegate>

@property (nonatomic, copy)NSString * imagePath;        //记录图片url的字符串path
@property (nonatomic, strong)NSURL * imageURL;          //请求图片的url
@property (nonatomic, copy)NSString * imageName;        //转型后的图片名称
@property (nonatomic, copy)NSString * documentPath;     //沙盒路径
@property (nonatomic, copy)NSData * currentData;        //存储当前下载的数据对象

@property (nonatomic, strong)NSURLSession * session;                    //自定义的活动下载对象
@property (nonatomic, strong)NSURLSessionDownloadTask * downLoadTask;   //下任务对象

@property (nonatomic, copy)DownManagerFinishBlock finishBlockHandle;        //下载完成后的回调
@property (nonatomic, copy)DownManagerProgressBlock progressBlockHandle;    //下载过程中的回调

@end

@implementation XLsn0wFileDownload


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        //初始化session
        self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:nil];
        
        //初始化数据
        self.currentData = nil;
    }
    return self;
}

#pragma mark - 设置回调的方法
-(void)downManagerFinishBlockHandle:(DownManagerFinishBlock)downManagerFinishBlockHandle
{
    self.finishBlockHandle = downManagerFinishBlockHandle;
}

-(void)downManagerProgressBlockHandle:(DownManagerProgressBlock)downManagerProgressBlockHandle
{
    self.progressBlockHandle = downManagerProgressBlockHandle;
}





#pragma mark - 开始下载图片的方法
-(void)startDownImagePath:(NSString *)imagePath
{
    NSLog(@"开始下载图片啦,路径为:%@",imagePath);
    
    //暂停下载
    [self pauseDown];
    
    //根据url检测是否存在本地图片
    if ([[XLsn0wImageCache sharedImageCache] fileIsExist:imagePath]) {
        
        //拼接路径
        NSString * path = [XLsn0wFileHandle documentYWebImageFileAppendBase64File:imagePath];
        
        //主线程进行回调
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //调用下载成功的回调
            if(self.finishBlockHandle)
            {
                self.finishBlockHandle(path);
            }
            
        });
        
        return;
    }
    
    //赋值
    _imagePath = imagePath;
    
    //创建url对象
    NSURL * downURL = [[NSURL alloc]initWithString:_imagePath];

    //开始根据URL请求图片
    [self startDownImageURL:downURL];
    
}

- (void)startDownImageURL:(NSURL *)imageURL
{
    //获取本地数据
    self.currentData = [[NSUserDefaults standardUserDefaults] valueForKey:imageURL.absoluteString];
    
    //如果断点数据存在，继续续点下载
    if (self.currentData)
    {
        [self resumeDown];
    }
    
    else//重新开始下载
    {
        //开始赋值
        _imageURL = imageURL;
        
        //创建请求对象
        NSURLRequest * request = [NSURLRequest requestWithURL:_imageURL];
        
        //获取下载对象
        self.downLoadTask = [self.session downloadTaskWithRequest:request];
        
        //开始请求
        [self.downLoadTask resume];
    }
}


//暂停下载
-(void)pauseDown
{
    //任务暂停
    [self.downLoadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
        
        //如果下载url存在
        if(self.imageURL)
        {
            //需要将未下载完毕的数据以字典形式存到UserDefault
            [[NSUserDefaults standardUserDefaults] setValue:resumeData forKey:self.imageName];
        }
    }];
    
    //将任务对象置nil
    _downLoadTask = nil;
}


//续点下载
- (void)resumeDown
{
    self.downLoadTask = [self.session downloadTaskWithResumeData:self.currentData];
    
    //开始继续下载
    [self.downLoadTask resume];
}

#pragma mark - NSURLSessionDownload Delegate

//下载完成
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location
{
    //路径字符串
    NSString * path = [XLsn0wFileHandle documentYWebImageFileAppendFile:self.imageName];
    
    //创建相关文件夹
    [[XLsn0wImageCache sharedImageCache] createDownFile];
    
    //获取创建下载到的路径url
    NSURL * url = [NSURL fileURLWithPath:path];
    
    //获取文件管理者
    NSFileManager * fileManager = [NSFileManager defaultManager];
    
    //存到文件，类似一个剪切过程
    [fileManager moveItemAtURL:location toURL:url error:nil];
    
    //删除UserDefault中的缓存数据
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:self.imageName];
    
    //主线程回调
    dispatch_async(dispatch_get_main_queue(), ^{
        
        //执行回调,传出路径
        if (self.finishBlockHandle) {
            self.finishBlockHandle(path);
        }
    });
}


- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    //主线程进行回调
    dispatch_async(dispatch_get_main_queue(), ^{
        
        //执行过程的回调
        if (self.progressBlockHandle) {
            self.progressBlockHandle(bytesWritten,totalBytesWritten,totalBytesExpectedToWrite);
        }
    });
}

#pragma mark - Document Path
- (NSString *)documentPath
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true) firstObject];
}

#pragma mark - Image Name Base64
-(NSString *)imageName
{
    return [XLsn0wFileHandle imageNameForBase64Handle:_imageURL.absoluteString];
}

@end
