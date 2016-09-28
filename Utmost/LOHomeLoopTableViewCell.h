//
//  LOHomeTableViewCell.h
//  Loop
//
//  Created by Ryan Phillip Thomas on 11/1/15.
//  Copyright © 2015 Ryan Phillip Thomas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LOHomeLoopTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *loopImage;
@property (nonatomic, weak) IBOutlet UILabel *loopLabel;

- (void)configureCellWithImage:(UIImage *)image forDescription:(NSString *)description;

@end
