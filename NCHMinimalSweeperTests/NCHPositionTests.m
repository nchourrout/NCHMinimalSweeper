//
//  NCHPositionTests.m
//  NCHMinimalSweeper
//
//  Created by Nico on 02/03/2015.
//  Copyright (c) 2015 Nico. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "NCHPosition.h"

@interface NCHPositionTests : XCTestCase

@end

@implementation NCHPositionTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testNeighboursCenter
{
    NCHPosition *positionCenter = [[NCHPosition alloc] initWithX:5 Y:5];
    NSArray *neighbours = [positionCenter neighboursWithGridSize:8];
    NSArray *expectedArray = @[ [[NCHPosition alloc] initWithX:4 Y:4],
                                [[NCHPosition alloc] initWithX:5 Y:4],
                                [[NCHPosition alloc] initWithX:6 Y:4],
                                
                                [[NCHPosition alloc] initWithX:4 Y:5],
                                [[NCHPosition alloc] initWithX:6 Y:5],
                                
                                [[NCHPosition alloc] initWithX:4 Y:6],
                                [[NCHPosition alloc] initWithX:5 Y:6],
                                [[NCHPosition alloc] initWithX:6 Y:6]
                               ];
    
    XCTAssertEqualObjects(neighbours, expectedArray);
}

- (void)testNeighbourBorders
{
    // Top left corner
    NCHPosition *positionTopLeft = [[NCHPosition alloc] initWithX:0 Y:0];
    NSArray *neighboursTopLeft = [positionTopLeft neighboursWithGridSize:8];
    NSArray *expectedArrayTopLeft = @[ [[NCHPosition alloc] initWithX:1 Y:0],
                                       [[NCHPosition alloc] initWithX:0 Y:1],
                                       [[NCHPosition alloc] initWithX:1 Y:1]];
    
    XCTAssertEqualObjects(neighboursTopLeft, expectedArrayTopLeft);
    
    // Bottom right corner
    NCHPosition *positionBottomRight = [[NCHPosition alloc] initWithX:7 Y:7];
    NSArray *neighboursBottomRight = [positionBottomRight neighboursWithGridSize:8];
    NSArray *expectedArrayBottomRight = @[[[NCHPosition alloc] initWithX:6 Y:6],
                                          [[NCHPosition alloc] initWithX:7 Y:6],
                                          [[NCHPosition alloc] initWithX:6 Y:7]];
    
    XCTAssertEqualObjects(neighboursBottomRight, expectedArrayBottomRight);
}


@end
