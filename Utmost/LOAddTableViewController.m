//
//  LOAddTableViewController.m
//  Loop
//
//  Created by Ryan Phillip Thomas on 12/5/15.
//  Copyright © 2015 Ryan Phillip Thomas. All rights reserved.
//

#import "LOAddTableViewController.h"
#import "LOAddTableViewCell.h"
#import "LOActivityEditTableViewController.h"
#import "LOFoodEditTableViewController.h"
#import "LOVisualAddFoodViewController.h"

@interface LOAddTableViewController () <UISearchBarDelegate, UISearchDisplayDelegate, UISearchControllerDelegate, UISearchResultsUpdating>
@property (nonatomic) BOOL isSearching;
@property (nonatomic, strong) NSString *searchText;
@property (nonatomic, strong) UITextField *addItemTextField;
@property (nonatomic, strong) UISearchController * searchController;
@property (nonatomic, strong) UISearchBar * searchBar;

//

@property (nonatomic, strong) NSMutableArray * filteredItems;
@property (nonatomic, weak) NSArray * displayedItems;
@end

@implementation LOAddTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    
    self.title = @"Add Item";
    self.navigationItem.leftBarButtonItem = [self closeButtonItem];
    
    // Here's where we create our UISearchController
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    [self.searchController.searchBar setPlaceholder:@"Start typing food or activity name."];
    [self.searchController setDelegate:self];
    self.searchController.searchResultsUpdater = self;
    self.searchController.searchBar.delegate = self;
    [self.searchController setDimsBackgroundDuringPresentation:NO];
    
    [self.searchController.searchBar sizeToFit];
    
    // Add the UISearchBar to the top header of the table view
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    self.searchBar = self.searchController.searchBar;
    
    // Hides search bar initially.  When the user pulls down on the list, the search bar is revealed.
    //[self.tableView setContentOffset:CGPointMake(0, self.searchController.searchBar.frame.size.height)];
    
    self.fetchedResultsController = nil;

    [self fetch];
   // [self checkForEmptyItems];
    [self showSearchController];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.fetchedResultsController = nil;
    [self fetch];
}

- (void)showSearchController
{
    [self.searchController setActive:YES];
}

- (void)hideSearchController
{
    [self.searchBar resignFirstResponder];
    [self.searchController setActive:NO];
}

- (void)didPresentSearchController:(UISearchController *)searchController
{
    [searchController.searchBar becomeFirstResponder];
}

// When the user types in the search bar, this method gets called.
- (void)updateSearchResultsForSearchController:(UISearchController *)aSearchController {
    NSLog(@"updateSearchResultsForSearchController");
    
    NSString *searchString = aSearchController.searchBar.text;
    NSLog(@"searchString=%@", searchString);
    
    _searchText = searchString;
    
    if (_searchText.length == 0){
        _isSearching = NO;
    } else {
        _isSearching = YES;
    }
    
    self.fetchedResultsController = nil;
    
    [self fetch];
    
}

- (void)checkForEmptyItems
{
    if (self.tableView.numberOfSections == 1) {
        [self createNewItem:nil];
    }
}

//#pragma mark - UISearchDisplayDelegate
// register a cell reuse identifier for the search results table view
//-(void)searchDisplayController:(UISearchDisplayController *)controller didLoadSearchResultsTableView:(UITableView *)tableView {
//    [tableView registerClass:[LOAddTableViewCell class] forCellReuseIdentifier:@"add"];
//}

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
//-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    
//    _searchText = searchString;

//    if (_searchText.length == 0){
//        _isSearching = NO;
//    } else {
//        _isSearching = YES;
//    }
    
//    self.fetchedResultsController = nil;
    
//    [self fetch];
    
//    return YES;
//}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    _searchText = nil;

    _isSearching = NO;
    
    self.fetchedResultsController = nil;
    
    [self fetch];
    
    [searchBar resignFirstResponder];
}

