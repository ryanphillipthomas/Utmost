//
//  LOHomeTableViewController.m
//  Loop
//
//  Created by Ryan Phillip Thomas on 11/1/15.
//  Copyright © 2015 Ryan Phillip Thomas. All rights reserved.
//

#import "LOHomeTableViewController.h"
#import "LONewsArticleData.h"
#import "LOWeekDetailViewController.h"
#import "NSDate+Utilities.h"

@interface LOHomeTableViewController ()

@end

@implementation LOHomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    //clear out nav bar
    [self.navBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navBar setShadowImage:[[UIImage alloc] init]];
    
    [self.tableView registerClass:[LONewsContainerCell class] forCellReuseIdentifier:@"news"];
    
    // Add observer that will allow the nested collection cell to trigger the view controller select row at index path
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelectItemFromMapCell:) name:@"didSelectItemFromMapCell" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelectItemFromCollectionView:) name:@"didSelectItemFromCollectionView" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelectItemFromBarGraphView:) name:@"didSelectItemFromBarGraphView" object:nil];
    
 //   [self refreshHomeData];
    
    self.tableView.separatorColor = [UIColor clearColor];
}

- (void)updateNavigationControllerStyle
{

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refreshHomeData];
}

- (void)refreshHomeData
{
    [self performSelectorInBackground:@selector(refreshNewsItems) withObject:nil];
    [self performSelectorInBackground:@selector(refreshMapItems) withObject:nil];
}

- (LONewsArticleData *)newsData
{
    if (!_newsData) {
        _newsData = [[LONewsArticleData alloc] init];
    }
    
    return _newsData;
}

- (LOMapLocationData *)mapData
{
    if (!_mapData) {
        _mapData = [[LOMapLocationData alloc] init];
    }
    
    return _mapData;
}

- (void)refreshNewsItems {
    [[self newsData] startParsingWithCompletion:^(BOOL performed) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        //todo check items for count and display empty status if applicable
    }];
}

- (void)refreshMapItems {
    [[self mapData] startParsingWithCompletion:^(BOOL performed) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });        //todo check items for count and display empty status if applicable
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 210;
    } else if (indexPath.row == 2) {
        return 170;
    }
    
    return 205;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
    LOHomeChartTableViewCell *chartCell;
    LONewsContainerCell *newsCell;
    LOHomeMapTableViewCell *mapCell;

    if (indexPath.row == 0) {
        chartCell = (LOHomeChartTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"chart" forIndexPath:indexPath];
        NSString *dateString = [[NSDate date] stringWithDateStyle:NSDateFormatterFullStyle timeStyle:NSDateFormatterNoStyle];
        [chartCell configureCellWithData:@[] withLabel:dateString];
        [chartCell setDelegate:self];
        cell = chartCell;
    }
    else if (indexPath.row == 1) {
        mapCell = [tableView dequeueReusableCellWithIdentifier:@"map" forIndexPath:indexPath];
        [mapCell configureCell];
        cell = mapCell;
    } else if (indexPath.row == 2) {
        newsCell = [tableView dequeueReusableCellWithIdentifier:@"news" forIndexPath:indexPath];
//        [newsCell setCollectionData:[self newsArticleDataArray]];
        cell = newsCell;
    }
    
    return cell;
}

- (NSArray *)newsArticleDataArray
{
    if ([[self newsData] marrXMLData].count > 0) {
        return [[self newsData] marrXMLData];
    }
    
    return nil;
}

#pragma mark - NSNotification to select table cell

- (void)didSelectItemFromMapCell:(NSNotification *)notification
{
    [self performSegueWithIdentifier:@"Map Detail" sender:[notification object]];
}

- (void)didSelectItemFromCollectionView:(NSNotification *)notification
{
    [self performSegueWithIdentifier:@"News Detail" sender:[notification object]];
}

- (void)didSelectItemFromBarGraphView:(NSNotification *)notification {
//    NSUInteger index = [[[notification userInfo] valueForKey:@"index"] unsignedIntegerValue];
//    [self performSegueWithIdentifier:@"Week Detail" sender:[notification object]];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"News Detail"]) {
        NSDictionary *cellData = sender;
        UINavigationController *navController = [segue destinationViewController];
        LONewsDetailViewController *detailView = [[navController viewControllers] objectAtIndex:0];
        [detailView setDetailItem:cellData];
    }
    
    if ([segue.identifier isEqualToString:@"News Detail"]) {
        NSDictionary *cellData = sender;
        UINavigationController *navController = [segue destinationViewController];
        LONewsDetailViewController *detailView = [[navController viewControllers] objectAtIndex:0];
        [detailView setDetailItem:cellData];
    }
    
    if ([segue.identifier isEqualToString:@"Last Week Detail"]) {
        UINavigationController *navController = [segue destinationViewController];
        LOWeekDetailViewController *detailView = [[navController viewControllers] objectAtIndex:0];
        [detailView setIsLastWeek:YES];
    }
    
    if ([segue.identifier isEqualToString:@"This Week Detail"]) {
        UINavigationController *navController = [segue destinationViewController];
        LOWeekDetailViewController *detailView = [[navController viewControllers] objectAtIndex:0];
        [detailView setIsThisWeek:YES];
    }
}

- (void)didSelectLastWeek:(id)sender
{
    [self performSegueWithIdentifier:@"Last Week Detail" sender:nil];
}

- (void)didSelectThisWeek:(id)sender
{
    [self performSegueWithIdentifier:@"This Week Detail" sender:nil];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
