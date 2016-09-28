//
//  LOFoodEditTableViewController.m
//  Loop
//
//  Created by Ryan Phillip Thomas on 12/30/15.
//  Copyright © 2015 Ryan Phillip Thomas. All rights reserved.
//

#import "LOFoodEditTableViewController.h"
#import "SCGoogleSearch.h"
#import "SCGoogleImage.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "LOImageSearchViewController.h"

@interface LOFoodEditTableViewController () <LOImageSearchViewControllerDelegate>
@property (nonatomic, strong) SCGoogleSearch *search;
@property (nonatomic, strong) NSString *foodMediaURL;
@end

@implementation LOFoodEditTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.leftBarButtonItem = [self closeButtonItem];
    [self setupFoodPrototype];
    [self setupViewWithFoodItem];
    [self setupAllPickerViews];
    [self setupTextFields];
    [self setupButtons];
    [self setupCategorySwitchSelections];
    [self updateCategorySwitches];
    
    self.search = [[SCGoogleSearch alloc]initWithKey:KEY2 withCx:CX2];
}

- (void)setupCategorySwitchSelections
{
    self.categorySwitchSelections = [NSMutableArray arrayWithArray:(NSArray *)self.foodItem.categories];
}

- (void)updateCategorySwitches
{
    for (UISwitch *categorySwitch in self.categorySwitches) {
        [categorySwitch setOn:NO];
    }
    
    for (NSNumber *number in self.categorySwitchSelections) {
        UISwitch *categorySwitch = [self.categorySwitches objectAtIndex:[number integerValue]];
        
        [categorySwitch setOn:YES];
    }
}

- (IBAction)didSelectSwitch:(id)sender
{
    NSNumber *switchSelection = [NSNumber numberWithInteger:[sender tag]];
    
    if ([sender isOn]) {
        if (![self.categorySwitchSelections containsObject:switchSelection]) {
            [self.categorySwitchSelections addObject:switchSelection];
        }
    } else {
        if ([self.categorySwitchSelections containsObject:switchSelection]) {
            [self.categorySwitchSelections removeObject:switchSelection];
        }
    }
    
    [self updateCategorySwitches];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setFoodItem:(LOFood *)foodItem
{
    _foodItem = foodItem;
}

- (void)setRootItem:(LORootItem *)rootItem
{
    _rootItem = rootItem;
}

- (void)setupFoodPrototype
{
    self.foodItemPrototype = [[LOFoodPrototype alloc] init];
}

- (void)setupViewWithFoodItem
{
    self.foodName.text = self.foodItem.name;
    //self.foodCategory.text = [self.foodItem stringForFoodCategories:self.foodItem.categories];
    self.foodLocation.text = [self.foodItem stringForFoodLocation:[self.foodItem.location integerValue]];
    self.foodTypeLabel.text = [self.foodItem stringForFoodType:[self.foodItem.type integerValue]];
    self.rootItemLabel.text = self.foodItem.rootItem.title;
    
    [self.foodMediaItem sd_setImageWithURL:[NSURL URLWithString:self.foodItem.mediaURL] placeholderImage:[UIImage imageNamed:@"placeholder"]];
}

- (void)setupAllPickerViews
{
    [self setupFoodLocationPickerView];
}

- (void)setupTextFields
{
    [self setInputAccessoryForTextfield:self.foodName];
    [self setInputAccessoryForTextfield:self.foodLocation];
    
    [self.foodLocation setInputView:self.foodLocationPickerView];
    [self.foodLocation setInputAccessoryView:[self pickerInputAccessory]];
    [self.foodLocation setDelegate:self];
}

- (void)setupButtons
{
    if ([self formIsValid]) {
        [self.createFoodButton setEnabled:YES];
    } else {
        [self.createFoodButton setEnabled:NO];
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
    
    if (section == 3) {
        return 7;
    }
    
    
    return 1;
}

#pragma mark - UIPickerView DataSource
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView.tag == 1) {
        return 7;
    } else if (pickerView.tag == 2) {
        return 2;
    }
    
    return 0;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    switch (pickerView.tag) {
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
    if (pickerView.tag == 1) {
        return [self.foodItemPrototype stringForFoodType:row];
    } else if (pickerView.tag == 2) {
        return [self.foodItemPrototype stringForFoodLocation:row];
    }
    
    return nil;
}

#pragma mark - UIPickerView Delegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (pickerView.tag) {
        case 1:
 //           [self.foodType setText:[self.foodItemPrototype stringForFoodType:row]];
            break;
            
        case 2:
            [self.foodLocation setText:[self.foodItemPrototype stringForFoodLocation:row]];
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
        
        NSDate *foodDate = [self.foodItem date];
        
        NSString *rootItemID = [self.foodItem.rootItem rootItemID];
        
        NSNumber *foodType = self.foodItem.type;
        
        if (!self.foodMediaURL) {
            self.foodMediaURL = [self.foodItem mediaURL];
        }
        
        if (self.isModifyAndReUse) {
            foodDate = [NSDate date];
        }
        
        [LOFood createOrUpdateObject:self.foodName.text
                                type:foodType.integerValue
                            categories:self.categorySwitchSelections
                            location:[self.foodLocationPickerView selectedRowInComponent:0]
                            mediaURL:self.foodMediaURL
                                date:foodDate
                          rootItemID:rootItemID
                          completion:^(BOOL success, NSManagedObjectID *objectID, NSError *error) {
                              [self.navigationController dismissViewControllerAnimated:YES completion:nil];
                          }];
    }
}

