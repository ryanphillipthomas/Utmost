//
//  LOActivityViewController.h
//  Loop
//
//  Created by Ryan Phillip Thomas on 2/13/16.
//  Copyright © 2016 Ryan Phillip Thomas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LOActivityViewController : UIViewController <NSFetchedResultsControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *emptyStateView;

@end
