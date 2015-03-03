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

@interface NCHViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) NCHGrid *grid;
@end

static NSString * const CellIdentifier  = @"NCHCell";
static const NSTimeInterval PeekDelay = 2.0;

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

- (IBAction)playForMePressed:(id)sender
{
    NSSet *clearedPositions = [self.grid autoPlay];
    if (!clearedPositions) { // No more moves, we've won
        [self alertForEndOfGameWithSuccess:YES];
        return;
    }
    
    [self.collectionView reloadItemsAtIndexPaths:[NCHPosition indexPathsFromPositionSet:clearedPositions]];
}

- (IBAction)peekPressed:(id)sender
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSSet *updatedPositions = [self.grid revealMines:YES];
        [self.collectionView reloadItemsAtIndexPaths:[NCHPosition indexPathsFromPositionSet:updatedPositions]];
    });
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(PeekDelay * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        NSSet *updatedPositions = [self.grid revealMines:NO];
        [self.collectionView reloadItemsAtIndexPaths:[NCHPosition indexPathsFromPositionSet:updatedPositions]];
    });
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
    
    NSSet *clearedPositions = [self.grid clearItemAtPosition:position];
    
    if (clearedPositions.count == 1) {
        NCHItem *item = [self.grid itemAtPosition:[clearedPositions allObjects][0]];
        if (item.hasMine) {
            [self alertForEndOfGameWithSuccess:NO];
        }
    }
    
    [self.collectionView reloadItemsAtIndexPaths:[NCHPosition indexPathsFromPositionSet:clearedPositions]];
}

#pragma mark - Alert

- (void)alertForEndOfGameWithSuccess:(BOOL)success
{
    NSString *title = success ? NSLocalizedString(@"You Won!", @"You won alert title") :
                                NSLocalizedString(@"Game Over", @"Game Over alert title");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:@""
                                                   delegate:self
                                          cancelButtonTitle:NSLocalizedString(@"New Game", @"New Game button")
                                          otherButtonTitles:nil];
    [alert show];
}

#pragma mark - <UIAlertViewDelegate>

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self newGame];
}

@end
