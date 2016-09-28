//
//  ORGContainerCellView.m
//  HorizontalCollectionViews
//
//  Created by James Clark on 4/22/13.
//  Copyright (c) 2013 OrgSync, LLC. All rights reserved.
//

#import "LONewsContainerCellView.h"
#import "LONewsArticleCollectionViewCell.h"
#import <QuartzCore/QuartzCore.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "LONewsArticle.h"

@interface LONewsContainerCellView () <UICollectionViewDataSource, UICollectionViewDelegate, NSFetchedResultsControllerDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *collectionData;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) LONewsArticle *selectedItem;

@property (nonatomic, strong) NSBlockOperation *blockOperation;
@property (nonatomic) bool shouldReloadCollectionView;

@end

@implementation LONewsContainerCellView

- (void)awakeFromNib {
    [super awakeFromNib];

    //self.collectionView.backgroundColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.itemSize = CGSizeMake(130.0, 190.0f);
    [self.collectionView setCollectionViewLayout:flowLayout];

    // Register the colleciton cell
    [_collectionView registerNib:[UINib nibWithNibName:@"LONewsArticleCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"LONewsArticleCollectionViewCell"];
    
    [self fetch];
}

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController == nil) {
        NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"articleID" ascending:NO];
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSManagedObjectContext *context = [[MagicalRecordStack defaultStack] context];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"LONewsArticle" inManagedObjectContext:context];
        
        [fetchRequest setEntity:entity];
        [fetchRequest setSortDescriptors:@[sort]];
        [fetchRequest setFetchBatchSize:8];
        
        _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                        managedObjectContext:context
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
        
        _fetchedResultsController.delegate = self;
        
    }
    
    return _fetchedResultsController;
}

- (void)fetch {
    NSError *error = nil;
    BOOL success = [self.fetchedResultsController performFetch:&error];
    NSAssert2(success, @"Unhandled error performing fetch at LOAddTableViewController, line %d: %@", __LINE__, [error localizedDescription]);
    [_collectionView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

#pragma mark - Getter/Setter overrides
- (void)setCollectionData:(NSArray *)collectionData {
    _collectionData = collectionData;
    [_collectionView setContentOffset:CGPointZero animated:NO];
    [_collectionView reloadData];
}


#pragma mark - UICollectionViewDataSource methods
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [[[self fetchedResultsController] sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (void)configureCell:(LONewsArticleCollectionViewCell *)cell forCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath
{
    LONewsArticle *article = nil;
    //** TODO Confirm: Testing bounds check on objectAtIndexPath method for frc **//
    if ([[self.fetchedResultsController sections] count] >= [indexPath section]){
        id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:[indexPath section]];
        if ([sectionInfo numberOfObjects] >= [indexPath row]){
            article = (LONewsArticle *) [self.fetchedResultsController objectAtIndexPath:indexPath];
            
            cell.articleTitle.text = article.title;
            
            [cell.articleImage sd_setImageWithURL:[NSURL URLWithString:article.imageURL]
                                 placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                            //... completion code here ...
                                        }];
            
        }
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LONewsArticleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LONewsArticleCollectionViewCell" forIndexPath:indexPath];
    [self configureCell:cell forCollectionView:collectionView atIndexPath:indexPath];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedItem = (LONewsArticle *) [self.fetchedResultsController objectAtIndexPath:indexPath];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didSelectItemFromCollectionView" object:self.selectedItem];
}


- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    self.shouldReloadCollectionView = NO;
    self.blockOperation = [[NSBlockOperation alloc] init];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    __weak UICollectionView *collectionView = self.collectionView;
    switch (type) {
        case NSFetchedResultsChangeInsert: {
            [self.blockOperation addExecutionBlock:^{
                [collectionView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]];
            }];
            break;
        }
            
        case NSFetchedResultsChangeDelete: {
            [self.blockOperation addExecutionBlock:^{
                [collectionView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]];
            }];
            break;
        }
            
        case NSFetchedResultsChangeUpdate: {
            [self.blockOperation addExecutionBlock:^{
                [collectionView reloadSections:[NSIndexSet indexSetWithIndex:sectionIndex]];
            }];
            break;
        }
            
        default:
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    __weak UICollectionView *collectionView = self.collectionView;
    switch (type) {
        case NSFetchedResultsChangeInsert: {
            if ([self.collectionView numberOfSections] > 0) {
                if ([self.collectionView numberOfItemsInSection:indexPath.section] == 0) {
                    self.shouldReloadCollectionView = YES;
                } else {
                    [self.blockOperation addExecutionBlock:^{
                        [collectionView insertItemsAtIndexPaths:@[newIndexPath]];
                    }];
                }
            } else {
                self.shouldReloadCollectionView = YES;
            }
            break;
        }
            
        case NSFetchedResultsChangeDelete: {
            if ([self.collectionView numberOfItemsInSection:indexPath.section] == 1) {
                self.shouldReloadCollectionView = YES;
            } else {
                [self.blockOperation addExecutionBlock:^{
                    [collectionView deleteItemsAtIndexPaths:@[indexPath]];
                }];
            }
            break;
        }
            
        case NSFetchedResultsChangeUpdate: {
            [self.blockOperation addExecutionBlock:^{
                [collectionView reloadItemsAtIndexPaths:@[indexPath]];
            }];
            break;
        }
            
        case NSFetchedResultsChangeMove: {
            [self.blockOperation addExecutionBlock:^{
                [collectionView moveItemAtIndexPath:indexPath toIndexPath:newIndexPath];
            }];
            break;
        }
            
        default:
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    // Checks if we should reload the collection view to fix a bug @ http://openradar.appspot.com/12954582
    if (self.shouldReloadCollectionView) {
        [self.collectionView reloadData];
    } else {
        [self.collectionView performBatchUpdates:^{
            [self.blockOperation start];
        } completion:nil];
    }
}


@end
