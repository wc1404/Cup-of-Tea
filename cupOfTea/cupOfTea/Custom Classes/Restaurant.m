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
    return [self initWithName:@"" andAddress:@"" andPhoneNum:@"" andRestImage:@"" andStarRating:0 andPricing:0 andCuisines:[[NSMutableArray alloc] init]];
}

-(instancetype)initWithName:(NSString*)name andAddress:(NSString*)address andPhoneNum:(NSString*)phoneNum andRestImage:(NSString*)imageURL andStarRating:(float)rating andPricing:(int)pricing andCuisines:(NSMutableArray*)cuisines {
    
    _name = name;
    _address = address;
    _phoneNum = phoneNum;
    _restImage = imageURL;
    _starRating = rating;
    _pricing = pricing;
    _cuisines = cuisines;
    
    return self;
}

-(void)saveToCoreData {
}

+(NSArray*)fetchPreviousRestaurants {
    return [[NSArray alloc] init];
}

@end
