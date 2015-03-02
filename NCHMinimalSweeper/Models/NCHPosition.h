//
//  NCHPosition.h
//  NCHMinimalSweeper
//
//  Created by Nico on 01/03/2015.
//  Copyright (c) 2015 Nicolas Chourrout. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NCHPosition : NSObject

@property (nonatomic, readonly) NSUInteger x;
@property (nonatomic, readonly) NSUInteger y;

- (instancetype)initWithX:(NSUInteger)x
                        Y:(NSUInteger)y;


- (NSArray *)neighboursWithGridSize:(NSUInteger)size;
- (NSIndexPath *)indexPath;

+ (NCHPosition *)randomPositionWithGridSize:(NSUInteger)size;
+ (NSArray *)indexPathsFromPositionSet:(NSSet *)set;

@end
