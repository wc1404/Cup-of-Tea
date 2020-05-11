//
//  Restaurant.h
//  cupOfTea
//
//  Created by Wilfredo Cueto on 5/10/20.
//  Copyright © 2020 Nivvy Balakumar, Wilfredo Cueto. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Restaurant : NSObject
@property (weak, nonatomic) NSString *name;
@property (weak, nonatomic) NSString *address;
@property (weak, nonatomic) NSString *phoneNum;
@property (weak, nonatomic) NSString *restDescription;
@property (weak, nonatomic) NSString *restImage;
@property (weak, nonatomic) NSMutableArray *cuisines;

@property int starRating;
@property int pricing;

-(instancetype)init;

-(instancetype)initWithName:(NSString*)name andAddress:(NSString*)address andPhoneNum:(NSString*)phoneNum andRestImage:(NSString*)imageURL andDescription:(NSString*)restDesription andStarRating:(int)rating andPricing:(int)pricing andCuisines:(NSMutableArray*)cuisines;

@end

NS_ASSUME_NONNULL_END
