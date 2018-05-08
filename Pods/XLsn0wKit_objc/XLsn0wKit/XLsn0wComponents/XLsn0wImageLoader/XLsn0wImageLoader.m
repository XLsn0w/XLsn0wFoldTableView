
#import "XLsn0wImageLoader.h"

#import "XLsn0wCacher.h"

NSString *LTErrorDomain = @"XLsn0wCacherError";

@interface XLsn0wImageLoader()

@property (nonatomic, strong) NSOperationQueue *operationQueue;
@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) XLsn0wCacher *cacheManager;

@end

@implementation XLsn0wImageLoader

+ (XLsn0wImageLoader *)defaultLoader {
    static XLsn0wImageLoader* instance;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        instance = [[self alloc] init];
        instance.operationQueue = [[NSOperationQueue alloc] init];
        //instance.operationQueue.maxConcurrentOperationCount = 5;
        instance.cacheManager =  [XLsn0wCacher sharedInstance];
    });
    return instance;
}

- (void)loadImageFromUrl:(NSString *)urlString Key:(NSString*)key completed:(void (^)(NSData *))completed failure:(void (^)(NSError *))failure
{
    if (!urlString || [urlString isEqualToString:@""]) {
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        [userInfo setObject:@"blank url" forKey:NSLocalizedDescriptionKey];
        NSError *error = [NSError errorWithDomain:LTErrorDomain code:LTErrorRequiredError userInfo:userInfo];
        if (failure) failure(error);
        return;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSData *cachedImage = [self.cacheManager imageDataByKey:urlString];
        if (cachedImage) {
            
            NSLog(@"cachedImage %@",urlString);
            
            if (completed) completed(cachedImage);
            return;
        }
    });
    
    
    //_session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration]];
    
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    stringByAddingPercentEscapesUsingEncoding(只对 `#%^{}[]|\"<> 加空格共14个字符编码，不包括”&?”等符号), ios9将淘汰，建议用stringByAddingPercentEncodingWithAllowedCharacters方法

//    stringByAddingPercentEncodingWithAllowedCharacters需要传一个NSCharacterSet对象
//    如[NSCharacterSet  URLQueryAllowedCharacterSet]
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet  URLQueryAllowedCharacterSet]];
    
    NSOperation *operObj = [[NetWorkManager alloc] initWithSession:self.URLSession URL:[NSURL URLWithString:urlString] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data) {
                //UIImage *image = [UIImage imageWithData:data];
                [self.cacheManager performWithImageData:data andKey:urlString];
                if (completed) completed(data);
            } else if (error){
                NSLog(@"DLImageLoader data loading canceled");
                if (failure) failure(error);
            }
        });
    }];
    
    [operObj setName:key];
    
    [[self operationQueue] addOperation:operObj];
    
}

- (void)displayImageFromUrl:(NSString *)urlString Key:(NSString*)key
{
    //imageView.image = nil;
    [self loadImageFromUrl:urlString Key:key completed:^(NSData *image) {
        //imageView.image = image;
        //[imageView setNeedsDisplay];
        NSString *str = [[NSString alloc] initWithData:image encoding:NSUTF8StringEncoding];
        NSLog(@"Data is here %@",str);
    } failure:^(NSError *error){
        //imageView.image = nil;
        NSLog(@"displayImageFromUrl error : %@",error);
    }];
}

- (void)stopDataLoading:(NSString*)key
{
    for (NetWorkManager *operation in self.operationQueue.operations) {
        if ([operation.name isEqualToString:key]) {
            [operation cancel];
        }
    }
}

@end

@implementation XLsn0wImageLoader (Subclassing)

- (NSURLSession*)URLSession {
    return [NSURLSession sharedSession];
}

@end

#define TRVSKVOBlock(KEYPATH, BLOCK) \
[self willChangeValueForKey:KEYPATH]; \
BLOCK(); \
[self didChangeValueForKey:KEYPATH];

@implementation NetWorkManager {
    BOOL _finished;
    BOOL _executing;
}

- (instancetype)initWithSession:(NSURLSession *)session URL:(NSURL *)url completionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler {
    if (self = [super init]) {
        __weak typeof(self) weakSelf = self;
        _task = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            [weakSelf completeOperationWithBlock:completionHandler data:data response:response error:error];
        }];
    }
    return self;
}

- (instancetype)initWithSession:(NSURLSession *)session request:(NSURLRequest *)request completionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler {
    if (self = [super init]) {
        __weak typeof(self) weakSelf = self;
        _task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            [weakSelf completeOperationWithBlock:completionHandler data:data response:response error:error];
        }];
    }
    return self;
}

- (void)cancel {
    [super cancel];
    [self.task cancel];
}

- (void)start {
    if (self.isCancelled) {
        TRVSKVOBlock(@"isFinished", ^{ _finished = YES; });
        return;
    }
    TRVSKVOBlock(@"isExecuting", ^{
        [self.task resume];
        _executing = YES;
    });
}

- (BOOL)isExecuting {
    return _executing;
}

- (BOOL)isFinished {
    return _finished;
}

- (BOOL)isConcurrent {
    return YES;
}

- (void)completeOperationWithBlock:(void (^)(NSData *, NSURLResponse *, NSError *))block data:(NSData *)data response:(NSURLResponse *)response error:(NSError *)error {
    if (!self.isCancelled && block)
        block(data, response, error);
    [self completeOperation];
}

- (void)completeOperation {
    [self willChangeValueForKey:@"isFinished"];
    [self willChangeValueForKey:@"isExecuting"];
    
    _executing = NO;
    _finished = YES;
    
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
}

@end
