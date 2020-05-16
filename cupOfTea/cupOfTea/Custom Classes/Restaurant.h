//
//  Restaurant.h
//  cupOfTea
//
//  Created by Wilfredo Cueto on 5/10/20.
//  Copyright © 2020 Nivvy Balakumar, Wilfredo Cueto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface Restaurant : NSObject
@property (weak, nonatomic) NSString *name;
@property (weak, nonatomic) NSString *address;
@property (weak, nonatomic) NSString *phoneNum;
@property (weak, nonatomic) NSString *restImage;
@property (weak, nonatomic) NSMutableArray *cuisines;

@property float starRating;
@property int pricing;

-(instancetype)init;

-(instancetype)initWithName:(NSString*)name andAddress:(NSString*)address andPhoneNum:(NSString*)phoneNum andStarRating:(float)rating andPricing:(int)pricing;

-(void)saveToCoreData;

+(NSArray*)fetchPreviousRestaurants;

@end

NS_ASSUME_NONNULL_END
