//
//  NCHItem.h
//  NCHMinimalSweeper
//
//  Created by Nico on 01/03/2015.
//  Copyright (c) 2015 Nicolas Chourrout. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NCHItem : NSObject

@property (nonatomic) BOOL hasMine;
@property (nonatomic) BOOL cleared;
@property (nonatomic) NSUInteger adjacentMines;

@end
