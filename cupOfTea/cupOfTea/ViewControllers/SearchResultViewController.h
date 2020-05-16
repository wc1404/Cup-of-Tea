//
//  SearchResultViewController.h
//  cupOfTea
//
//  Created by Wilfredo Cueto on 5/10/20.
//  Copyright © 2020 Nivvy Balakumar, Wilfredo Cueto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Restaurant.h"
#import "Restaurants+CoreDataClass.h"
#import "SearchResultCell.h"
@import GooglePlaces;
@import CoreLocation;

NS_ASSUME_NONNULL_BEGIN

@interface SearchResultViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
}

@property (strong, nonatomic) float *currentLatitude;
@property (strong, nonatomic) float *currentLongitude;


@property (strong, nonatomic) NSMutableArray *tags;
@property (strong, nonatomic) NSMutableArray *restaurants;

@property (strong, nonatomic) IBOutlet UITableView *searchResultTable;

@property (strong, nonatomic) IBOutlet UIButton *finishVotingButton;

- (IBAction)finishVoting:(id)sender;

- (IBAction)resetVotes:(id)sender;

- (void)resetVote;

- (IBAction)restartSearch:(id)sender;

- (IBAction)search:(id)sender;

@end

NS_ASSUME_NONNULL_END
