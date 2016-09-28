//
//  LOItem+CoreDataProperties.h
//  Loop
//
//  Created by Ryan Thomas on 8/1/16.
//  Copyright © 2016 Ryan Phillip Thomas. All rights reserved.
//

#import "LOItem.h"


NS_ASSUME_NONNULL_BEGIN

@interface LOItem (CoreDataProperties)

+ (NSFetchRequest *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *stringDate;
@property (nullable, nonatomic, copy) NSDate *date;
@property (nullable, nonatomic, copy) NSDate *sectionDate;
@property (nullable, nonatomic, retain) LOFood *food;
@property (nullable, nonatomic, retain) LOActivity *activity;

@end

NS_ASSUME_NONNULL_END
