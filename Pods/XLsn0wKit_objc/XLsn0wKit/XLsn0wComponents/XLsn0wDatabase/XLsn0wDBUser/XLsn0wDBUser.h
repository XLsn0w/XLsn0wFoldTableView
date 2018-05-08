
#import <Foundation/Foundation.h>

@interface XLsn0wDBUser : NSObject

/*! 主键ID 检索用户索引 */
@property (nonatomic, copy) NSString *primaryKeyId;

/*! 用户头像 NSData类型 */
@property (nonatomic, strong) NSData *imageData;

/*! 用户名 */
@property (nonatomic, copy) NSString *userName;

/*! 密码 */
@property (nonatomic, copy) NSString *password;

/*! 年龄 */
@property (nonatomic, copy) NSString *age;

/*! 生日 */
@property (nonatomic, copy) NSString *birthday;

/*! 身高 */
@property (nonatomic, copy) NSString *height;

/*! 体重 */
@property (nonatomic, copy) NSString *weight;

/*! 手机号码 */
@property (nonatomic, copy) NSString *phoneNumber;

/*! 地址 */
@property (nonatomic, copy) NSString *address;

/*! <用户ID> 格式不限，可以为数字、GUID、或者任意的字符串（中文除外）*/
@property(nonatomic, strong) NSString *userId;

/*! 头像URL 字符串类型 */
@property(nonatomic, strong) NSString *imageUrl;

/*! UserToken 用户令牌 */
@property(nonatomic, strong) NSString *userToken;

/*****************************************************/

/*! Token 令牌 */
@property(nonatomic, strong) NSString *token;

/*! 真实姓名 */
@property(nonatomic, strong) NSString *trueName;

/*! 房地产ID */
@property(nonatomic, strong) NSString *estateId;

/*! 性别 */
@property (nonatomic, copy) NSString *gender;

/*! 账号ID */
@property(nonatomic, strong) NSString *accountId;

/*! 账号类型 */
@property(nonatomic, strong) NSString *accountType;

/*! 属性ID */
@property(nonatomic, strong) NSString *propertyId;

@end
