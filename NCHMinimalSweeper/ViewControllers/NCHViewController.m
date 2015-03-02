//
//  NCHViewController.m
//  NCHMinimalSweeper
//
//  Created by Nico on 01/03/2015.
//  Copyright (c) 2015 Nico. All rights reserved.
//

#import "NCHViewController.h"
#import "NCHGrid.h"
#import "NCHCell.h"
#import "NCHPosition.h"
#import "NCHItem.h"

@interface NCHViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) NCHGrid *grid;
@end

static NSString * const CellIdentifier  = @"NCHCell";

@implementation NCHViewController

- (void)awakeFromNib
{
    [self newGame];
}

#pragma mark - Actions

- (IBAction)newGamePressed:(id)sender
{
    [self newGame];
}

- (void)newGame
{
    self.grid = [[NCHGrid alloc] init];
    [self.grid addMines];
    [self.collectionView reloadData];
}

- (IBAction)validatePressed:(id)sender
{
    BOOL valid = [self.grid validate];
    [self alertForEndOfGameWithSuccess:valid];
}

- (IBAction)cheatPressed:(id)sender
{
    [self.grid cheat];
    [self.collectionView reloadData];
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.grid.size;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.grid.size;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NCHCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier
                                                                   forIndexPath:indexPath];
    
    NCHPosition *position = [[NCHPosition alloc] initWithX:indexPath.item
                                                         Y:indexPath.section];
    
    cell.item = [self.grid itemAtPosition:position];
    
    return cell;
}

#pragma mark - <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NCHPosition *position = [[NCHPosition alloc] initWithX:indexPath.item
                                                         Y:indexPath.section];
    
    NCHItem *item = [self.grid itemAtPosition:position];
    NCHCell *cell = (NCHCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    item.cleared = YES;
    [cell reveal];
    
    /*NSSet *clearedPositions = [self.grid clearItemAtPosition:position];
    
    if (clearedPositions.count == 1) {
        NCHItem *item = [self.grid itemAtPosition:[clearedPositions allObjects][0]];
        if (item.hasMine) {
            [self alertForEndOfGameWithSuccess:NO];
        }
    }
    
    NSMutableArray *indexPaths = [@[] mutableCopy];
    for (NCHPosition *position in clearedPositions) {
        [indexPaths addObject:position.indexPath];
    }
    
    [self.collectionView reloadData];
    [self.collectionView reloadInputViews];
    [self.collectionView reloadItemsAtIndexPaths:indexPaths];
     */
}

#pragma mark - Alert

- (void)alertForEndOfGameWithSuccess:(BOOL)success
{
    NSString *title = success ? NSLocalizedString(@"You Won!", @"You won alert title") :
                                NSLocalizedString(@"Game Over", @"Game Over alert title");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:@""
                                                   delegate:self
                                          cancelButtonTitle:NSLocalizedString(@"OK", @"Ok alert button")
                                          otherButtonTitles:nil];
    [alert show];
}

@end
