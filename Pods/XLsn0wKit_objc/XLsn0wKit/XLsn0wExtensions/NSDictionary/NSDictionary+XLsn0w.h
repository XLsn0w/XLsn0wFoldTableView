
#import <Foundation/Foundation.h>

@interface NSDictionary (XLsn0w)

@end

@interface NSDictionary (StringToDictionary)

+ (nonnull NSDictionary *)xl_stringToDictionaryWithStr:(nonnull NSString *)string;

@end

@interface NSDictionary (ModelToDictionary)

/**
 *  模型转字典
 *
 *  @return 字典
 */
+ (nonnull NSDictionary *)xl_dictionaryFromModel;

/**
 *  带model的数组或字典转字典
 *
 *  @param object 带model的数组或字典转
 *
 *  @return 字典
 */
+ (nonnull id)xl_idFromObject:(nonnull id)object;

@end

@interface NSDictionary (PropertyCode)

// 生成所需要的属性代码
- (void)propertyCode;

@end

