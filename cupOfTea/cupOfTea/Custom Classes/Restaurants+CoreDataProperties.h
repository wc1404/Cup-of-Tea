//
//  Restaurants+CoreDataProperties.h
//  cupOfTea
//
//  Created by Wilfredo Cueto on 5/17/20.
//  Copyright © 2020 Nivvy Balakumar, Wilfredo Cueto. All rights reserved.
//
//

#import "Restaurants+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Restaurants (CoreDataProperties)

+ (NSFetchRequest<Restaurants *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *restaurantPlaceID;

@end

NS_ASSUME_NONNULL_END
