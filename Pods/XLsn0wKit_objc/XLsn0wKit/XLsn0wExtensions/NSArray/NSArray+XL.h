
#import <Foundation/Foundation.h>

@interface NSArray (XL)

/**
 *  Fixed the issue of array index beyond bounds
 *
 *  @param index The array index
 *
 *  @return Object in array
 */
- (id)xl_objectAtIndex:(NSUInteger)index;

@end

