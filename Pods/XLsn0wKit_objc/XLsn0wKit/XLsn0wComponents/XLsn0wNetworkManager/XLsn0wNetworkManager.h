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
#import <Foundation/Foundation.h>

@class AFNetworking;

/**
 *  宏定义请求成功的block
 *
 *  response 请求成功返回的数据
 */
typedef void (^ParseSuccessBlock)(NSURLSessionDataTask *task, NSDictionary *JSONDictionary, NSString *JSONString);

/**
 *  宏定义请求失败的block
 *
 *  @param error 报错信息
 */
typedef void (^ParseFailureBlock)(NSURLSessionDataTask *task, NSError *error, NSInteger statusCode, NSString *requestFailedReason);

/**
 *  上传或者下载的进度
 *
 *  @param progress 进度
 */
typedef void (^ProgressBlock)(NSProgress *progress);

@interface XLsn0wNetworkManager : NSObject

/**
 *  @brief  下载文件
 *
 *  @param requestURLString 请求地址
 *  @param requestMethod    请求方法 GET或者POST
 *  @param parameters       GET或者POST所需要传的参数
 *  @param savePath        下载后文件保存在磁盘的路径
 *  @param success          下载成功回调
 *  @param failure          下载失败回调
 *  @param progress         实时下载进度回调
 */
+ (void)downloadFileWithURL:(NSString *)requestURLString
              requestMethod:(NSString *)requestMethod
                 parameters:(NSDictionary *)parameters
                  savePath:(NSString *)savePath
            downloadSuccess:(void (^)(NSURLResponse *response, NSURL *filePath))success
            downloadFailure:(void (^)(NSError *error))failure
           downloadProgress:(void (^)(NSProgress *downloadProgress))progress;

/**
 *  普通get方法请求网络数据
 *
 *  @param url     请求网址路径
 *  @param token   身份验证令牌 不需要传@""
 *  @param params  请求参数
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)GET:(NSString *)url
      token:(NSString *)token
     params:(NSDictionary *)params
    success:(ParseSuccessBlock)success
    failure:(ParseFailureBlock)failure;
/**
 *  含有baseURL的get方法
 *
 *  @param url     请求网址路径
 *  @param token   身份验证令牌 不需要传@""
 *  @param baseUrl 请求网址根路径
 *  @param params  请求参数
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)GET:(NSString *)url
      token:(NSString *)token
    baseURL:(NSString *)baseUrl
     params:(NSDictionary *)params
    success:(ParseSuccessBlock)success
    failure:(ParseFailureBlock)failure;

/**
 *  普通post方法请求网络数据
 *
 *  @param url     请求网址路径
 *  @param token   身份验证令牌 不需要传@""
 *  @param params  请求参数
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)POST:(NSString *)url
       token:(NSString *)token
      params:(NSDictionary *)params
     success:(ParseSuccessBlock)success
     failure:(ParseFailureBlock)failure;

/**
 *  含有baseURL的post方法
 *
 *  @param url     请求网址路径
 *  @param token   身份验证令牌 不需要传@""
 *  @param baseUrl 请求网址根路径
 *  @param params  请求参数
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)POST:(NSString *)url
       token:(NSString *)token
     baseURL:(NSString *)baseUrl
      params:(NSDictionary *)params
     success:(ParseSuccessBlock)success
     failure:(ParseFailureBlock)failure;

/**
 *  普通路径上传文件
 *
 *  @param url      请求网址路径
 *  @param token   身份验证令牌 不需要传@""
 *  @param params   请求参数
 *  @param filedata 文件
 *  @param name     指定参数名
 *  @param filename 文件名（要有后缀名）
 *  @param mimeType 文件类型
 *  @param progress 上传进度
 *  @param success  成功回调
 *  @param failure  失败回调
 */
+ (void)uploadWithURL:(NSString *)url
                token:(NSString *)token
               params:(NSDictionary *)params
             fileData:(NSData *)filedata
                 name:(NSString *)name
             fileName:(NSString *)filename
             mimeType:(NSString *) mimeType
             progress:(ProgressBlock)progress
              success:(ParseSuccessBlock)success
              failure:(ParseFailureBlock)failure;
/**
 *  含有跟路径的上传文件
 *
 *  @param url      请求网址路径
 *  @param token   身份验证令牌 不需要传@""
 *  @param baseurl  请求网址根路径
 *  @param params   请求参数
 *  @param filedata 文件
 *  @param name     指定参数名
 *  @param filename 文件名（要有后缀名）
 *  @param mimeType 文件类型
 *  @param progress 上传进度
 *  @param success  成功回调
 *  @param failure  失败回调
 */
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
              failure:(ParseFailureBlock)failure;

/**
 *  下载文件
 *
 *  @param url      请求网络路径
 *  @param token   身份验证令牌 不需要传@""
 *  @param fileURL  保存文件url
 *  @param progress 下载进度
 *  @param success  成功回调
 *  @param failure  失败回调
 *
 *  @return 返回NSURLSessionDownloadTask实例，可用于暂停继续，暂停调用suspend方法，重新开启下载调用resume方法
 */
+ (NSURLSessionDownloadTask *)downloadWithURL:(NSString *)url
                                        token:(NSString *)token
                                  savePathURL:(NSURL *)fileURL
                                     progress:(ProgressBlock)progress
                                      success:(void (^)(NSURLResponse *, NSURL *))success
                                      failure:(void (^)(NSError *))failure;




@end
