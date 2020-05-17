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
    return [self initWithName:@"Cup of Tea" andAddress:@"Cup of tea Boulevard" andPhoneNum:@"123-456-789" andStarRating:5 andPricing:4];
}

-(instancetype)initWithName:(NSString*)name andAddress:(NSString*)address andPhoneNum:(NSString*)phoneNum andStarRating:(float)rating andPricing:(int)pricing {
    
    _name = name;
    _address = address;
    _phoneNum = phoneNum;
    _starRating = rating;
    _pricing = pricing;
    
    //NSLog(@"Input name:%@, address:%@, phone:%@, pricing:%d, rating:%f", name,address,phoneNum,pricing,rating);
    
    //NSLog(@"Saved name:%@, address:%@, phone:%@, pricing:%d, rating:%f", _name,_address,_phoneNum,_pricing,_starRating);
    
    return self;
}

@end
