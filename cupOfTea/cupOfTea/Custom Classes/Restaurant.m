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
    return [self initWithName:@"Cup of Tea" andAddress:@"251 Mercer St # 801, New York, NY 10012" andPhoneNum:@"3475201459" andRestImage:@"https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.nytimes.com%2F2017%2F11%2F09%2Fnyregion%2Fnyu-puerto-rico-hurricane-maria.html&psig=AOvVaw16enXXEQFOOH89XJK8InGI&ust=1589261511344000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCLi3otWKq-kCFQAAAAAdAAAAABAD" andDescription:@"Depressing type place for learning and whatever the term finding yourself is. It's in the coolest city in the world and theres amazing halal here" andStarRating:4 andPricing:5 andCuisines:[[NSMutableArray alloc] initWithObjects:@"Chinese", @"Halal", @"Pizza", nil]];
}

-(instancetype)initWithName:(NSString*)name andAddress:(NSString*)address andPhoneNum:(NSString*)phoneNum andRestImage:(NSString*)imageURL andDescription:(NSString*)restDesription andStarRating:(int)rating andPricing:(int)pricing andCuisines:(NSMutableArray*)cuisines {
    
    _name = name;
    _address = address;
    _phoneNum = phoneNum;
    _restDescription = restDesription;
    _restImage = imageURL;
    _starRating = rating;
    _pricing = pricing;
    _cuisines = cuisines;
    
    return self;
}

@end
