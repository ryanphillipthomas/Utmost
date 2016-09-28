//
//  LOActivity.h
//  Loop
//
//  Created by Ryan Phillip Thomas on 6/26/16.
//  Copyright © 2016 Ryan Phillip Thomas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <MagicalRecord/MagicalRecord.h>
#import "LOActivityPrototype.h"
#import "LORootItem.h"

@class LORootItem;

NS_ASSUME_NONNULL_BEGIN

@interface LOActivity : NSManagedObject

// Insert code here to declare functionality of your managed object subclass
+ (void)createOrUpdateObject:(NSString *)name
                        type:(enum LOActivityType)type
                    category:(enum LOActivityCategory)category
                    location:(enum LOActivityLocation)location
                    mediaURL:(NSString *)mediaURL
                        date:(NSDate *)date
                  rootItemID:(NSString *)rootItemID
                  completion:(LOSaveCompletionBlock)completionBlock;

+ (void)deleteObjectWithDate:(NSDate *)date completion:(LOSaveCompletionBlock)completionBlock;

- (NSString *)stringForActivityType:(NSInteger)activityType;
- (NSString *)stringForActivityCategory:(NSInteger)activityCategory;
- (NSString *)stringForActivityLocation:(NSInteger)activityLocation;

- (NSInteger )baseHealthValue;
- (NSInteger )baseEnvironmentValue;

@end

NS_ASSUME_NONNULL_END

#import "LOActivity+CoreDataProperties.h"
