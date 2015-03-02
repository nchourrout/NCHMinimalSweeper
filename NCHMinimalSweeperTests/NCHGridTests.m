//
//  NCHGridTests.m
//  NCHMinimalSweeper
//
//  Created by Nico on 02/03/2015.
//  Copyright (c) 2015 Nico. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "NCHGrid.h"
#import "NCHPosition.h"

@interface NCHGridTests : XCTestCase

@end

@interface NCHGrid ()
- (void)setMineAtPosition:(NCHPosition *)position;
@end

@implementation NCHGridTests

- (void)testSimpleGrid
{
                                       // 0 1 2 3 4 5 6 7
    NSString *expectedGridDescription = @"0 0 0 1 2 M M 1 \n" // 0
                                         "1 1 0 1 M 3 2 1 \n" // 1
                                         "M 2 1 2 1 2 1 1 \n" // 2
                                         "1 2 M 2 2 2 M 1 \n" // 3
                                         "0 1 2 M 3 M 2 1 \n" // 4
                                         "0 0 2 3 M 2 1 0 \n" // 5
                                         "0 0 1 M 2 1 0 0 \n" // 6
                                         "0 0 1 1 1 0 0 0 \n";// 7
    
    NCHGrid *grid = [[NCHGrid alloc] init];
    
    [grid setMineAtPosition:[[NCHPosition alloc] initWithX:5 Y:0]];
    [grid setMineAtPosition:[[NCHPosition alloc] initWithX:6 Y:0]];
    
    [grid setMineAtPosition:[[NCHPosition alloc] initWithX:4 Y:1]];
    [grid setMineAtPosition:[[NCHPosition alloc] initWithX:0 Y:2]];
    
    [grid setMineAtPosition:[[NCHPosition alloc] initWithX:2 Y:3]];
    [grid setMineAtPosition:[[NCHPosition alloc] initWithX:6 Y:3]];
    
    [grid setMineAtPosition:[[NCHPosition alloc] initWithX:3 Y:4]];
    [grid setMineAtPosition:[[NCHPosition alloc] initWithX:5 Y:4]];
    
    [grid setMineAtPosition:[[NCHPosition alloc] initWithX:4 Y:5]];
    
    [grid setMineAtPosition:[[NCHPosition alloc] initWithX:3 Y:6]];
    
    XCTAssertTrue([expectedGridDescription isEqualToString:grid.description ]);
}


@end
