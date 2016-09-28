//
//  LOFood+CoreDataProperties.m
//  Utmost
//
//  Created by Ryan Thomas on 8/19/16.
//  Copyright © 2016 Ryan Phillip Thomas. All rights reserved.
//

#import "LOFood+CoreDataProperties.h"

@implementation LOFood (CoreDataProperties)

+ (NSFetchRequest<LOFood *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"LOFood"];
}

@dynamic categories;
@dynamic date;
@dynamic foodID;
@dynamic location;
@dynamic mediaURL;
@dynamic name;
@dynamic stringDate;
@dynamic type;
@dynamic item;
@dynamic rootItem;

@end
