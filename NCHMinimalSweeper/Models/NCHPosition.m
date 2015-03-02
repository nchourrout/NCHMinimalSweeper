//
//  NCHPosition.m
//  NCHMinimalSweeper
//
//  Created by Nico on 01/03/2015.
//  Copyright (c) 2015 Nicolas Chourrout. All rights reserved.
//

#import "NCHPosition.h"
#import <UIKit/UIKit.h>

@implementation NCHPosition

- (instancetype)initWithX:(NSUInteger)x
                        Y:(NSUInteger)y
{
    self = [super init];
    if (self) {
        _x = x;
        _y = y;
    }
    return self;
}

- (instancetype)init
{
    self = [self initWithX:0 Y:0];
    return self;
}

+ (NCHPosition *)randomPositionWithGridSize:(NSUInteger)size
{
    return [[NCHPosition alloc] initWithX:arc4random() % size
                                        Y:arc4random() % size];
}

- (NSArray *)neighboursWithGridSize:(NSUInteger)size
{
    NSMutableArray *neighbours = [@[] mutableCopy];
    
    for (NSInteger offsetY = -1; offsetY <= 1; offsetY++) {
        for (NSInteger offsetX = -1; offsetX <= 1; offsetX++) {
            NSInteger x = self.x + offsetX;
            NSInteger y = self.y + offsetY;
            
            // Current position or outside of grid
            if (x < 0 || y < 0 || x >= size || y >= size || (x == self.x && y == self.y)) {
                continue;
            }
            
            NCHPosition *neighbour = [[NCHPosition alloc] initWithX:x Y:y];
            [neighbours addObject:neighbour];
        }
    }
    return neighbours;
}

- (NSIndexPath *)indexPath
{
    return [NSIndexPath indexPathForItem:self.x inSection:self.y];
}

+ (NSArray *)indexPathsFromPositionSet:(NSSet *)set
{
    NSMutableArray *indexPaths = [@[] mutableCopy];
    for (NCHPosition *position in set) {
        [indexPaths addObject:position.indexPath];
    }
    return indexPaths;
}

#pragma mark - NSObject

- (BOOL)isEqual:(id)object
{
    if ([object isKindOfClass:[NCHPosition class]]) {
        NCHPosition *otherPosition = (NCHPosition *)object;
        return self.x == otherPosition.x && self.y == otherPosition.y;
    }
    return NO;
}

- (NSUInteger)hash
{
    return self.x * 10000 + self.y;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%ld, %ld", self.x, self.y];
}
    
@end
