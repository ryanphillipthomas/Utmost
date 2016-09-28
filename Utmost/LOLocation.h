//
//  LOLocation+CoreDataClass.h
//  Utmost
//
//  Created by Ryan Thomas on 8/11/16.
//  Copyright © 2016 Ryan Phillip Thomas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <MagicalRecord/MagicalRecord.h>

NS_ASSUME_NONNULL_BEGIN

@interface LOLocation : NSManagedObject

// Insert code here to declare functionality of your managed object subclass
+ (void)createOrUpdateObject:(NSString *)title
                   locationID:(NSString *)locationID
                 address:(NSString *)address
                     latitude:(NSString *)latitude
                     longitude:(NSString *)longitude
                       image:(NSString *)image
                  completion:(LOSaveCompletionBlock)completionBlock;

+ (void)deleteObjectWithLocationID:(NSString *)locationID
                       completion:(LOSaveCompletionBlock)completionBlock;

@end

NS_ASSUME_NONNULL_END

#import "LOLocation+CoreDataProperties.h"
