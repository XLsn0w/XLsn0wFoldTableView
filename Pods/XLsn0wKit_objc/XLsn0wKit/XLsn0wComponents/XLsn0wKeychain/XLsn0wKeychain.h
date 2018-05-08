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

@interface XLsn0wKeychain : NSObject

+ (void)keyChainSave:(NSString *)service;

+ (NSString *)keyChainLoad;

+ (void)keyChainDelete;

/**************************************************************************************************/

+ (NSString *) getPasswordForUsername: (NSString *) username andServiceName: (NSString *) serviceName error: (NSError **) error;
+ (BOOL) storeUsername: (NSString *) username andPassword: (NSString *) password forServiceName: (NSString *) serviceName updateExisting: (BOOL) updateExisting error: (NSError **) error;
+ (BOOL) deleteItemForUsername: (NSString *) username andServiceName: (NSString *) serviceName error: (NSError **) error;

@end


//NSString *SERVICE_NAME = @"com.-----";//最好用程序的bundle id
//// 从keychain获取数据
//NSString * str =  [XLsn0wKeychain getPasswordForUsername:@"UUID"
//                                          andServiceName:SERVICE_NAME error:nil];
//if ([str length] <= 0) {
//    // 保存UUID作为手机唯一标识符
//    str  = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
//    
//    // 往keychain添加数据
//    [XLsn0wKeychain storeUsername:@"UUID" andPassword:str
//                   forServiceName:SERVICE_NAME
//                   updateExisting:1
//                            error:nil];
//}
