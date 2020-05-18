//
//  Restaurants+CoreDataProperties.m
//  cupOfTea
//
//  Created by Wilfredo Cueto on 5/17/20.
//  Copyright © 2020 Nivvy Balakumar, Wilfredo Cueto. All rights reserved.
//
//

#import "Restaurants+CoreDataProperties.h"

@implementation Restaurants (CoreDataProperties)

+ (NSFetchRequest<Restaurants *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Restaurants"];
}

@dynamic restaurantPlaceID;

@end
