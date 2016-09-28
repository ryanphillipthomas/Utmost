//
//  LOFoodEditTableViewController.m
//  Loop
//
//  Created by Ryan Phillip Thomas on 12/30/15.
//  Copyright © 2015 Ryan Phillip Thomas. All rights reserved.
//

#import "LOActivityEditTableViewController.h"
#import "SCGoogleSearch.h"
#import "SCGoogleImage.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "LOImageSearchViewController.h"

@interface LOActivityEditTableViewController () <LOImageSearchViewControllerDelegate>
@property (nonatomic, strong) SCGoogleSearch *search;
@property (nonatomic, strong) NSString *activityMediaURL;
@end

@implementation LOActivityEditTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.leftBarButtonItem = [self closeButtonItem];
    [self setupActivityPrototype];
    [self setupViewWithFoodItem];
    [self setupAllPickerViews];
    [self setupTextFields];
    [self setupButtons];
    
    self.search = [[SCGoogleSearch alloc]initWithKey:KEY2 withCx:CX2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setActivityItem:(LOActivity *)activityItem
{
    _activityItem = activityItem;
}

- (void)setRootItem:(LORootItem *)rootItem
{
    _rootItem = rootItem;
}

- (void)setupActivityPrototype
{
    self.activityItemPrototype = [[LOActivityPrototype alloc] init];
}

- (void)setupViewWithFoodItem
{
    if (self.activityItem) {
        self.activityName.text = self.activityItem.name;
        self.activityTypeLabel.text = [self.activityItem stringForActivityType:[self.activityItem.type integerValue]];
        self.rootItemLabel.text = self.activityItem.rootItem.title;
        self.activityMediaURL = self.activityItem.mediaURL;
    } else {
        self.activityName.text = self.rootItem.title;
        self.activityTypeLabel.text = [self stringForActivityType:[self.rootItem.baseActivityType integerValue]];
        self.rootItemLabel.text = self.rootItem.title;
        self.activityMediaURL = self.rootItem.image;
    }
    self.activityCategory.text = [self.activityItem stringForActivityCategory:[self.activityItem.category integerValue]];
    self.activityLocation.text = [self.activityItem stringForActivityLocation:[self.activityItem.location integerValue]];
    
    [self.activityMediaItem sd_setImageWithURL:[NSURL URLWithString:self.activityMediaURL] placeholderImage:[UIImage imageNamed:@"placeholder"]];

}

- (void)setupAllPickerViews
{
    [self setupFoodLocationPickerView];
    [self setupFoodCategoryPickerView];
}

- (void)setupTextFields
{
    [self setInputAccessoryForTextfield:self.activityName];
    [self setInputAccessoryForTextfield:self.activityCategory];
    [self setInputAccessoryForTextfield:self.activityLocation];
    
    [self.activityCategory setInputView:self.activityCategoryPickerView];
    [self.activityCategory setInputAccessoryView:[self pickerInputAccessory]];
    [self.activityCategory setDelegate:self];
    
    [self.activityLocation setInputView:self.activityLocationPickerView];
    [self.activityLocation setInputAccessoryView:[self pickerInputAccessory]];
    [self.activityLocation setDelegate:self];
}

- (void)setupButtons
{
    if ([self formIsValid]) {
        [self.createActivityButton setEnabled:YES];
    } else {
        [self.createActivityButton setEnabled:NO];
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 1) {
        return 2;
    }
    
    return 1;
}

#pragma mark - UIPickerView DataSource
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView.tag == 0) {
        return 4;
    } else if (pickerView.tag == 1) {
        return 2;
    } else if (pickerView.tag == 2) {
        return 2;
    }
    
    return 0;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    switch (pickerView.tag) {
        case 0:
            return 1;
            break;
            
        case 1:
            return 1;
            break;
            
        case 2:
            return 1;
            
        default:
            break;
    }
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView.tag == 0) {
        return [self.activityItemPrototype stringForActivityType:row];
    } else if (pickerView.tag == 1) {
        return [self.activityItemPrototype stringForActivityCategory:row];
    } else if (pickerView.tag == 2) {
        return [self.activityItemPrototype stringForActivityLocation:row];
    }
    
    return nil;
}

#pragma mark - UIPickerView Delegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (pickerView.tag) {
        case 0:
  //          [self.activityType setText:[self.activityItemPrototype stringForActivityType:row]];
            break;
            
        case 1:
            [self.activityCategory setText:[self.activityItemPrototype stringForActivityCategory:row]];
            break;
            
        case 2:
            [self.activityLocation setText:[self.activityItemPrototype stringForActivityLocation:row]];
            break;
            
        default:
            break;
    }
}


- (UIBarButtonItem *)closeButtonItem
{
    return [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                         target:self
                                                         action:@selector(closeView:)];
}

