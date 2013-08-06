//
//  Created by Klaus-Peter Dudas on 05/08/2013.
//  Copyright (c) 2013 Hypercrypt Solutions Ltd. All rights reserved.
//

#import "NSArray+HCSafeAccess.h"

NSString * const firstObject = @"0";
NSString * const lastObject  = @"-1";
NSString * const randomObject = @"RANDOM";

@implementation NSArray (HCSafeAccess)

- (id)randomObject
{
    return self[arc4random_uniform(self.count)];
}

- (id)objectForKeyedSubscript:(id)key
{
    if ([key isEqual:randomObject])
    {
        return self.randomObject;
    }
    else if ([key respondsToSelector:@selector(integerValue)])
    {
        NSInteger index = [key integerValue];
        
        if (index < 0)
        {
            return self.lastObject;
        }
        else
        {
            return (self.count < index) ? self[index] : nil;
        }
    }
    else if ([key isKindOfClass:[NSIndexSet class]])
    {
        @try
        {
            return [self objectsAtIndexes:key];
        }
        @catch (NSException *exception)
        {
            return nil;
        }
    }
    else
    {
        return nil;
    }
}

@end
