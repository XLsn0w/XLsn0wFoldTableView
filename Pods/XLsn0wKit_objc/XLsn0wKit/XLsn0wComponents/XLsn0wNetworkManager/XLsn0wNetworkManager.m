/*********************************************************************************************
 *   __      __   _         _________     _ _     _    _________   __         _         __   *
 *     \ \    / /  | |        | _______|   | | \   | |  |  ______ |  \ \       / \       / /   *
 *      \ \  / /   | |        | |          | |\ \  | |  | |     | |   \ \     / \ \     / /    *
 *     \ \/ /    | |        | |______    | | \ \ | |  | |     | |    \ \   / / \ \   / /     *
 *     /\/\/\    | |        |_______ |   | |  \ \| |  | |     | |     \ \ / /   \ \ / /      *
 *    / /  \ \   | |______   ______| |   | |   \ \ |  | |_____| |      \ \ /     \ \ /       *
 *   /_/    \_\  |________| |________|   |_|    \__|  |_________|       \_/       \_/        *
 *                                                                                           *
 *********************************************************************************************/
#import "XLsn0wNetworkManager.h"
/*********************************************************************************************
 *   __      __   _         _________     _ _     _    _________   __         _         __   *
 *     \ \    / /  | |        | _______|   | | \   | |  |  ______ |  \ \       / \       / /   *
 *      \ \  / /   | |        | |          | |\ \  | |  | |     | |   \ \     / \ \     / /    *
 *     \ \/ /    | |        | |______    | | \ \ | |  | |     | |    \ \   / / \ \   / /     *
 *     /\/\/\    | |        |_______ |   | |  \ \| |  | |     | |     \ \ / /   \ \ / /      *
 *    / /  \ \   | |______   ______| |   | |   \ \ |  | |_____| |      \ \ /     \ \ /       *
 *   /_/    \_\  |________| |________|   |_|    \__|  |_________|       \_/       \_/        *
 *                                                                                           *
 *********************************************************************************************/
#import "AFNetworking.h"

@implementation XLsn0wNetworkManager

+ (void)downloadFileWithURL:(NSString *)requestURLString
              requestMethod:(NSString *)requestMethod
                 parameters:(NSDictionary *)parameters
                  savePath:(NSString *)savePath
            downloadSuccess:(void (^)(NSURLResponse *response, NSURL *filePath))success
            downloadFailure:(void (^)(NSError *error))failure
           downloadProgress:(void (^)(NSProgress *downloadProgress))progress {
    
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    
    //requestMethod = @"GET" 或者 @"POST"
    NSMutableURLRequest *request =[serializer requestWithMethod:requestMethod URLString:requestURLString parameters:parameters error:nil];
    NSURLSessionDownloadTask *task = [[AFHTTPSessionManager manager] downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        progress(downloadProgress);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        return [NSURL fileURLWithPath:savePath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if(error){
            failure(error);
        }else{
            success(response,filePath);
        }
    }];
    [task resume];
}

+ (void)GET:(NSString *)url
      token:(NSString *)token
     params:(NSDictionary *)params
    success:(ParseSuccessBlock)success
    failure:(ParseFailureBlock)failure {
    
    AFHTTPSessionManager *manager = [XLsn0wNetworkManager managerWithBaseURL:nil sessionConfiguration:NO];
    
    //add timeoutInterval = 5
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 5;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    /*! <Add HTTPHeader> [key : value格式] {@"Authorization" : @"Bearer空格Token"} */
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", token] forHTTPHeaderField:@"Authorization"];
    
    [manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *JSONDictionary = [XLsn0wNetworkManager responseConfiguration:responseObject];
        NSString *JSONString = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:JSONDictionary options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
//        JSONString = [JSONString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];//去除掉首尾的空白字符和换行字符
//        JSONString = [JSONString stringByReplacingOccurrencesOfString:@"\n" withString:@""];//去除多余的换行
//        JSONString = [JSONString stringByReplacingOccurrencesOfString:@" " withString:@""];//去除多余的空格
        JSONString = [JSONString stringByReplacingOccurrencesOfString:@"\\" withString:@""];//去除多余的\
        
        success(task, JSONDictionary, JSONString);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse *HTTPURLResponse = [error.userInfo objectForKey:AFNetworkingOperationFailingURLResponseErrorKey];
        NSInteger statusCode = HTTPURLResponse.statusCode;
        NSString *requestFailedReason = [error.userInfo objectForKey:NSLocalizedDescriptionKey];
        failure(task, error, statusCode, requestFailedReason);
    }];
}

