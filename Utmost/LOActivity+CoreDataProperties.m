//
//  LOActivity+CoreDataProperties.m
//  Utmost
//
//  Created by Ryan Thomas on 8/19/16.
//  Copyright © 2016 Ryan Phillip Thomas. All rights reserved.
//

#import "LOActivity+CoreDataProperties.h"

@implementation LOActivity (CoreDataProperties)

+ (NSFetchRequest<LOActivity *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"LOActivity"];
}

@dynamic activityID;
@dynamic category;
@dynamic date;
@dynamic location;
@dynamic mediaURL;
@dynamic name;
@dynamic stringDate;
@dynamic type;
@dynamic item;
@dynamic rootItem;

@end
