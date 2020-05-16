//
//  Restaurants+CoreDataProperties.m
//  cupOfTea
//
//  Created by Wilfredo Cueto on 5/15/20.
//  Copyright © 2020 Nivvy Balakumar, Wilfredo Cueto. All rights reserved.
//
//

#import "Restaurants+CoreDataProperties.h"

@implementation Restaurants (CoreDataProperties)

+ (NSFetchRequest<Restaurants *> *)createFetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Restaurants"];
}

@dynamic address;
@dynamic name;
@dynamic phoneNum;
@dynamic pricing;
@dynamic starRating;

@end
