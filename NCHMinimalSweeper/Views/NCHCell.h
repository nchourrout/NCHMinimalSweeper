//
//  NCHCell.h
//  NCHMinimalSweeper
//
//  Created by Nico on 01/03/2015.
//  Copyright (c) 2015 Nico. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NCHItem;

@interface NCHCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *label;

@property (nonatomic) NCHItem *item;

- (void)reveal;

@end
