//
//  LOActivityViewController.m
//  Loop
//
//  Created by Ryan Phillip Thomas on 2/13/16.
//  Copyright © 2016 Ryan Phillip Thomas. All rights reserved.
//

#import "LOActivityViewController.h"
#import "LOItem.h"
#import "LOFood.h"
#import "LOActivity.h"

#import "LOAddTableViewCell.h"
#import <MagicalRecord/MagicalRecord.h>

@interface LOActivityViewController () <UISearchBarDelegate, UISearchDisplayDelegate, UISearchControllerDelegate>
@property (nonatomic) BOOL isSearching;
@property (nonatomic, strong) NSString *searchText;
@end

@implementation LOActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self fetch];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self checkForEmptyItems];
}

// register a cell reuse identifier for the search results table view
-(void)searchDisplayController:(UISearchDisplayController *)controller didLoadSearchResultsTableView:(UITableView *)tableView {
    [tableView registerClass:[LOAddTableViewCell class] forCellReuseIdentifier:@"add"];
}

#pragma mark - SearchBarDelegate

- (void)searchBar:(UISearchBar*)searchBar textDidChange:(NSString*)text
{
    _searchText = text;
    
    if (text.length == 0){
        _isSearching = NO;
    } else {
        _isSearching = YES;
    }
    
    self.fetchedResultsController = nil;
    
    [self fetch];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

// perform the search
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    
    _searchText = searchString;
    
    if (_searchText.length == 0){
        _isSearching = NO;
    } else {
        _isSearching = YES;
    }
    
    self.fetchedResultsController = nil;
    
    [self fetch];
    
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    _searchText = nil;
    
    _isSearching = NO;
    
    self.fetchedResultsController = nil;
    
    [self fetch];
}

- (void)fetch {
    NSError *error = nil;
    BOOL success = [self.fetchedResultsController performFetch:&error];
    NSAssert2(success, @"Unhandled error performing fetch at LOAddTableViewController, line %d: %@", __LINE__, [error localizedDescription]);
    [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    
    [self checkForEmptyItems];
}

- (void)checkForEmptyItems
{
    if (self.tableView.numberOfSections == 0) {
        [self.tableView setHidden:YES];
        [self.emptyStateView setHidden:NO];
    } else {
        [self.tableView setHidden:NO];
        [self.emptyStateView setHidden:YES];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        LOItem *item = (LOItem *) [self.fetchedResultsController objectAtIndexPath:indexPath];
        [LOItem deleteObjectWithDate:item.date completion:^(BOOL success, NSManagedObjectID *objectID, NSError *error) {
            //do nothing
        }];
    }
}

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController == nil) {
        NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSManagedObjectContext *context = [[MagicalRecordStack defaultStack] context];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"LOItem" inManagedObjectContext:context];
        
        if (self.isSearching && self.searchText.length > 0) {
            [fetchRequest setPredicate:[NSPredicate predicateWithFormat:LOSearchPredicate, self.searchText]];
        }
        
        [fetchRequest setEntity:entity];
        [fetchRequest setSortDescriptors:@[sort]];
        [fetchRequest setFetchBatchSize:8];
        
        _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                        managedObjectContext:context
                                                                          sectionNameKeyPath:@"stringDate"
                                                                                   cacheName:nil];
        
        _fetchedResultsController.delegate = self;
        
    }
    
    return _fetchedResultsController;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 66.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [[[self fetchedResultsController] sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LOAddTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"add"];
    [self configureCell:cell forTableView:tableView atIndexPath:indexPath];
    
    return cell;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
    [self.tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationNone];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:(LOAddTableViewCell *) [tableView cellForRowAtIndexPath:indexPath] forTableView:tableView atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray
                                               arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
            [tableView insertRowsAtIndexPaths:[NSArray
                                               arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationNone];
            break;
    }
}

- (void)configureCell:(LOAddTableViewCell *)cell forTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    LOItem *item = nil;
    //** TODO Confirm: Testing bounds check on objectAtIndexPath method for frc **//
    if ([[self.fetchedResultsController sections] count] >= [indexPath section]){
        id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:[indexPath section]];
        if ([sectionInfo numberOfObjects] >= [indexPath row]){
            item = (LOItem *) [self.fetchedResultsController objectAtIndexPath:indexPath];
            
            NSString *locationString;
            NSString *categoryString;
            NSString *typeString;
            NSString *mediaURL;
            NSString *name;

            
            if (item.food) {
                locationString =  [NSString stringWithFormat:@"%@",[item.food stringForFoodLocation:[item.food.location integerValue]]];
                categoryString =  [NSString stringWithFormat:@"%@",[item.food stringForFoodCategories:item.food.categories]];
                typeString =  [NSString stringWithFormat:@"%@",[item.food stringForFoodType:[item.food.type integerValue]]];
                mediaURL = item.food.mediaURL;
                name = item.food.name;
            } else {
                locationString =  [NSString stringWithFormat:@"%@",[item.activity stringForActivityLocation:[item.activity.location integerValue]]];
                categoryString =  [NSString stringWithFormat:@"%@",[item.activity stringForActivityCategory:[item.activity.category integerValue]]];
                typeString =  [NSString stringWithFormat:@"%@",[item.activity stringForActivityType:[item.activity.type integerValue]]];
                mediaURL = item.activity.mediaURL;
                name = item.activity.name;
            }
            
            [cell configureCellWithImageString:mediaURL forTitle:name
                                  withSubtitle:[NSString stringWithFormat:@"%@, %@, %@", typeString, categoryString, locationString]];
            
        }
    }
}



- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id )sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationNone];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationNone];
            break;
            
        default:
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 29.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    float width = tableView.bounds.size.width;
    int fontSize = 14;
    int padding = 10;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, fontSize + 2)];
    view.backgroundColor = [UIColor colorWithRed:0.965f green:0.965f blue:0.965f alpha:1.00f];
    view.userInteractionEnabled = YES;
    view.tag = section;
    
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Section Header Divider"]];
    image.contentMode = UIViewContentModeScaleToFill;
    image.frame = CGRectMake(0, 0, width, 1);
    [view addSubview:image];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(padding, 7, width - padding, fontSize + 2)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor colorWithRed:0.600f green:0.600f blue:0.604f alpha:1.00f];
    label.font = [UIFont fontWithName:@"Avenir-Roman" size:fontSize];
    
    id <NSFetchedResultsSectionInfo> sectionInfo = [[[self fetchedResultsController] sections] objectAtIndex:section];
    
    if ([tableView isEqual:self.tableView]) {
        label.text = sectionInfo.name;
    }
    
    [view addSubview:label];
    
    return view;
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller has sent all current change notifications, so tell the table view to process all updates.
    [self.tableView endUpdates];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
