//
//  LOItem+CoreDataProperties.m
//  Loop
//
//  Created by Ryan Thomas on 8/1/16.
//  Copyright © 2016 Ryan Phillip Thomas. All rights reserved.
//

#import "LOItem+CoreDataProperties.h"

@implementation LOItem (CoreDataProperties)

+ (NSFetchRequest *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"LOItem"];
}

@dynamic stringDate;
@dynamic date;
@dynamic food;
@dynamic activity;
@dynamic sectionDate;

@end
