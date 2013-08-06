//
//  Created by Klaus-Peter Dudas on 05/08/2013.
//  Copyright (c) 2013 Hypercrypt Solutions Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const firstObject;
extern NSString * const lastObject;

@interface NSArray (HCSafeAccess)

@property (nonatomic, readonly) id randomObject;

- (id)objectForKeyedSubscript:(id)key;

@end
