//
//  LOSettingsHeaderTableViewCell.h
//  Utmost
//
//  Created by Ryan Thomas on 8/9/16.
//  Copyright © 2016 Ryan Phillip Thomas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LOSettingsHeaderTableViewCell : UITableViewCell <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UIImageView *userImage;
@property (nonatomic, weak) IBOutlet UITextField *userFirstNameField;
@property (nonatomic, weak) IBOutlet UITextField *userLastNameField;
@property (nonatomic, weak) IBOutlet UITextField *userEmailField;

- (void)configureCellWithUserImage:(UIImage *)userImage
                         firstName:(NSString *)firstName
                          lastName:(NSString *)lastName
                             email:(NSString *)email;

@end