+ (void)GET:(NSString *)url
      token:(NSString *)token
    baseURL:(NSString *)baseUrl
     params:(NSDictionary *)params
    success:(ParseSuccessBlock)success
    failure:(ParseFailureBlock)failure {
    
    AFHTTPSessionManager *manager = [XLsn0wNetworkManager managerWithBaseURL:baseUrl sessionConfiguration:NO];
    
    //add timeoutInterval = 5
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 5;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    /*! <Add HTTPHeader> [key : value格式] {@"Authorization" : @"Bearer空格Token"} */
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", token] forHTTPHeaderField:@"Authorization"];
    
    [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *JSONDictionary = [XLsn0wNetworkManager responseConfiguration:responseObject];
        NSString *JSONString = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:JSONDictionary options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
        JSONString = [JSONString stringByReplacingOccurrencesOfString:@"\\" withString:@""];
        
        success(task, JSONDictionary, JSONString);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse *HTTPURLResponse = [error.userInfo objectForKey:AFNetworkingOperationFailingURLResponseErrorKey];
        NSInteger statusCode = HTTPURLResponse.statusCode;
        NSString *requestFailedReason = [error.userInfo objectForKey:NSLocalizedDescriptionKey];
        failure(task, error, statusCode, requestFailedReason);
    }];
    
}

+ (void)POST:(NSString *)url
       token:(NSString *)token
      params:(NSDictionary *)params
     success:(ParseSuccessBlock)success
     failure:(ParseFailureBlock)failure {
    
    AFHTTPSessionManager *manager = [XLsn0wNetworkManager managerWithBaseURL:nil sessionConfiguration:NO];
    
    //add timeoutInterval = 5
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 5;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    /*! <Add HTTPHeader> [key : value格式] {@"Authorization" : @"Bearer空格Token"} */
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", token] forHTTPHeaderField:@"Authorization"];
    
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *JSONDictionary = [XLsn0wNetworkManager responseConfiguration:responseObject];
        NSString *JSONString = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:JSONDictionary options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
        JSONString = [JSONString stringByReplacingOccurrencesOfString:@"\\" withString:@""];
        
        success(task, JSONDictionary, JSONString);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse *HTTPURLResponse = [error.userInfo objectForKey:AFNetworkingOperationFailingURLResponseErrorKey];
        NSInteger statusCode = HTTPURLResponse.statusCode;
        NSString *requestFailedReason = [error.userInfo objectForKey:NSLocalizedDescriptionKey];
        failure(task, error, statusCode, requestFailedReason);
    }];
}

+ (void)POST:(NSString *)url
       token:(NSString *)token
     baseURL:(NSString *)baseUrl
      params:(NSDictionary *)params
     success:(ParseSuccessBlock)success
     failure:(ParseFailureBlock)failure {
    
    AFHTTPSessionManager *manager = [XLsn0wNetworkManager managerWithBaseURL:baseUrl sessionConfiguration:NO];
    
    //add timeoutInterval = 5
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 5;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    /*! <Add HTTPHeader> [key : value格式] {@"Authorization" : @"Bearer空格Token"} */
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", token] forHTTPHeaderField:@"Authorization"];
    
    [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *JSONDictionary = [XLsn0wNetworkManager responseConfiguration:responseObject];
        NSString *JSONString = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:JSONDictionary options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
        JSONString = [JSONString stringByReplacingOccurrencesOfString:@"\\" withString:@""];
        
        success(task, JSONDictionary, JSONString);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse *HTTPURLResponse = [error.userInfo objectForKey:AFNetworkingOperationFailingURLResponseErrorKey];
        NSInteger statusCode = HTTPURLResponse.statusCode;
        NSString *requestFailedReason = [error.userInfo objectForKey:NSLocalizedDescriptionKey];
        failure(task, error, statusCode, requestFailedReason);
    }];
}

