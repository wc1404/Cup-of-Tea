//
//  Restaurants+CoreDataProperties.h
//  cupOfTea
//
//  Created by Wilfredo Cueto on 5/15/20.
//  Copyright © 2020 Nivvy Balakumar, Wilfredo Cueto. All rights reserved.
//
//

#import "Restaurants+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Restaurants (CoreDataProperties)

+ (NSFetchRequest<Restaurants *> *)createFetchRequest;

@property (nullable, nonatomic, copy) NSString *address;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *phoneNum;
@property (nonatomic) int16_t pricing;
@property (nonatomic) float starRating;

@end

NS_ASSUME_NONNULL_END
