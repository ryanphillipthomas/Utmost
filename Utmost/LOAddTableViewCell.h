//
//  LOAddTableViewCell.h
//  Loop
//
//  Created by Ryan Phillip Thomas on 12/5/15.
//  Copyright © 2015 Ryan Phillip Thomas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LOAddTableViewCell : UITableViewCell

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, weak) IBOutlet UIImageView *cellImageView;
@property (nonatomic, weak) IBOutlet UILabel *title;
@property (nonatomic, weak) IBOutlet UILabel *subtitle;

- (void)configureCellWithImageString:(NSString *)imageString forTitle:(NSString *)title withSubtitle:(NSString *)subtitle;

@end