+ (void)uploadWithURL:(NSString *)url
                token:(NSString *)token
               params:(NSDictionary *)params
             fileData:(NSData *)filedata
                 name:(NSString *)name
             fileName:(NSString *)filename
             mimeType:(NSString *) mimeType
             progress:(ProgressBlock)progress
              success:(ParseSuccessBlock)success
              failure:(ParseFailureBlock)failure {
    
    AFHTTPSessionManager *manager = [XLsn0wNetworkManager managerWithBaseURL:nil sessionConfiguration:NO];
    
    //add timeoutInterval = 5
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 5;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    /*! <Add HTTPHeader> [key : value格式] {@"Authorization" : @"Bearer空格Token"} */
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", token] forHTTPHeaderField:@"Authorization"];
    
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:filedata name:name fileName:filename mimeType:mimeType];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        progress(uploadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *JSONDictionary = [XLsn0wNetworkManager responseConfiguration:responseObject];
        NSString *JSONString = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:JSONDictionary options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
        JSONString = [JSONString stringByReplacingOccurrencesOfString:@"\\" withString:@""];
        
        success(task, JSONDictionary, JSONString);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse *HTTPURLResponse = [error.userInfo objectForKey:AFNetworkingOperationFailingURLResponseErrorKey];
        NSInteger statusCode = HTTPURLResponse.statusCode;
        NSString *requestFailedReason = [error.userInfo objectForKey:NSLocalizedDescriptionKey];
        failure(task, error, statusCode, requestFailedReason);
    }];
}

+ (void)uploadWithURL:(NSString *)url
                token:(NSString *)token
              baseURL:(NSString *)baseurl
               params:(NSDictionary *)params
             fileData:(NSData *)filedata
                 name:(NSString *)name
             fileName:(NSString *)filename
             mimeType:(NSString *) mimeType
             progress:(ProgressBlock)progress
              success:(ParseSuccessBlock)success
              failure:(ParseFailureBlock)failure {
    
    AFHTTPSessionManager *manager = [XLsn0wNetworkManager managerWithBaseURL:baseurl sessionConfiguration:YES];
    
    //add timeoutInterval = 5
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 5;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    /*! <Add HTTPHeader> [key : value格式] {@"Authorization" : @"Bearer空格Token"} */
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", token] forHTTPHeaderField:@"Authorization"];
    
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:filedata name:name fileName:filename mimeType:mimeType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        progress(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *JSONDictionary = [XLsn0wNetworkManager responseConfiguration:responseObject];
        NSString *JSONString = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:JSONDictionary options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
        JSONString = [JSONString stringByReplacingOccurrencesOfString:@"\\" withString:@""];
        
        success(task, JSONDictionary, JSONString);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse *HTTPURLResponse = [error.userInfo objectForKey:AFNetworkingOperationFailingURLResponseErrorKey];
        NSInteger statusCode = HTTPURLResponse.statusCode;
        NSString *requestFailedReason = [error.userInfo objectForKey:NSLocalizedDescriptionKey];
        failure(task, error, statusCode, requestFailedReason);
    }];
}

+ (NSURLSessionDownloadTask *)downloadWithURL:(NSString *)url
                                        token:(NSString *)token
                                  savePathURL:(NSURL *)fileURL
                                     progress:(ProgressBlock)progress
                                      success:(void (^)(NSURLResponse *, NSURL *))success
                                      failure:(void (^)(NSError *))failure {
    AFHTTPSessionManager *manager = [self managerWithBaseURL:nil sessionConfiguration:YES];
    
    //add timeoutInterval = 5
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 5;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    /*! <Add HTTPHeader> [key : value格式] {@"Authorization" : @"Bearer空格Token"} */
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", token] forHTTPHeaderField:@"Authorization"];
    
    NSURL *urlpath = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:urlpath];
    
    NSURLSessionDownloadTask *downloadtask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        progress(downloadProgress);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        return [fileURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        if (error) {
            failure(error);
        } else {
            success(response,filePath);
        }
    }];
    
    [downloadtask resume];
    
    return downloadtask;
}

#pragma mark - Private

+ (AFHTTPSessionManager *)managerWithBaseURL:(NSString *)baseURL
                        sessionConfiguration:(BOOL)isconfiguration {
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *manager =nil;
    
    NSURL *url = [NSURL URLWithString:baseURL];
    
    if (isconfiguration) {
        
        manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url sessionConfiguration:configuration];
        
    } else {
        
        manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    }
    
    //add timeoutInterval = 5
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 5;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    return manager;
}

+ (NSDictionary *)responseConfiguration:(id)responseObject {
    NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    
    return dic;
}

@end
