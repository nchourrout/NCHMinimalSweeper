//
//  NCHCell.m
//  NCHMinimalSweeper
//
//  Created by Nico on 01/03/2015.
//  Copyright (c) 2015 Nico. All rights reserved.
//

#import "NCHCell.h"
#import "NCHItem.h"

@interface NCHCell ()
//@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation NCHCell

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.layer.borderColor = [UIColor blackColor].CGColor;
    self.layer.borderWidth = 1.5f;
    if (self.item.cleared) {
        [self reveal];
    } else {
        [self customizeForHidden];
    }
}

- (void)reveal
{
    if (self.item.hasMine) {
        [self customizedForMine];
    } else {
        [self customizeForNoMine];
    }
    self.userInteractionEnabled = NO;
}

- (void)prepareForReuse
{
    [self customizeForHidden];
}

- (void)customizeForHidden
{
    self.label.text = @"";
    self.backgroundColor = [UIColor grayColor];
    self.label.textColor = [UIColor blackColor];
    self.userInteractionEnabled = YES;
}

- (void)customizedForMine
{
    self.label.text = @"M";
    self.label.textColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor redColor];
}

- (void)customizeForNoMine
{
    self.backgroundColor = [UIColor whiteColor];
    self.label.text = self.item.adjacentMines == 0 ? @"" : [NSString stringWithFormat:@"%ld", self.item.adjacentMines];
}


@end
