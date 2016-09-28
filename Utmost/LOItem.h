//
//  LOItem+CoreDataClass.h
//  Loop
//
//  Created by Ryan Thomas on 8/1/16.
//  Copyright © 2016 Ryan Phillip Thomas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <MagicalRecord/MagicalRecord.h>

@class LOActivity, LOFood;

NS_ASSUME_NONNULL_BEGIN

@interface LOItem : NSManagedObject

+ (void)deleteObjectWithDate:(NSDate *)date completion:(LOSaveCompletionBlock)completionBlock;

@end

NS_ASSUME_NONNULL_END

#import "LOItem+CoreDataProperties.h"
