//
//  SearchResultViewController.h
//  cupOfTea
//
//  Created by Wilfredo Cueto on 5/10/20.
//  Copyright © 2020 Nivvy Balakumar, Wilfredo Cueto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Restaurant.h"
#import "SearchResultCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface SearchResultViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *tags;
@property (strong, nonatomic) NSMutableArray *restaurants;

@property (strong, nonatomic) IBOutlet UITableView *searchResultTable;

- (IBAction)finishVoting:(id)sender;

- (IBAction)resetVotes:(id)sender;

- (void)resetVote;

- (void)searchForRestaurants;

- (IBAction)restartSearch:(id)sender;

- (IBAction)searchAgain:(id)sender;

@end

NS_ASSUME_NONNULL_END