- (void)createNewActivityItem
{
    self.selectedItem = nil; //clear out any previous selections

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle: [NSString stringWithFormat:@"Rename %@?", self.selectedRootItem.title] message:[NSString stringWithFormat:@"We recommend providing unique names for items. If you leave this blank we will use the name: %@", self.selectedRootItem.title] preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = [NSString stringWithFormat:@"Example: Morning Commute"];
        self.addItemTextField = textField;
    }];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [self displayUnsavedActivityChangesAlert];
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Next" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self performSegueWithIdentifier:@"Activity Edit" sender:nil]; //**todo
    }]];
    
    [self presentViewController:alertController animated:YES completion:^{
        //
    }];
}

- (IBAction)createNewItem:(id)sender
{
    if ([self.selectedRootItem.itemTypeString isEqualToString:@"Food"]) {
        [self createNewFoodItem];
    } else {
        [self createNewActivityItem];
    }
}

- (void)reUseActivityItem:(id)selector
{
    [LOActivity createOrUpdateObject:self.selectedItem.activity.name
                                type:[self.selectedItem.activity.type integerValue]
                            category:[self.selectedItem.activity.category integerValue]
                            location:[self.selectedItem.activity.location integerValue]
                            mediaURL:self.selectedItem.activity.mediaURL
                                date:[NSDate date]
                          rootItemID:self.selectedItem.activity.rootItem.rootItemID
                          completion:^(BOOL success, NSManagedObjectID *objectID, NSError *error) {
                              self.selectedItem = nil; //clear out any previous selections
                          }];
}

- (void)createNewFoodItem
{
    self.selectedItem = nil; //clear out any previous selections
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle: [NSString stringWithFormat:@"Rename %@?", self.selectedRootItem.title] message:[NSString stringWithFormat:@"We recommend providing unique names for items. If you leave this blank we will use the name: %@", self.selectedRootItem.title] preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = [NSString stringWithFormat:@"Example: Grandma's %@", self.selectedRootItem.title];
        self.addItemTextField = textField;
    }];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [self displayUnsavedFoodChangesAlert];
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Next" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self performSegueWithIdentifier:@"Food Visual Creation" sender:nil]; //**tod
    }]];
    
    [self presentViewController:alertController animated:YES completion:^{
    //
    }];
}

