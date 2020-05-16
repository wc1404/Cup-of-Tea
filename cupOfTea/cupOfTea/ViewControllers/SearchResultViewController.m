//
//  SearchResultViewController.m
//  cupOfTea
//
//  Created by Wilfredo Cueto on 5/10/20.
//  Copyright © 2020 Nivvy Balakumar, Wilfredo Cueto. All rights reserved.
//

#import "SearchResultViewController.h"

@interface SearchResultViewController ()

@end

@implementation SearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _searchResultTable.delegate = self;
    _searchResultTable.dataSource = self;
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    _restaurants = [[NSMutableArray alloc] init];
    
    [_searchResultTable reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
   return 2;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *separationView = [UIView new];
    [separationView setBackgroundColor:[UIColor clearColor]];
    return separationView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _restaurants.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"SearchResultCell";
    
    SearchResultCell *cell = [_searchResultTable dequeueReusableCellWithIdentifier:cellIdentifier];
    
    Restaurant *currentRestaurant = [_restaurants objectAtIndex:indexPath.section];
    
    cell.name.text = currentRestaurant.name;
    cell.address.text = currentRestaurant.address;
    cell.phoneNum.text = currentRestaurant.phoneNum;
    
    NSMutableString *pricingMoneySigns = [[NSMutableString alloc] init];
    
    for (int i = 0; i<currentRestaurant.pricing; i++) {
        [pricingMoneySigns appendString:@"$"];
    }
    
    cell.pricing.text = pricingMoneySigns;
    cell.rating.text = [[NSString alloc] initWithFormat:@"%.1f", currentRestaurant.starRating];
    
    return cell;
}

- (IBAction)search:(id)sender {
    [self resetVote];
    [_restaurants removeAllObjects];
    //[self searchForRestaurants];
    
    [GMSPlacesClient currentPlaceWithCallback:^(GMSPlaceLikelihoodList *placeLikelihoodList, NSError *error){
      if (error != nil) {
        NSLog(@"Current Place error %@", [error localizedDescription]);
        return;
      }

      if (placeLikelihoodList != nil) {
        for(int i = 0; i<4; i++) {
            GMSPlace *place = [[[placeLikelihoodList likelihoods] firstObject] place];
            if (place != nil) {
                [_restaurants addObject:[[Restaurant alloc] initWithName:place.name andAddress:[[place.formattedAddress componentsSeparatedByString:@", "] componentsJoinedByString:@"\n"] andPhoneNum:place.phoneNumber andStarRating:place.rating andPricing:place.priceLevel]];
            }
        }
      }
    }];
    
    
    
    [_searchResultTable reloadData];
}

- (IBAction)restartSearch:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)resetVotes:(id)sender {
    [self resetVote];
}

-(void)resetVote {
    for(int i = 0; i<4; i++) {
        SearchResultCell *cell = [_searchResultTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        cell.voteCount = 0;
        cell.voteCountLabel.text = @"0";
    }
    [_searchResultTable reloadData];
}

- (IBAction)finishVoting:(id)sender {
    SearchResultCell *maxCell;
    int max = 0;
    
    for(int i = 0; i<4; i++) {
        SearchResultCell *cell = [_searchResultTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:i]];
        
        if (cell.voteCount > max) {
            max = cell.voteCount;
            maxCell = cell;
        }
        [cell.voteButtonOutlet setEnabled:false];
    }
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    
    NSManagedObject *newRestaurant = [NSEntityDescription insertNewObjectForEntityForName:@"Restaurants" inManagedObjectContext:context];
    
    [newRestaurant setValue:maxCell.name.text forKey:@"name"];
    [newRestaurant setValue:maxCell.address.text forKey:@"address"];
    [newRestaurant setValue:maxCell.phoneNum.text forKey:@"phoneNum"];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    NSNumber *starNumber = [formatter numberFromString:maxCell.rating.text];
    NSNumber *priceNumber = [formatter numberFromString:maxCell.pricing.text];
    
    [newRestaurant setValue:starNumber forKey:@"starRating"];
    [newRestaurant setValue:priceNumber forKey:@"pricing"];
    
    [context insertObject:newRestaurant];
    
    NSError *error = nil;
    if ([context save:&error] == NO) {
        NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
    }
    
    maxCell.selected = true;
    [maxCell.imageBackground setBackgroundColor:[UIColor lightGrayColor]];
    
    [_finishVotingButton setEnabled:false];
    [_finishVotingButton setBackgroundColor:[UIColor redColor]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
