
#import "NSArray+XL.h"

@implementation NSArray (XL)

- (id)xl_objectAtIndex:(NSUInteger)index {
    if (index >= [self count]) {
        return nil;
    }
    
    id value = [self objectAtIndex:index];
    if (value == [NSNull null]) {
        return nil;
    }
    return value;
}

@end
