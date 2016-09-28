//
//  LORootItem+CoreDataProperties.m
//  Utmost
//
//  Created by Ryan Thomas on 8/19/16.
//  Copyright © 2016 Ryan Phillip Thomas. All rights reserved.
//

#import "LORootItem+CoreDataProperties.h"

@implementation LORootItem (CoreDataProperties)

+ (NSFetchRequest<LORootItem *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"LORootItem"];
}

@dynamic baseActivityType;
@dynamic baseFoodType;
@dynamic environmentFrequencyLimit;
@dynamic healthFrequencyLimit;
@dynamic image;
@dynamic itemTypeString;
@dynamic rootItemID;
@dynamic title;
@dynamic foods;
@dynamic activities;

@end
