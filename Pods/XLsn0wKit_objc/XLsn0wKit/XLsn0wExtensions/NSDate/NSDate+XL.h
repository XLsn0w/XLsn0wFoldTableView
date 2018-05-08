
#import <Foundation/Foundation.h>

/**
 *  The simplified date structure
 */
struct BFDateInformation {
    /**
     *  Year
     */
    NSInteger year;
    /**
     *  Month of the year
     */
    NSInteger month;
    /**
     *  Day of the month
     */
    NSInteger day;
    
    
    /**
     *  Day of the week
     */
    NSInteger weekday;
    
    /**
     *  Hour of the day
     */
    NSInteger hour;
    /**
     *  Minute of the hour
     */
    NSInteger minute;
    /**
     *  Second of the minute
     */
    NSInteger second;
    /**
     *  Nanosecond of the second
     */
    NSInteger nanosecond;
    
};
typedef struct BFDateInformation BFDateInformation;

@interface NSDate (XL)

- (BFDateInformation)dateInformation;
- (BFDateInformation)dateInformationWithTimeZone:(NSTimeZone * _Nonnull)timezone;

+ (NSString * _Nonnull)dateInformationDescriptionWithInformation:(BFDateInformation)info dateSeparator:(NSString *_Nullable)dateSeparator usFormat:(BOOL)usFormat nanosecond:(BOOL)nanosecond;

/**
 *  Compare the two days is same date (not include the time).
 *
 *  @param date The other date
 *
 *  @return true/false
 */
- (BOOL)isSameToDate:(NSDate *_Nullable)date;

@end

@interface NSDate (Convenience)

-(NSDate *_Nullable)offsetMonth:(int)numMonths;
-(NSDate *_Nullable)offsetDay:(int)numDays;
-(NSDate *_Nullable)offsetHours:(int)hours;
-(int)numDaysInMonth;
-(int)firstWeekDayInMonth;
-(int)year;
-(int)month;
-(int)day;

+(NSDate *_Nullable)dateStartOfDay:(NSDate *_Nullable)date;
+(NSDate *_Nullable)dateStartOfWeek;
+(NSDate *_Nullable)dateEndOfWeek;

@end

@interface XLDateItem : NSObject

@property (nonatomic, assign) long day;
@property (nonatomic, assign) long hour;
@property (nonatomic, assign) long minute;
@property (nonatomic, assign) long second;

@end

@interface NSDate (Extension)

- (XLDateItem *_Nullable)xl_timeIntervalSinceDate:(NSDate *_Nullable)anotherDate;

- (BOOL)xl_isToday;
- (BOOL)xl_isYesterday;
- (BOOL)xl_isTomorrow;
- (BOOL)xl_isThisYear;

//获取今天周几
- (NSInteger)xl_getNowWeekday;

@end

@interface NSDate (CurrentMonth)

/** 获取当前月总共有多少天 */
+ (NSInteger)numberOfDaysInCurrentMonth;
/** 获取当前月中共有多少周 */
+ (NSInteger)numberOfWeeksInCurrentMonth;
/** 获取当前月中第一天在一周内的索引 */
+ (NSInteger)indexOfWeekForFirstDayInCurrentMonth;
/** 获取当天在当月中的索引(第几天) */
+ (NSInteger)indexOfMonthForTodayInCurrentMonth;

@end





