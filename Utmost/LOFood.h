//
//  LOFood.h
//  Loop
//
//  Created by Ryan Phillip Thomas on 12/12/15.
//  Copyright © 2015 Ryan Phillip Thomas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <MagicalRecord/MagicalRecord.h>
#import "LOFoodPrototype.h"
#import "LORootItem.h"

@class LORootItem;

NS_ASSUME_NONNULL_BEGIN

@interface LOFood : NSManagedObject

// Insert code here to declare functionality of your managed object subclass
+ (void)createOrUpdateObject:(NSString *)name
                        type:(enum LOFoodType)type
                  categories:(NSObject *)categories
                    location:(enum LOFoodLocation)location
                    mediaURL:(NSString *)mediaURL
                        date:(NSDate *)date
                  rootItemID:(NSString *)rootItemID
                    completion:(LOSaveCompletionBlock)completionBlock;

+ (void)deleteObjectWithDate:(NSDate *)date completion:(LOSaveCompletionBlock)completionBlock;

- (NSString *)stringForFoodType:(NSInteger)foodType;
- (NSString *)stringForFoodCategory:(NSInteger)foodCategory;
- (NSString *)stringForFoodCategories:(NSArray *)foodCategories;
- (NSString *)stringForFoodLocation:(NSInteger)foodLocation;

- (NSInteger )baseHealthValue;
- (NSInteger )baseEnvironmentValue;


@end

NS_ASSUME_NONNULL_END

#import "LOFood+CoreDataProperties.h"
