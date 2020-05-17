//
//  SearchResultViewController.h
//  cupOfTea
//
//  Created by Wilfredo Cueto on 5/10/20.
//  Copyright © 2020 Nivvy Balakumar, Wilfredo Cueto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Restaurants+CoreDataProperties.h"
#import "SearchResultCell.h"
@import GooglePlaces;
@import CoreLocation;

NS_ASSUME_NONNULL_BEGIN

@interface SearchResultViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate>

@property CLLocationManager *locationManager;
@property GMSPlacesClient *placesClient;

@property (strong, nonatomic) NSMutableArray *tags;
@property (strong, nonatomic) NSMutableArray *restaurants;

@property (strong, nonatomic) IBOutlet UITableView *searchResultTable;

@property (strong, nonatomic) IBOutlet UIButton *finishVotingButton;

- (IBAction)finishVoting:(id)sender;

- (IBAction)resetVotes:(id)sender;

- (void)resetVote;

- (IBAction)restartSearch:(id)sender;

- (IBAction)reSearch:(id)sender;

-(void)search;

@end

NS_ASSUME_NONNULL_END
