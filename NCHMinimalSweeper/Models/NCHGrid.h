//
//  NCHGrid.h
//  NCHMinimalSweeper
//
//  Created by Nico on 01/03/2015.
//  Copyright (c) 2015 Nicolas Chourrout. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NCHItem, NCHPosition;

@interface NCHGrid : NSObject

@property (nonatomic, readonly) NSUInteger size;

- (void)addMines;

- (NSSet *)revealMines:(BOOL)show;

- (NSSet *)autoPlay;

- (BOOL)validate;

- (NCHItem *)itemAtPosition:(NCHPosition *)position;

- (NSSet *)clearItemAtPosition:(NCHPosition *)position;

@end
