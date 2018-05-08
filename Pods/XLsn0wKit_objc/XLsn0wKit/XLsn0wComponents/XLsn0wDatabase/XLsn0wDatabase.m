
#import "XLsn0wDatabase.h"

#import "FMDatabase.h"
#import "XLsn0wDBUser.h"

@implementation XLsn0wDatabase

/// Create Singleton
static XLsn0wDatabase *instance = nil;
+ (XLsn0wDatabase *)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

//Create Database With TableName
- (void)createDatabaseWithTableName:(NSString *)tableName {
    if (!_fmdb) {
        NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        NSString *dbFileName = [NSString stringWithFormat:@"%@.db", tableName];
        NSString *databasePath = [documentsPath stringByAppendingPathComponent:dbFileName];
        _fmdb = [FMDatabase databaseWithPath:databasePath];
       }
    if ([_fmdb open]) {
        BOOL result = [_fmdb executeUpdate:@"create table XLsn0wDatabase (primaryKeyId text primary key not null, imageData blob, userName text, password text, age text, birthday text, height text, weight text, phoneNumber text, address text, userId text, imageUrl text, userToken text, token text, trueName text, estateId text, gender text, accountId text, accountType text, propertyId text)"];
        if (result) {
            NSLog(@"创建XLsn0wDatabase成功");
        } else {
            NSLog(@"创建XLsn0wDatabase失败 / 本地XLsn0wDatabase已存在");
        }
        [_fmdb close];
    }
}

/*******<增>insert****************************************************************/
- (void)insertUser:(XLsn0wDBUser *)user {
    if ([_fmdb open]) {
        NSString *insertCommand = [NSString stringWithFormat:@"insert into XLsn0wDatabase (primaryKeyId, imageData, userName, password, age, birthday, height, weight, phoneNumber, address, userId, imageUrl, userToken, token, trueName, estateId, gender, accountId, accountType, propertyId) values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"];
        BOOL result = [_fmdb executeUpdate:insertCommand,
                       user.primaryKeyId,
                       user.imageData,
                       user.userName,
                       user.password,
                       user.age,
                       user.birthday,
                       user.height,
                       user.weight,
                       user.phoneNumber,
                       user.address,
                       user.userId,
                       user.imageUrl,
                       user.userToken,
                       user.token,
                       user.trueName,
                       user.estateId,
                       user.gender,
                       user.accountId,
                       user.accountType,
                       user.propertyId];
        if (result) {
            NSLog(@"插入XLsn0wDBUser成功");
        } else {
            NSLog(@"插入XLsn0wDBUser失败");
        }
        [_fmdb close];
    }
}

/*******<删>delete****************************************************************/
- (void)deleteUserWithPrimaryKeyId:(NSString *)primaryKeyId {
    if ([_fmdb open]) {
        NSString *deleteCommand = [NSString stringWithFormat:@"delete from XLsn0wDatabase where primaryKeyId = ?"];
        BOOL result = [_fmdb executeUpdate:deleteCommand, primaryKeyId];
        if (result) {
            NSLog(@"删除XLsn0wDBUser成功");
        } else {
            NSLog(@"删除XLsn0wDBUser失败");
        }
        [_fmdb close];
    }
}

/*******<改>update**************************************************************************/
- (void)updateImageDataOfUser:(XLsn0wDBUser *)user {
    if ([_fmdb open]) {
        NSString *updateCommand = [NSString stringWithFormat:@"update XLsn0wDatabase set imageData = ? where primaryKeyId = ?;"];
        BOOL result = [_fmdb executeUpdate:updateCommand, user.imageData, user.primaryKeyId];
        if (result) {
            NSLog(@"更新imageData成功");
        } else {
            NSLog(@"更新imageData失败");
        }
        [_fmdb close];
    }
}

- (void)updateImageUrlOfUser:(XLsn0wDBUser *)user {
    if ([_fmdb open]) {
        NSString *updateCommand = [NSString stringWithFormat:@"update XLsn0wDatabase set imageUrl = ? where primaryKeyId = ?;"];
        BOOL result = [_fmdb executeUpdate:updateCommand, user.imageUrl, user.primaryKeyId];
        if (result) {
            NSLog(@"更新imageUrl成功");
        } else {
            NSLog(@"更新imageUrl失败");
        }
        [_fmdb close];
    }
}