- (void)displayUnsavedFoodChangesAlert
{
    UIAlertController *view = [UIAlertController
                               alertControllerWithTitle:@"Warning!"
                               message:@"Changes you have made will not be saved. Press OK to discard changes or Cancel to continue editing."
                               preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction
                             actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleCancel
                             handler:^(UIAlertAction * action)
                             {
                                 [view dismissViewControllerAnimated:YES completion:nil];
                                 [self createNewFoodItem];
                                 
                             }];
    
    UIAlertAction *ok = [UIAlertAction
                         actionWithTitle:@"Ok"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [view dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    
    [view addAction:cancel];
    [view addAction:ok];
    
    [self presentViewController:view animated:YES completion:nil];
}

- (void)displayUnsavedActivityChangesAlert
{
    UIAlertController *view = [UIAlertController
                               alertControllerWithTitle:@"Warning!"
                               message:@"Changes you have made will not be saved. Press OK to discard changes or Cancel to continue editing."
                               preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction
                             actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleCancel
                             handler:^(UIAlertAction * action)
                             {
                                 [view dismissViewControllerAnimated:YES completion:nil];
                                 [self createNewActivityItem];
                                 
                             }];
    
    UIAlertAction *ok = [UIAlertAction
                         actionWithTitle:@"Ok"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [view dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    
    [view addAction:cancel];
    [view addAction:ok];
    
    [self presentViewController:view animated:YES completion:nil];
}

- (void)reUseFoodItem:(id)selector
{
    [LOFood createOrUpdateObject:self.selectedItem.food.name
                            type:[self.selectedItem.food.type integerValue]
                        categories:self.selectedItem.food.categories
                        location:[self.selectedItem.food.location integerValue]
                        mediaURL:self.selectedItem.food.mediaURL
                            date:[NSDate date]
                      rootItemID:self.selectedItem.food.rootItem.rootItemID
                      completion:^(BOOL success, NSManagedObjectID *objectID, NSError *error) {
                          self.selectedItem = nil; //clear out any previous selections
                      }];
}

- (IBAction)didSelectAddActionOnExistingItem:(id)sender {
    //derives from cell...
}

- (void)fetch {
    NSError *error = nil;
    BOOL success = [self.fetchedResultsController performFetch:&error];
    NSAssert2(success, @"Unhandled error performing fetch at LOAddTableViewController, line %d: %@", __LINE__, [error localizedDescription]);
    [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
}

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController == nil) {
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSManagedObjectContext *context = [[MagicalRecordStack defaultStack] context];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"LOItem" inManagedObjectContext:context];
        NSString *sectionNameKeyPath;
        if (self.isSearching && self.searchText.length > 0) {
            entity = [NSEntityDescription entityForName:@"LORootItem" inManagedObjectContext:context];
            [fetchRequest setPredicate:[NSPredicate predicateWithFormat:LOSearchTitlePredicate, self.searchText]];
            sectionNameKeyPath = @"itemTypeString";
            //
            NSSortDescriptor *itemSort = [[NSSortDescriptor alloc] initWithKey:@"rootItemID" ascending:NO];
            NSSortDescriptor *typeSort = [[NSSortDescriptor alloc] initWithKey:@"itemTypeString" ascending:NO];
            [fetchRequest setSortDescriptors:@[typeSort, itemSort]];
        } else {
            NSSortDescriptor *date = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
            NSSortDescriptor *dateSort = [[NSSortDescriptor alloc] initWithKey:@"sectionDate" ascending:NO];
            [fetchRequest setSortDescriptors:@[date, dateSort]];
            sectionNameKeyPath = @"sectionDate";
        }
        
        [fetchRequest setEntity:entity];
        [fetchRequest setFetchBatchSize:8];
        
        _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                        managedObjectContext:context
                                                                          sectionNameKeyPath:sectionNameKeyPath
                                                                                   cacheName:nil];
        
        _fetchedResultsController.delegate = self;
        
    }

    return _fetchedResultsController;
}

- (UIBarButtonItem *)closeButtonItem
{
    return [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                         target:self
                                                         action:@selector(closeView:)];
}

- (void)closeView:(id)selector
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)checkButtonTapped:(id)sender event:(id)event{
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint: currentTouchPosition];
    if (indexPath != nil){
        [self tableView: self.tableView accessoryButtonTappedForRowWithIndexPath: indexPath];
    }
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(nonnull NSIndexPath *)indexPath
{
    //consider checing class and changing item
    self.selectedItem = (LOItem *) [self.fetchedResultsController objectAtIndexPath:indexPath];
    [self hideSearchController];
    [self displayItemDetailOptions];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [[[self fetchedResultsController] sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;

    if (self.isSearching && self.searchText.length > 0) {
        cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        }
        [self configureRootItemCell:cell forTableView:tableView atIndexPath:indexPath];
    } else {
        LOAddTableViewCell *addCell;
        addCell = (LOAddTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:@"add"];

        // set the button's target to this table view controller so we can interpret touch events and map that to a NSIndexSet

        UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
        [button setTintColor:kLIGHT_BLUE_COLOR];
        [button addTarget:self action:@selector(checkButtonTapped:event:) forControlEvents:UIControlEventTouchUpInside];
        
        addCell.accessoryView = button;
        
        [self configureItemCell:addCell forTableView:tableView atIndexPath:indexPath];
        
        cell = addCell;
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isSearching && self.searchText.length > 0) {
        return 44.0f;
    }
    
    return 66.0f;
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
            [self configureItemCell:(LOAddTableViewCell *) [tableView cellForRowAtIndexPath:indexPath] forTableView:tableView atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray
                                               arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
            [tableView insertRowsAtIndexPaths:[NSArray
                                               arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationNone];
            break;
    }
}

- (void)configureRootItemCell:(UITableViewCell *)cell forTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    LORootItem *rootItem = nil;
    
    //** TODO Confirm: Testing bounds check on objectAtIndexPath method for frc **//
    if ([[self.fetchedResultsController sections] count] >= [indexPath section]){
        id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:[indexPath section]];
        if ([sectionInfo numberOfObjects] >= [indexPath row]){
            rootItem = (LORootItem *) [self.fetchedResultsController objectAtIndexPath:indexPath];
            
            [cell.textLabel setText:rootItem.title];
        }
    }
}


