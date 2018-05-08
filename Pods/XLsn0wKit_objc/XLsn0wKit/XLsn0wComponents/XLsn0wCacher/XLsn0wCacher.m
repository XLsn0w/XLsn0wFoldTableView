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

#import "XLsn0wCacher.h"
#import "XLsn0wMacro.h"

@interface XLsn0wCacher ()

@property (nonatomic, strong) NSCache *cache;

@end

@implementation XLsn0wCacher

static XLsn0wCacher *cacher = nil;
+ (XLsn0wCacher *)defaultCacher {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cacher = [[self alloc] init];
    });
    return cacher;
}

+ (instancetype)sharedInstance
{
    static XLsn0wCacher *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [self new];
        instance->_cache = [NSCache new];
        instance->_memoryCacheEnabled = YES;
    });
    return instance;
}

- (UIImage *)imageByKey:(NSString *)key
{
    UIImage *image = nil;
    if (_memoryCacheEnabled) {
        image = [_cache objectForKey:key];
    }
    return image;
}

- (NSData *)imageDataByKey:(NSString *)key {
    NSData *image = nil;
    if (_memoryCacheEnabled) {
        image = [_cache objectForKey:key];
    }
    return image;
}

- (void)performWithImage:(UIImage *)image andKey:(NSString *)key
{
    if (_memoryCacheEnabled) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            if (image) {
                [_cache setObject:image forKey:key];
            }
        });
    }
}

- (void)performWithImageData:(NSData *)imgData andKey:(NSString *)key {
    if (_memoryCacheEnabled) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            if (imgData) {
                [_cache setObject:imgData forKey:key];
            }
        });
    }
    
}


#pragma mark -
#pragma mark - Cache

- (void)setCacheInMemory:(BOOL)enabled {
    _memoryCacheEnabled = enabled;
}


@end
