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

- (instancetype)initWithX:(NSInteger)x
                        Y:(NSInteger)y
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
    for (NSInteger offsetY = -1; offsetY <= 1 && self.x + offsetY < size; offsetY++) {
        for (NSInteger offsetX = -1; offsetX <= 1 && self.x + offsetX < size; offsetX++) {
            if (!(offsetX == 0 && offsetY == 0)) {
                NCHPosition *neighbour = [[NCHPosition alloc] initWithX:self.x + offsetX
                                                                      Y:self.y + offsetY];
                [neighbours addObject:neighbour];
            }
        }
    }
    return neighbours;
}

- (NSIndexPath *)indexPath
{
    return [NSIndexPath indexPathForItem:self.x inSection:self.y];
}
    
@end