//TODO
- (NSInteger)foodTypeForString:(NSString *)foodTypeString {
    if ([foodTypeString isEqualToString:@"LOFoodTypeOther"]) {
        return LOFoodTypeOther;
    }
    if ([foodTypeString isEqualToString:@"LOFoodTypeRedProtein"]) {
        return LOFoodTypeRedProtein;
    }
    if ([foodTypeString isEqualToString:@"LOFoodTypeWhiteProtein"]) {
        return LOFoodTypeWhiteProtein;
    }
    if ([foodTypeString isEqualToString:@"LOFoodTypeNut"]) {
        return LOFoodTypeNut;
    }
    if ([foodTypeString isEqualToString:@"LOFoodTypeFruit"]) {
        return LOFoodTypeFruit;
    }
    if ([foodTypeString isEqualToString:@"LOFoodTypeVegetable"]) {
        return LOFoodTypeVegetable;
    }
    if ([foodTypeString isEqualToString:@"LOFoodTypePlantProtein"]) {
        return LOFoodTypePlantProtein;
    }
    
    return LOFoodTypeOther;
}


- (void)closeView:(id)selector
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (bool)formIsValid
{
    if (self.foodName.text.length == 0) {
        return NO;
    }
    
    if (self.foodLocation.text.length == 0) {
        return NO;
    }
    
    return YES;
}

- (void)setupFoodLocationPickerView
{
    self.foodLocationPickerView = [[UIPickerView alloc] init];
    [self.foodLocationPickerView setTag:2];
    [self.foodLocationPickerView setDelegate:self];
    [self.foodLocationPickerView setDataSource:self];
    [self.foodLocationPickerView setBackgroundColor:[UIColor whiteColor]];
    [self.foodLocationPickerView selectRow:self.foodItem.location.integerValue inComponent:0 animated:NO];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([self formIsValid]) {
        [self.createFoodButton setEnabled:YES];
    } else {
        [self.createFoodButton setEnabled:NO];
    }
    
    //initally set the foodMediaURL and image
    if (textField == self.foodName) {
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
    self.foodMediaURL = mediaImage.link;
    [self.foodMediaItem sd_setImageWithURL:[NSURL URLWithString:mediaImage.link]
                        placeholderImage:nil];
}

//LOImageSearchViewController Delegate
- (void)didSelectImage:(NSString *)imageURL
{
    self.foodMediaURL = imageURL;
    [self.foodMediaItem sd_setImageWithURL:[NSURL URLWithString:imageURL]
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Test");
//
}

- (void)dismiss
{
    [self.foodName resignFirstResponder];
    [self.foodLocation resignFirstResponder];
    
    if ([self formIsValid]) {
        [self.createFoodButton setEnabled:YES];
    } else {
        [self.createFoodButton setEnabled:NO];
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
    [searchImageViewController setImageQueryString:self.foodName.text];
    [searchImageViewController setDelegate:self];
}


@end
