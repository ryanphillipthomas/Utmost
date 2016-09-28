//
//  LOAddTableViewController.h
//  Loop
//
//  Created by Ryan Phillip Thomas on 12/5/15.
//  Copyright © 2015 Ryan Phillip Thomas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LOFood.h"
#import "LOItem.h"
#import "LORootItem.h"
#import "LOActivity.h"

@interface LOAddTableViewController : UITableViewController <NSFetchedResultsControllerDelegate, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) LOItem *selectedItem;
@property (nonatomic, strong) LORootItem *selectedRootItem;
@end
