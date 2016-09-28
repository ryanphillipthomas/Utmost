//
//  LOLocation+CoreDataProperties.h
//  Utmost
//
//  Created by Ryan Thomas on 8/11/16.
//  Copyright © 2016 Ryan Phillip Thomas. All rights reserved.
//

#import "LOLocation.h"


NS_ASSUME_NONNULL_BEGIN

@interface LOLocation (CoreDataProperties)

+ (NSFetchRequest<LOLocation *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSString *address;
@property (nullable, nonatomic, copy) NSString *latitude;
@property (nullable, nonatomic, copy) NSString *longitude;
@property (nullable, nonatomic, copy) NSString *locationID;
@property (nullable, nonatomic, copy) NSString *image;


@end

NS_ASSUME_NONNULL_END
