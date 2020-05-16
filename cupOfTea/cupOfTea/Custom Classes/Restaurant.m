//
//  Restaurant.m
//  cupOfTea
//
//  Created by Wilfredo Cueto on 5/10/20.
//  Copyright © 2020 Nivvy Balakumar, Wilfredo Cueto. All rights reserved.
//

#import "Restaurant.h"

@implementation Restaurant

-(instancetype)init {
    return [self initWithName:@"" andAddress:@"" andPhoneNum:@"" andStarRating:0 andPricing:0];
}

-(instancetype)initWithName:(NSString*)name andAddress:(NSString*)address andPhoneNum:(NSString*)phoneNum andStarRating:(float)rating andPricing:(int)pricing {
    
    _name = name;
    _address = address;
    _phoneNum = phoneNum;
    _starRating = rating;
    _pricing = pricing;
    
    return self;
}

-(void)saveToCoreData {
}

+(NSArray*)fetchPreviousRestaurants {
    return [[NSArray alloc] init];
}

@end
