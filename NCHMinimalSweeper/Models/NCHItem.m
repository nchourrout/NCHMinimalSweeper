//
//  NCHItem.m
//  NCHMinimalSweeper
//
//  Created by Nico on 01/03/2015.
//  Copyright (c) 2015 Nicolas Chourrout. All rights reserved.
//

#import "NCHItem.h"

@implementation NCHItem

- (instancetype)init
{
    self = [super init];
    if (self) {
        _hasMine = NO;
        _cleared = NO;
        _adjacentMines = 0;
    }
    return self;
}

- (NSString *)description
{
    return self.hasMine ? @"M " : [NSString stringWithFormat:@"%ld ", self.adjacentMines];
}

@end
