
#import <Foundation/Foundation.h>

@class FMDatabase;
@class XLsn0wDBUser;

@interface XLsn0wDatabase : NSObject

@property (nonatomic, strong) FMDatabase *fmdb;

//单例工具类
+ (XLsn0wDatabase *)shared;

//创建数据库表
- (void)createDatabaseWithTableName:(NSString *)tableName;

//(增)插入
- (void)insertUser:(XLsn0wDBUser *)user;

//(删)删除
- (void)deleteUserWithPrimaryKeyId:(NSString *)primaryKeyId;

//(改)更新
- (void)updateImageDataOfUser:(XLsn0wDBUser *)user;  ///image data
- (void)updateImageUrlOfUser:(XLsn0wDBUser *)user;   ///image url
- (void)updateUserNameOfUser:(XLsn0wDBUser *)user;   ///用户名
- (void)updatePasswordOfUser:(XLsn0wDBUser *)user;   ///密码
- (void)updatePhoneNumberOfUser:(XLsn0wDBUser *)user;///手机号
- (void)updateUserIdOfUser:(XLsn0wDBUser *)user;     ///用户ID

//(查)取值
- (NSMutableArray *)selectUserArrayFromDatabase;

@end

