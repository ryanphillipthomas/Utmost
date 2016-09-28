//
//  LOHomeTableViewCell.m
//  Loop
//
//  Created by Ryan Phillip Thomas on 11/1/15.
//  Copyright © 2015 Ryan Phillip Thomas. All rights reserved.
//

#import "LOHomeLoopTableViewCell.h"

@implementation LOHomeLoopTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureCellWithImage:(UIImage *)image forDescription:(NSString *)description
{
    [self.loopImage setImage:image];
    [self.loopLabel setText:description];
}

@end
