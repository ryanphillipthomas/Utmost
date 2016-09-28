//
//  LOLocation+CoreDataProperties.m
//  Utmost
//
//  Created by Ryan Thomas on 8/11/16.
//  Copyright © 2016 Ryan Phillip Thomas. All rights reserved.
//

#import "LOLocation+CoreDataProperties.h"

@implementation LOLocation (CoreDataProperties)

+ (NSFetchRequest<LOLocation *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"LOLocation"];
}

@dynamic title;
@dynamic address;
@dynamic latitude;
@dynamic longitude;
@dynamic locationID;
@dynamic image;

@end
