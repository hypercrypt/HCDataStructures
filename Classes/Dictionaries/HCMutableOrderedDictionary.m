//
//  HCOrderedDictionary.m
//  components
//
//  Created by Klaus-Peter Dudas on 01/05/2013.
//  Copyright (c) 2013 Hypercrypt Solutions Ltd. All rights reserved.
//

#import "HCMutableOrderedDictionary.h"

@interface HCMutableOrderedDictionary ()

@property (nonatomic, strong) NSMutableArray *keys;
@property (nonatomic, strong) NSMutableArray *values;

@end

@implementation HCMutableOrderedDictionary

- (id)initWithObjects:(NSArray *)objects forKeys:(NSArray *)keys
{
    self = [super init];
    
    if (self)
    {
        _values = [objects mutableCopy];
        _keys   = [keys    mutableCopy];
    }
    
    return self;
}

- (id)initWithCapacity:(NSUInteger)capacity
{
    self = [super init];
    
    if (self)
    {
        _keys   = [[NSMutableArray alloc] initWithCapacity:capacity];
        _values = [[NSMutableArray alloc] initWithCapacity:capacity];
    }
    
    return self;    
}

#pragma mark - Primitive Methods
- (NSUInteger)count
{
    NSAssert(self.keys.count == self.values.count, @"Keys (%llu) has diverged from Objects (%llu)", (unsigned long long)self.keys.count, (unsigned long long)self.values.count);
    
    return self.keys.count;
}

- (id)objectForKey:(id)key
{
    NSAssert(self.keys.count == self.values.count, @"Keys (%llu) has diverged from Objects (%llu)", (unsigned long long)self.keys.count, (unsigned long long)self.values.count);

    NSUInteger index = [self.keys indexOfObject:key];
    
    return (index == NSNotFound) ? nil : self.values[index];
}

- (NSEnumerator *)keyEnumerator
{
    return self.keys.objectEnumerator;
}

- (NSEnumerator *)reverseKeyEnumerator
{
    return self.keys.reverseObjectEnumerator;
}

- (void)setObject:(id)object forKey:(id<NSCopying>)key
{
    NSAssert(self.keys.count == self.values.count, @"Keys (%llu) has diverged from Objects (%llu)", (unsigned long long)self.keys.count, (unsigned long long)self.values.count);

    NSUInteger index = [self.keys indexOfObject:key];
    
    if (index == NSNotFound)
    {
        [self.keys   addObject:key];
        [self.values addObject:object];
    }
    else
    {
        self.values[index] = object;
    }
    
    NSAssert(self.keys.count == self.values.count, @"Keys (%llu) has diverged from Objects (%llu)", (unsigned long long)self.keys.count, (unsigned long long)self.values.count);
}

- (void)removeObjectForKey:(id)key
{
    NSAssert(self.keys.count == self.values.count, @"Keys (%llu) has diverged from Objects (%llu)", (unsigned long long)self.keys.count, (unsigned long long)self.values.count);

    NSUInteger index = [self.keys indexOfObject:key];
    
    if (index != NSNotFound)
    {
        [self.keys   removeObjectAtIndex:index];
        [self.values removeObjectAtIndex:index];
    }

    NSAssert(self.keys.count == self.values.count, @"Keys (%llu) has diverged from Objects (%llu)", (unsigned long long)self.keys.count, (unsigned long long)self.values.count);
}

#pragma mark - Other NSMutableDictionary
- (NSArray *)allKeys
{
    return [self.keys copy];
}

- (NSArray *)allValues
{
    return [self.values copy];
}

#pragma mark - Copying
- (id)copyWithZone:(NSZone *)zone
{
    return [[NSDictionary alloc] initWithObjects:self.values forKeys:self.keys];
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
    return [[[self class] alloc] initWithObjects:self.values forKeys:self.keys];
}

#pragma mark - Properties
- (NSMutableArray *)keys
{
    if (!_keys)
    {
        _keys = [[NSMutableArray alloc] init];
    }
    
    return _keys;
}

- (NSMutableArray *)values
{
    if (!_values)
    {
        _values = [[NSMutableArray alloc] init];
    }
    
    return _values;
}

@end