- (void)updateUserNameOfUser:(XLsn0wDBUser *)user {
    if ([_fmdb open]) {
        NSString *updateCommand = [NSString stringWithFormat:@"update XLsn0wDatabase set userName = ? where primaryKeyId = ?;"];
        BOOL result = [_fmdb executeUpdate:updateCommand, user.userName, user.primaryKeyId];
        if (result) {
            NSLog(@"更新userName成功");
        } else {
            NSLog(@"更新userName失败");
        }
        [_fmdb close];
    }
}

- (void)updatePasswordOfUser:(XLsn0wDBUser *)user {
    if ([_fmdb open]) {
        NSString *updateCommand = [NSString stringWithFormat:@"update XLsn0wDatabase set password = ? where primaryKeyId = ?;"];
        BOOL result = [_fmdb executeUpdate:updateCommand, user.password, user.primaryKeyId];
        if (result) {
            NSLog(@"更新password成功");
        } else {
            NSLog(@"更新password失败");
        }
        [_fmdb close];
    }
}

- (void)updatePhoneNumberOfUser:(XLsn0wDBUser *)user {
    if ([_fmdb open]) {
        NSString *updateCommand = [NSString stringWithFormat:@"update XLsn0wDatabase set phoneNumber = ? where primaryKeyId = ?;"];
        BOOL result = [_fmdb executeUpdate:updateCommand, user.phoneNumber, user.primaryKeyId];
        if (result) {
            NSLog(@"更新phoneNumber成功");
        } else {
            NSLog(@"更新phoneNumber失败");
        }
        [_fmdb close];
    }
}

- (void)updateUserIdOfUser:(XLsn0wDBUser *)user {
    if ([_fmdb open]) {
        NSString *updateCommand = [NSString stringWithFormat:@"update XLsn0wDatabase set userId = ? where primaryKeyId = ?;"];
        BOOL result = [_fmdb executeUpdate:updateCommand, user.userId, user.primaryKeyId];
        if (result) {
            NSLog(@"更新userId成功");
        } else {
            NSLog(@"更新userId失败");
        }
        [_fmdb close];
    }
}

/*******<查>select********************************************************************/
- (NSMutableArray *)selectUserArrayFromDatabase {
    // create userArray
    NSMutableArray *userArray = [[NSMutableArray alloc] init];
    if ([_fmdb  open]) {
        // 执行查询语句
        NSString *selectCommand = @"select * from XLsn0wDatabase";
        FMResultSet *resultSet = [_fmdb executeQuery:selectCommand];
        // 遍历结果
        while ([resultSet next]) {
            //create user
            XLsn0wDBUser *user = [[XLsn0wDBUser alloc] init];
            
            // Primary Key ID
            user.primaryKeyId = [resultSet stringForColumn:@"primaryKeyId"];
            
            // user property
            user.imageData = [resultSet dataForColumn:@"imageData"];//NSData *
            
            // NSString *
            user.userName = [resultSet stringForColumn:@"userName"];
            user.password = [resultSet stringForColumn:@"password"];
            
            user.age = [resultSet stringForColumn:@"age"];
            user.birthday = [resultSet stringForColumn:@"age"];
            user.height = [resultSet stringForColumn:@"age"];
            user.weight = [resultSet stringForColumn:@"age"];
            user.phoneNumber = [resultSet stringForColumn:@"phoneNumber"];
            user.address = [resultSet stringForColumn:@"address"];
            user.userId = [resultSet stringForColumn:@"userId"];
            user.imageUrl = [resultSet stringForColumn:@"imageUrl"];
            user.userToken = [resultSet stringForColumn:@"userToken"];
            
            user.token = [resultSet stringForColumn:@"token"];
            user.trueName = [resultSet stringForColumn:@"trueName"];
            user.estateId = [resultSet stringForColumn:@"estateId"];
            
            user.gender = [resultSet stringForColumn:@"gender"];
            user.accountId = [resultSet stringForColumn:@"accountId"];
            user.accountType = [resultSet stringForColumn:@"accountType"];
            user.propertyId = [resultSet stringForColumn:@"propertyId"];
            
            // add user into userArray
            [userArray addObject:user];
        }
        [_fmdb close];
    }
    NSLog(@"查询XLsn0wDatabase成功");
    return userArray;
}

@end
