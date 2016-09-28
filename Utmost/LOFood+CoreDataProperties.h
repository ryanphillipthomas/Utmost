//
//  LOFood+CoreDataProperties.h
//  Utmost
//
//  Created by Ryan Thomas on 8/19/16.
//  Copyright © 2016 Ryan Phillip Thomas. All rights reserved.
//

#import "LOFood.h"


NS_ASSUME_NONNULL_BEGIN

@interface LOFood (CoreDataProperties)

+ (NSFetchRequest<LOFood *> *)fetchRequest;

@property (nullable, nonatomic, retain) NSObject *categories;
@property (nullable, nonatomic, copy) NSDate *date;
@property (nullable, nonatomic, copy) NSNumber *foodID;
@property (nullable, nonatomic, copy) NSNumber *location;
@property (nullable, nonatomic, copy) NSString *mediaURL;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *stringDate;
@property (nullable, nonatomic, copy) NSNumber *type;
@property (nullable, nonatomic, retain) NSManagedObject *item;
@property (nullable, nonatomic, retain) LORootItem *rootItem;

@end

NS_ASSUME_NONNULL_END
