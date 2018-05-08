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
#import <UIKit/UIKit.h>

typedef void (^XLsn0wUdpSocketRespondDictionary)(NSDictionary *respondDictionary);

@class GCDAsyncUdpSocket;

@interface XLsn0wUdpSocket : NSObject

@property (nonatomic, strong) GCDAsyncUdpSocket *xlsn0wGCDAsyncUdpSocket;

@property (nonatomic, copy)   NSString  *xlsn0wIP;  //Service IP Address
@property (nonatomic, assign) NSInteger  xlsn0wPort;//Service Port

@property (nonatomic, assign) NSStringEncoding xlsn0wEncoding;

@property (nonatomic, assign) XLsn0wUdpSocketRespondDictionary xlsn0wUdpSocketRespondDictionary;

+ (XLsn0wUdpSocket *)shared;

- (void)xlsn0w_sendUdpDictionary:(NSDictionary *)UdpDictionary xlsn0wUdpSocketRespondDictionary:(XLsn0wUdpSocketRespondDictionary)xlsn0wUdpSocketRespondDictionary;

- (void)xlsn0w_postUdpDictionary:(NSDictionary *)UdpDictionary;

- (NSDictionary *)xlsn0w_receiveJSONDictionaryWithJSONData:(NSData *)JSONData;
- (NSString*)xlsn0w_receiveJSONStringWithUdpDictionary:(NSDictionary *)UdpDictionary;

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
 ****************************How to use XLsn0wUdpSocket***************************************



***************************************************************************************************/