- (IBAction)saveAndCloseView:(id)selector
{
    if ([self formIsValid]) {
        
        NSDate *activityDate = [self.activityItem date];
        NSString *rootItemID = [self.activityItem.rootItem rootItemID];
        NSNumber *activityType = self.activityItem.type;
        
        if (!rootItemID) {
            rootItemID = self.rootItem.rootItemID;
        }
        
        if (!activityDate) {
            activityDate = [NSDate date];
        }
        
        if (!activityType) {
            activityType = self.rootItem.baseActivityType;
        }
        
        if (!self.activityMediaURL) {
            self.activityMediaURL = [self.activityItem mediaURL];
        }
        
        if (self.isModifyAndReUse) {
            activityDate = [NSDate date];
        }
        
        [LOActivity createOrUpdateObject:self.activityName.text
                                    type:activityType.integerValue
                                category:[self.activityCategoryPickerView selectedRowInComponent:0]
                                location:[self.activityLocationPickerView selectedRowInComponent:0]
                                mediaURL:self.activityMediaURL
                                    date:activityDate
                              rootItemID:rootItemID
                              completion:^(BOOL success, NSManagedObjectID *objectID, NSError *error) {
                                  [self.navigationController dismissViewControllerAnimated:YES completion:nil];
                              }];
    }
}



- (void)closeView:(id)selector
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (bool)formIsValid
{
    if (self.activityName.text.length == 0) {
        return NO;
    }
    
    if (self.activityLocation.text.length == 0) {
        return NO;
    }
    
    if (self.activityCategory.text.length == 0) {
        return NO;
    }
    
    return YES;
}

- (void)setupFoodCategoryPickerView
{
    self.activityCategoryPickerView = [[UIPickerView alloc] init];
    [self.activityCategoryPickerView setTag:1];
    [self.activityCategoryPickerView setDelegate:self];
    [self.activityCategoryPickerView setDataSource:self];
    [self.activityCategoryPickerView setBackgroundColor:[UIColor whiteColor]];
    [self.activityCategoryPickerView selectRow:self.activityItem.category.integerValue inComponent:0 animated:NO];
}

- (void)setupFoodLocationPickerView
{
    self.activityLocationPickerView = [[UIPickerView alloc] init];
    [self.activityLocationPickerView setTag:2];
    [self.activityLocationPickerView setDelegate:self];
    [self.activityLocationPickerView setDataSource:self];
    [self.activityLocationPickerView setBackgroundColor:[UIColor whiteColor]];
    [self.activityLocationPickerView selectRow:self.activityItem.location.integerValue inComponent:0 animated:NO];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([self formIsValid]) {
        [self.createActivityButton setEnabled:YES];
    } else {
        [self.createActivityButton setEnabled:NO];
    }
    
    //initally set the foodMediaURL and image
    if (textField == self.activityName) {
        if (textField.text) {
            [self.search loadPicturesWithName:textField.text complition:^(NSArray<SCGoogleImage *> *objects, SCGooglePagination *pagination, NSError *failure) {
                if (objects.count > 0) {
                    SCGoogleImage *googleImage = (SCGoogleImage *)[objects firstObject];
                    [self setFoodMediaImageFromGoogleImage:googleImage];
                }
            }];
        }
    }
}

- (void)setFoodMediaImageFromGoogleImage:(SCGoogleImage *)mediaImage
{
    self.activityMediaURL = mediaImage.link;
    [self.activityMediaItem sd_setImageWithURL:[NSURL URLWithString:mediaImage.link]
                        placeholderImage:nil];
}

//LOImageSearchViewController Delegate
- (void)didSelectImage:(NSString *)imageURL
{
    self.activityMediaURL = imageURL;
    [self.activityMediaItem sd_setImageWithURL:[NSURL URLWithString:imageURL]
                          placeholderImage:nil];
}

- (void)setInputAccessoryForTextfield:(UITextField *)textfield
{
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                target:self
                                                                                action:@selector(dismiss)];
    [toolbar setItems:@[spacer, doneButton]];
    [textfield setInputAccessoryView:toolbar];
}

- (UIView *)pickerInputAccessory
{
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                target:self
                                                                                action:@selector(dismiss)];
    [toolbar setItems:@[spacer, doneButton]];
    
    return toolbar;
}

- (void)dismiss
{
    [self.activityName resignFirstResponder];
//    [self.activityType resignFirstResponder];
    [self.activityCategory resignFirstResponder];
    [self.activityLocation resignFirstResponder];
    
    if ([self formIsValid]) {
        [self.createActivityButton setEnabled:YES];
    } else {
        [self.createActivityButton setEnabled:NO];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    return YES;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    UINavigationController *navController = [segue destinationViewController];
    LOImageSearchViewController *searchImageViewController = [[navController viewControllers] objectAtIndex:0];
    [searchImageViewController setImageQueryString:self.activityName.text];
    [searchImageViewController setDelegate:self];
}

- (NSString *)stringForActivityType:(NSInteger)activityType
{
    
    switch (activityType) {
        case LOActivityTypeOther:
            return @"Other";
            break;
            
        case LOActivityTypeStrength:
            return @"Strength";
            break;
            
        case LOActivityTypeCardio:
            return @"Cardio";
            break;
            
        case LOActivityTypeFlexibility:
            return @"Flexibility";
            break;
            
        default:
            break;
    }
    
    return @"";
}



@end
