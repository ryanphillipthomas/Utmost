//
//  LOFoodEditTableViewController.h
//  Loop
//
//  Created by Ryan Phillip Thomas on 12/30/15.
//  Copyright © 2015 Ryan Phillip Thomas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LOFood.h"
#import "LORootItem.h"
#import "LOFoodPrototype.h"

@interface LOFoodEditTableViewController : UITableViewController <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *foodName;
@property (weak, nonatomic) IBOutlet UITextField *foodCategory;
@property (weak, nonatomic) IBOutlet UITextField *foodLocation;
@property(nonatomic, strong) NSString *mediaURL;

@property (weak, nonatomic) IBOutlet UILabel *rootItemLabel;
@property (weak, nonatomic) IBOutlet UILabel *foodTypeLabel;

@property (strong, nonatomic) UIPickerView *foodCategoryPickerView;
@property (strong, nonatomic) UIPickerView *foodLocationPickerView;

@property (weak, nonatomic) IBOutlet UIImageView *foodMediaItem;
@property (weak, nonatomic) IBOutlet UIButton *createFoodButton;

@property (strong, nonatomic) LORootItem *rootItem;
@property (strong, nonatomic) LOFood *foodItem;
@property (strong, nonatomic) LOFoodPrototype *foodItemPrototype;

@property (strong, nonatomic) IBOutletCollection(UISwitch) NSArray *categorySwitches;
@property (strong, nonatomic) NSMutableArray *categorySwitchSelections;

@property (nonatomic) BOOL isModifyAndReUse;

@end
