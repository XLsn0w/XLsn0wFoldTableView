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
#import "XLsn0wUdpSocket.h"
#import "GCDAsyncUdpSocket.h"

@interface XLsn0wUdpSocket () <GCDAsyncUdpSocketDelegate>

@end

@implementation XLsn0wUdpSocket

static __strong XLsn0wUdpSocket *xlsn0wUdpSocket = nil;
+ (XLsn0wUdpSocket *)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        xlsn0wUdpSocket = [[XLsn0wUdpSocket alloc] init];
    });
    return xlsn0wUdpSocket;
}

- (instancetype)init {
    if (self = [super init]) {
        [self initGCDAsyncUdpSocket];
    }
    return self;
}

- (void)initGCDAsyncUdpSocket {
    NSError *xlsn0wError = nil;
    _xlsn0wGCDAsyncUdpSocket = [[GCDAsyncUdpSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
    [_xlsn0wGCDAsyncUdpSocket enableBroadcast:YES error:&xlsn0wError];
    [_xlsn0wGCDAsyncUdpSocket beginReceiving:&xlsn0wError];
}

- (NSString*)xlsn0w_receiveJSONStringWithUdpDictionary:(NSDictionary *)UdpDictionary {
    NSError *xlsn0wError = nil;
    NSData *JSONData = [NSJSONSerialization dataWithJSONObject:UdpDictionary
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&xlsn0wError];
    
    NSString *JSONString = @"";
    
    if (!JSONData) {
        NSLog(@"error: %@", xlsn0wError);
    } else {
        JSONString = [[NSString alloc] initWithData:JSONData encoding:NSUTF8StringEncoding];
    }
    
    JSONString = [JSONString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
    JSONString = [JSONString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    JSONString = [JSONString stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    return JSONString;
}

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didConnectToAddress:(NSData *)address {
    NSLog(@"XLsn0wUdpSocket did Connect To Address\n");
}

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didNotConnect:(NSError *)error {
    NSLog(@"XLsn0wUdpSocket did Not Connect\n");
}

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didSendDataWithTag:(long)tag {
    NSLog(@"XLsn0wUdpSocket did Send Data\n");
}

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didNotSendDataWithTag:(long)tag dueToError:(NSError *)error {
    NSLog(@"XLsn0wUdpSocket did Not Send Data\n");
}

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didReceiveData:(NSData *)data fromAddress:(NSData *)address withFilterContext:(id)filterContext {
    NSString *JSONString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"©XLsn0wUdpSocket did Receive Data©\n\n RespondDictionary ---> %@\n\n", JSONString);
    NSDictionary *JSONDictionary = [[XLsn0wUdpSocket shared] xlsn0w_receiveJSONDictionaryWithJSONData:data];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"postRespondDictionary" object:nil userInfo:JSONDictionary];
}

- (NSDictionary *)xlsn0w_receiveJSONDictionaryWithJSONData:(NSData *)JSONData {
    NSDictionary *JSONDictionary = [NSJSONSerialization JSONObjectWithData:JSONData options:0 error:nil];
    return JSONDictionary;
}

- (void)udpSocketDidClose:(GCDAsyncUdpSocket *)sock withError:(NSError *)error {
    NSLog(@"error: %@", error);
}

- (void)xlsn0w_sendUdpDictionary:(NSDictionary *)UdpDictionary xlsn0wUdpSocketRespondDictionary:(XLsn0wUdpSocketRespondDictionary)xlsn0wUdpSocketRespondDictionary {
    self.xlsn0wUdpSocketRespondDictionary = xlsn0wUdpSocketRespondDictionary;
    NSString *JSONString = [[XLsn0wUdpSocket shared] xlsn0w_receiveJSONStringWithUdpDictionary:UdpDictionary];
    NSData *sendData = [JSONString dataUsingEncoding:self.xlsn0wEncoding];
    [_xlsn0wGCDAsyncUdpSocket sendData:sendData toHost:_xlsn0wIP port:_xlsn0wPort withTimeout:-1 tag:0];
}

- (void)xlsn0w_postUdpDictionary:(NSDictionary *)UdpDictionary {
    NSString *JSONString = [[XLsn0wUdpSocket shared] xlsn0w_receiveJSONStringWithUdpDictionary:UdpDictionary];
    NSData *sendData = [JSONString dataUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
    [_xlsn0wGCDAsyncUdpSocket sendData:sendData toHost:@"121.40.75.37" port:9992 withTimeout:-1 tag:0];
}

@end

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
