//
//  NCHPosition.h
//  NCHMinimalSweeper
//
//  Created by Nico on 01/03/2015.
//  Copyright (c) 2015 Nicolas Chourrout. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NCHPosition : NSObject

@property (nonatomic, readonly) NSInteger x;
@property (nonatomic, readonly) NSInteger y;

- (instancetype)initWithX:(NSInteger)x
                        Y:(NSInteger)y;


- (NSArray *)neighboursWithGridSize:(NSUInteger)size;
+ (NCHPosition *)randomPositionWithGridSize:(NSUInteger)size;

- (NSIndexPath *)indexPath;

@end
