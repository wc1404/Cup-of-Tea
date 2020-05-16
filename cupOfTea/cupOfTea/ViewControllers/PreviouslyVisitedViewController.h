//
//  PreviouslyVisitedViewController.h
//  cupOfTea
//
//  Created by Wilfredo Cueto on 5/11/20.
//  Copyright © 2020 Nivvy Balakumar, Wilfredo Cueto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Restaurant.h"
#import "Restaurants+CoreDataClass.h"
#import "VisitedRestaurantCell.h"
#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface PreviouslyVisitedViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *visitedTable;

@property (strong,nonatomic) NSMutableArray *restaurants;

@end

NS_ASSUME_NONNULL_END
