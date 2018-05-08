

#import "NSString+calculate.h"

@implementation NSString (calculate)
//加
- (NSString *)calculateByAdding:(NSString *)stringNumer
{
    NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *num2 = [NSDecimalNumber decimalNumberWithString:stringNumer];
    NSDecimalNumber *addingNum = [num1 decimalNumberByAdding:num2];
    return [addingNum stringValue];
}
//减
- (NSString *)calculateBySubtracting:(NSString *)stringNumer
{
    NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *num2 = [NSDecimalNumber decimalNumberWithString:stringNumer];
    NSDecimalNumber *subtractingNum = [num1 decimalNumberBySubtracting:num2];
    return [subtractingNum stringValue];
}
//乘
- (NSString *)calculateByMultiplying:(NSString *)stringNumer
{
    NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *num2 = [NSDecimalNumber decimalNumberWithString:stringNumer];
    NSDecimalNumber *multiplyingNum = [num1 decimalNumberByMultiplyingBy:num2];
    return [multiplyingNum stringValue];
}
//除
- (NSString *)calculateByDividing:(NSString *)stringNumer
{
    NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *num2 = [NSDecimalNumber decimalNumberWithString:stringNumer];
    NSDecimalNumber *dividingNum = [num1 decimalNumberByDividingBy:num2];
    return [dividingNum stringValue];
    
}
//幂运算
- (NSString *)calculateByRaising:(NSUInteger)power
{
    NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *raisingNum = [num1 decimalNumberByRaisingToPower:power];
    return [raisingNum stringValue];
    
}
//四舍五入
- (NSString *)calculateByRounding:(NSUInteger)scale
{
    NSDecimalNumberHandler * handler = [[NSDecimalNumberHandler alloc] initWithRoundingMode:NSRoundPlain scale:scale raiseOnExactness:NO raiseOnOverflow:YES raiseOnUnderflow:YES raiseOnDivideByZero:YES];
    NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *roundingNum = [num1 decimalNumberByRoundingAccordingToBehavior:handler];
    return [roundingNum stringValue];
}
//是否相等
- (BOOL)calculateIsEqual:(NSString *)stringNumer
{
    NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *num2 = [NSDecimalNumber decimalNumberWithString:stringNumer];
    NSComparisonResult result = [num1 compare:num2];
    if (result == NSOrderedSame) {
        return YES;
    }
    return NO;
}
//是否大于
- (BOOL)calculateIsGreaterThan:(NSString *)stringNumer
{
    NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *num2 = [NSDecimalNumber decimalNumberWithString:stringNumer];
    NSComparisonResult result = [num1 compare:num2];
    if (result == NSOrderedDescending) {
        return YES;
    }
    return NO;

}
//是否小于
- (BOOL)calculateIsLessThan:(NSString *)stringNumer
{
    NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *num2 = [NSDecimalNumber decimalNumberWithString:stringNumer];
    NSComparisonResult result = [num1 compare:num2];
    if (result == NSOrderedAscending) {
        return YES;
    }
    return NO;

}

- (double)calculateDoubleValue
{
    NSDecimalNumber *num = [NSDecimalNumber decimalNumberWithString:self];
    return [num doubleValue];
}

- (NSString *)positiveFormat:(NSString *)text{
    if(!text || [text floatValue] == 0){
        return @"0.00";
    }
    if (text.floatValue < 1000) {
        return  [NSString stringWithFormat:@"%.2f",text.floatValue];
    };
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@",###.00;"];
    return [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[text doubleValue]]];
}







@end
