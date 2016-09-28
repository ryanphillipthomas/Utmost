//
//  LORootItem+CoreDataProperties.h
//  Utmost
//
//  Created by Ryan Thomas on 8/19/16.
//  Copyright © 2016 Ryan Phillip Thomas. All rights reserved.
//

#import "LORootItem.h"


NS_ASSUME_NONNULL_BEGIN

@interface LORootItem (CoreDataProperties)

+ (NSFetchRequest<LORootItem *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSNumber *baseActivityType;
@property (nullable, nonatomic, copy) NSNumber *baseFoodType;
@property (nullable, nonatomic, copy) NSNumber *environmentFrequencyLimit;
@property (nullable, nonatomic, copy) NSNumber *healthFrequencyLimit;
@property (nullable, nonatomic, copy) NSString *image;
@property (nullable, nonatomic, copy) NSString *itemTypeString;
@property (nullable, nonatomic, copy) NSString *rootItemID;
@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, retain) NSSet<LOFood *> *foods;
@property (nullable, nonatomic, retain) NSSet<LOActivity *> *activities;

@end

@interface LORootItem (CoreDataGeneratedAccessors)

- (void)addFoodsObject:(LOFood *)value;
- (void)removeFoodsObject:(LOFood *)value;
- (void)addFoods:(NSSet<LOFood *> *)values;
- (void)removeFoods:(NSSet<LOFood *> *)values;

- (void)addActivitiesObject:(LOActivity *)value;
- (void)removeActivitiesObject:(LOActivity *)value;
- (void)addActivities:(NSSet<LOActivity *> *)values;
- (void)removeActivities:(NSSet<LOActivity *> *)values;

@end

NS_ASSUME_NONNULL_END
