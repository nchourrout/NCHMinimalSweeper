//
//  NCHGrid.m
//  NCHMinimalSweeper
//
//  Created by Nico on 01/03/2015.
//  Copyright (c) 2015 Nicolas Chourrout. All rights reserved.
//

#import "NCHGrid.h"
#import "NCHItem.h"
#import "NCHPosition.h"

static const NSUInteger GridSize = 8;
static const NSUInteger MineNumber = 10;

@interface NCHGrid ()

@property (nonatomic) NSMutableArray *grid;
@property (nonatomic) NSUInteger clearedCount;

@end


@implementation NCHGrid

- (instancetype)init
{
    self = [super init];
    if (self) {
        _clearedCount = 0;
        
        _grid = [NSMutableArray arrayWithCapacity:GridSize];
        for (NSUInteger i = 0; i < GridSize; i++) {
            NSMutableArray *row = [NSMutableArray arrayWithCapacity:GridSize];
            for (NSInteger j = 0; j < GridSize; j++) {
                [row addObject:[NCHItem new]];
            }
            [_grid addObject:row];
        }
    }
    return self;
}

#pragma mark - Grid generation

- (void)addMines
{
    NSUInteger minesLeftToPlace = MineNumber;
    while(minesLeftToPlace) {
        NCHPosition *minePosition = [NCHPosition randomPositionWithGridSize:GridSize];
        NCHItem *item = [self itemAtPosition:minePosition];
        if (!item.hasMine) {
            [self setMineAtPosition:minePosition];
            minesLeftToPlace--;
        }
    }
}


- (void)setMineAtPosition:(NCHPosition *)position
{
    NCHItem *item = [self itemAtPosition:position];
    if (!item) {
        return;
    }
    
    item.hasMine = YES;
    
    NSArray *neighbourPositions = [position neighboursWithGridSize:self.size];
    for (NCHPosition *neighbour in neighbourPositions) {
        [self incrementCountAtPosition:neighbour];
    }
}

- (void)incrementCountAtPosition:(NCHPosition *)position
{
    NCHItem *item = [self itemAtPosition:position];
    if (!item) {
        return;
    }
    item.adjacentMines++;
}

- (NCHItem *)itemAtPosition:(NCHPosition *)position
{
    if (!position || position.x >= GridSize || position.y >= GridSize) return nil;
    return self.grid[position.y][position.x];
}


- (NSSet *)clearItemAtPosition:(NCHPosition *)position
{
    NSMutableArray *queue = [NSMutableArray arrayWithObject:position];
    NSMutableSet *visitedPositions = [NSMutableSet setWithObject:position];
    
    while (queue.count) {
        NCHPosition *lastPosition = [queue lastObject];
        
        NCHItem *item = [self itemAtPosition:lastPosition];
        if (!item) {
            return nil;
        }
        
        item.cleared = YES;
        self.clearedCount++;
        
        if (item.adjacentMines == 0 && !item.hasMine) {
            NSMutableSet *newPositions = [NSMutableSet setWithArray:[lastPosition neighboursWithGridSize:self.size]];
            [newPositions minusSet:visitedPositions];
            
            [queue replaceObjectsInRange:NSMakeRange(0,0)
                    withObjectsFromArray:[newPositions allObjects]];
            
            [visitedPositions unionSet:newPositions];
        }

        [queue removeLastObject];
    }
    return visitedPositions;
}



- (void)cheat
{
    BOOL cheated = NO;
    while(!cheated) {
        NCHPosition *randomPosition = [NCHPosition randomPositionWithGridSize:GridSize];
        NCHItem *item = [self itemAtPosition:randomPosition];
        if (!item.cleared && !item.hasMine) {
            [self clearItemAtPosition:randomPosition];
        }
    }
}

- (BOOL)validate
{
    return GridSize * GridSize - self.clearedCount == MineNumber;
}

- (NSUInteger)size
{
    return GridSize;
}

#pragma mark - NSObject

- (NSString *)description
{
    NSMutableString *description = [@"MineGrid:\n" mutableCopy];
    for (NSArray *row in self.grid) {
        for (NCHItem *item in row) {
            [description appendString:item.description];
        }
        [description appendString:@"\n"];
    }
    return description;
}

@end
