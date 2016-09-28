//
//  ORGContainerCell.m
//  HorizontalCollectionViews
//
//  Created by James Clark on 4/22/13.
//  Copyright (c) 2013 OrgSync, LLC. All rights reserved.
//

#import "LONewsContainerCell.h"
#import "LONewsContainerCellView.h"

@interface LONewsContainerCell ()
@property (strong, nonatomic) LONewsContainerCellView *collectionView;
@end

@implementation LONewsContainerCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _collectionView = [[NSBundle mainBundle] loadNibNamed:@"LONewsContainerCellView" owner:self options:nil][0];
        //_collectionView.frame = self.bounds;
        _collectionView.frame = CGRectMake(10.0f, 0.0f, self.bounds.size.width - (10.0f * 2), self.bounds.size.height);
//        _collectionView.layer.cornerRadius = 8;
   //     _collectionView.layer.masksToBounds = YES;
        
        [self.contentView addSubview:_collectionView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)setCollectionData:(NSArray *)collectionData {
    [_collectionView setCollectionData:collectionData];
}



@end