- (void)configureItemCell:(LOAddTableViewCell *)cell forTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
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
                    categoryString =  [NSString stringWithFormat:@"%@",[item.food stringForFoodCategories:(NSArray *)item.food.categories]];
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
                
                [cell configureCellWithImageString:mediaURL
                                          forTitle:name
                                      withSubtitle:[NSString stringWithFormat:@"%@, %@ %@", typeString, categoryString, locationString]];
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

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (![[self.fetchedResultsController.fetchedObjects firstObject] isKindOfClass:[LORootItem class]]) {
        [self hideSearchController];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[self.fetchedResultsController objectAtIndexPath:indexPath] isKindOfClass:[LORootItem class]]) {
        self.selectedRootItem = (LORootItem *) [self.fetchedResultsController objectAtIndexPath:indexPath];
        [self hideSearchController];
        [self createNewItem:nil];
    } else {
        self.selectedItem = (LOItem *) [self.fetchedResultsController objectAtIndexPath:indexPath];
        [self hideSearchController];
        
        if (self.selectedItem.food) {
             [self performSegueWithIdentifier:@"Food Edit" sender:nil];
        } else {
            [self performSegueWithIdentifier:@"Activity Edit" sender:nil];
        }
        
//        [self displayItemDetailOptions];

    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Food Edit"]) {
        UINavigationController *navController = [segue destinationViewController];
        LOFoodEditTableViewController *editView = [[navController viewControllers] objectAtIndex:0];
        if (self.selectedItem) {
            [editView setFoodItem:self.selectedItem.food];
        } else {
            [editView setFoodItem:nil];
        }
    }
    
    if ([segue.identifier isEqualToString:@"Food Edit & Modify"]) {
        UINavigationController *navController = [segue destinationViewController];
        LOFoodEditTableViewController *editView = [[navController viewControllers] objectAtIndex:0];
        [editView setIsModifyAndReUse:YES];
        if (self.selectedItem) {
            [editView setFoodItem:self.selectedItem.food];
        } else {
            [editView setFoodItem:nil];
        }
    }
    
    if ([segue.identifier isEqualToString:@"Activity Edit"]) {
        UINavigationController *navController = [segue destinationViewController];
        LOActivityEditTableViewController *editView = [[navController viewControllers] objectAtIndex:0];
        if (self.selectedItem) {
            [editView setActivityItem:self.selectedItem.activity];
        } else {
            
//            if (self.selectedRootItem.image.length > 0) {
//                [editView setScreenMediaURL:self.selectedRootItem.image];
//            }
            
            [editView setRootItem:self.selectedRootItem];
            [editView setActivityItem:nil];
        }
    }
    
    if ([segue.identifier isEqualToString:@"Activity Edit & Modify"]) {
        UINavigationController *navController = [segue destinationViewController];
        LOActivityEditTableViewController *editView = [[navController viewControllers] objectAtIndex:0];
        [editView setIsModifyAndReUse:YES];
        if (self.selectedItem) {
            [editView setActivityItem:self.selectedItem.activity];
        } else {
            [editView setActivityItem:nil];
        }
    }
    
    if ([segue.identifier isEqualToString:@"Food Visual Creation"]) {
        UINavigationController *navController = [segue destinationViewController];
        LOVisualAddFoodViewController *visualAddView = (LOVisualAddFoodViewController *)[[navController viewControllers] objectAtIndex:0];
        NSString *visualFoodStringName = self.addItemTextField.text;
        
        if (!(visualFoodStringName.length > 0)) {
            visualFoodStringName = self.selectedRootItem.title;
        }
        
        if (self.selectedRootItem.image.length > 0) {
            [visualAddView setScreenMediaURL:self.selectedRootItem.image];
        }
        
        [visualAddView setScreenFoodName:[visualFoodStringName lowercaseString]];
        [visualAddView setScreenQuestion:[NSString stringWithFormat:@"The %@ was", [visualFoodStringName lowercaseString]]];
        [visualAddView setRootItem:self.selectedRootItem];
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
    
    NSString *rawDateStr = [[[self.fetchedResultsController sections] objectAtIndex:section] name];

    if ([tableView isEqual:self.tableView]) {
        if ([rawDateStr isEqualToString:@"Food"] || [rawDateStr isEqualToString:@"Activity"]) {
            label.text = rawDateStr;
        } else {
            label.text = [self stringDateForDate:rawDateStr];
        }
    }
    
    [view addSubview:label];
    
    return view;
}


