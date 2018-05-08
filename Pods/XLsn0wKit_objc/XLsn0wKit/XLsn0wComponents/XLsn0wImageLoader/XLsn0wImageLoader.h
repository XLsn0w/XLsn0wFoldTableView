
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

extern NSString *LTErrorDomain;

enum LTErrorCode {
    LTErrorAPIError = 0,
    LTErrorUnrecognizedResponse = 1,
    LTErrorUnexpectedResponse = 2,
    LTErrorParseError = 3,
    LTErrorHTTPError = 4,
    LTErrorRequiredError = 5,
};
typedef enum MSErrorCode LTErrorCode;

@interface XLsn0wImageLoader : NSObject

/**
 Instance method
 @return shared instance.
 */
+ (XLsn0wImageLoader *)defaultLoader;


/**
 Load image from url
 @param urlString The url of image.
 @param completed Completed is a completion block that will call after image loading.
 @param failure failure is a block that will if loading opedation was calceled.
 */
- (void)loadImageFromUrl:(NSString *)urlString Key:(NSString*)key completed:(void(^)(NSData *image))completed
failure:(void(^)(NSError *error))failure;

/**
 Load image from url
 @param urlString The url of image.
 @param key key in which will display image.
 */
- (void)displayImageFromUrl:(NSString *)urlString Key:(NSString*)key;

/**
 Stop all active operations
 */
- (void)stopDataLoading:(NSString*)key;

@end

@interface XLsn0wImageLoader (Subclassing)

/**
 Returns the URL sessions used to download the image. Override to use a custom session. Uses sharedSession by default.
 */
@property (nonatomic, readonly) NSURLSession *URLSession;

@end

@interface NetWorkManager : NSOperation

/** Creates a data task to retrieve the contents of the given URL.
 @param session instance of session.
 @param url url to api call.
 @param completionHandler completion block with data/response/error.
 */

- (instancetype)initWithSession:(NSURLSession *)session URL:(NSURL *)url completionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler;

/** Creates a data task with the given request.  The request may have a body stream.
 @param session instance of session.
 @param request request to api call with header body.
 @param completionHandler completion block with data/response/error.
 */

- (instancetype)initWithSession:(NSURLSession *)session request:(NSURLRequest *)request completionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler;

@property (nonatomic, strong, readonly) NSURLSessionDataTask *task;

@end