//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
//    NSString *rawDateStr = [[[self.fetchedResultsController sections] objectAtIndex:section] name];
//    return [self stringDateForDate:rawDateStr];
//}

- (NSString *)stringDateForDate:(NSString *)rawDateStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss ZZZ"];
    
    NSDate *date = [dateFormatter dateFromString:rawDateStr];
    
    [dateFormatter setDateFormat:@"EEEE MMM d yyyy"];

    NSString *formattedDateStr = [dateFormatter stringFromDate:date];
    
    return formattedDateStr;
}

- (void)displayItemCreationOptions
{
    
    NSString *title = [NSString stringWithFormat:@"Would you like to create a new food or activity item?"];
    
    UIAlertController *view = [UIAlertController
                               alertControllerWithTitle:title
                               message:nil
                               preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *food = [UIAlertAction
                            actionWithTitle:@"Food"
                            style:UIAlertActionStyleDefault
                            handler:^(UIAlertAction * action)
                            {
                                [self createNewFoodItem];
                                [view dismissViewControllerAnimated:YES completion:nil];
                                
                            }];
    
    UIAlertAction *activity = [UIAlertAction
                                     actionWithTitle:@"Activity"
                                     style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction * action)
                                     {
                                         [self createNewActivityItem];
                                         [view dismissViewControllerAnimated:YES completion:nil];
                                         
                                     }];
    
    UIAlertAction *cancel = [UIAlertAction
                             actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleCancel
                             handler:^(UIAlertAction * action)
                             {
                                 [view dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    
    
    [view addAction:food];
    [view addAction:activity];
    [view addAction:cancel];
    
    [self presentViewController:view animated:YES completion:nil];
}

- (void)displayItemDetailOptions
{
    NSString *title;
    NSString *reuseTitle;
    NSString *modifyAndReuseTitle;

    if (self.selectedItem.food) {
        title = [NSString stringWithFormat:@"Create A New %@ Item", self.selectedItem.food.name];
        reuseTitle = [NSString stringWithFormat:@"Re-Use %@", self.selectedItem.food.name];
        modifyAndReuseTitle = [NSString stringWithFormat:@"Modify & Re-Use %@", self.selectedItem.food.name];
    } else {
        title = [NSString stringWithFormat:@"Create A New %@ Item", self.selectedItem.activity.name];
        reuseTitle = [NSString stringWithFormat:@"Re-Use %@", self.selectedItem.activity.name];
        modifyAndReuseTitle = [NSString stringWithFormat:@"Modify & Re-Use %@", self.selectedItem.activity.name];
    }
    
    UIAlertController *view = [UIAlertController
                                 alertControllerWithTitle:title
                                 message:nil
                                 preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *reuse = [UIAlertAction
                         actionWithTitle:reuseTitle
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             if (self.selectedItem.food) {
                                 [self reUseFoodItem:nil];
                             } else {
                                 [self reUseActivityItem:nil];
                             }
                             
                             [view dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    
    UIAlertAction *modifyAndReuse = [UIAlertAction
                            actionWithTitle:modifyAndReuseTitle
                            style:UIAlertActionStyleDefault
                            handler:^(UIAlertAction * action)
                            {
                                if (self.selectedItem.food) {
                                    [self performSegueWithIdentifier:@"Food Edit & Modify" sender:nil];
                                } else {
                                    [self performSegueWithIdentifier:@"Activity Edit & Modify" sender:nil];
                                }
                                
                                [view dismissViewControllerAnimated:YES completion:nil];
                                
                            }];
    
    UIAlertAction *cancel = [UIAlertAction
                             actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleCancel
                             handler:^(UIAlertAction * action)
                             {
                                 self.selectedItem = nil;
                                 [view dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    
    [view addAction:reuse];
    [view addAction:modifyAndReuse];
    [view addAction:cancel];
    
    [self presentViewController:view animated:YES completion:nil];
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller has sent all current change notifications, so tell the table view to process all updates.
    [self.tableView endUpdates];
}

@end
