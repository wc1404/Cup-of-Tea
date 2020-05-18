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
    
    _locationManager = [[CLLocationManager alloc] init];
    [_locationManager setDelegate:self];
    [_locationManager requestWhenInUseAuthorization];
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    
    _queryResults = [[NSMutableArray alloc] init];
    
    _restaurants = [[NSMutableArray alloc] init];
    
    NSLog(@"Loading Results View:");
    if(_searchEnabled) {
        NSLog(@"Search Enabled");
    } else {
        NSLog(@"Search Disabled");
    }

    if(_searchWithTags) {
        NSLog(@"Tags Enabled with: %lu tags", (unsigned long)_tags.count);
    } else {
        NSLog(@"Tags Disabled");
    }
    NSLog(@"END");
    
    if(_searchEnabled) {
        [self search];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if(status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [_locationManager requestWhenInUseAuthorization];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
   return 2;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
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
    
    NSString *currentRestaurant = [_restaurants objectAtIndex:indexPath.section];
    
    NSString *key = @"AIzaSyDrv9DRb5Ocxovw0koOOgrRsBYB_9hnAIc";
    
    NSString *req = [[NSString alloc] initWithFormat:@"https://maps.googleapis.com/maps/api/place/details/json?place_id=%@&fields=name,formatted_address,formatted_phone_number,rating,price_level&key=%@", currentRestaurant,key];

    NSData* restaurantData = [NSData dataWithContentsOfURL: [NSURL URLWithString:req]];

    NSError* error;
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:restaurantData options:kNilOptions error:&error];
    
    NSString *priceLevel = [[json objectForKey:@"result"] objectForKey:@"price_level"];
    
    NSString *ratings = [[json objectForKey:@"result"] objectForKey:@"rating"];
    
    NSString *name = [[json objectForKey:@"result"] objectForKey:@"name"];
    NSString *address = [[json objectForKey:@"result"] objectForKey:@"formatted_address"];
    NSString *phone = [[json objectForKey:@"result"] objectForKey:@"formatted_phone_number"];
    float rating = [ratings floatValue];
    int pricing = (int)[priceLevel integerValue];
    
    cell.name.text = name;
    cell.address.text = address;
    cell.phoneNum.text = phone;
    
    NSMutableString *pricingMoneySigns = [[NSMutableString alloc] init];
    
    for (int i = 0; i < pricing; i++) {
        [pricingMoneySigns appendString:@"$"];
    }
    
    cell.pricing.text = pricingMoneySigns;
    cell.rating.text = [[NSString alloc] initWithFormat:@"%.1f", rating];
    
    return cell;
}

- (void)search {
    [self resetVote];
    [_restaurants removeAllObjects];
    
    if (_queryResults.count <= 0) {
        [_locationManager requestLocation];
        
        NSString *key = @"AIzaSyDrv9DRb5Ocxovw0koOOgrRsBYB_9hnAIc";
        NSString *radius = @"1700";// In Meters
        NSString *latitude = [[NSString alloc] initWithFormat:@"%.7f", _locationManager.location.coordinate.latitude];
        NSString *longitude = [[NSString alloc] initWithFormat:@"%.7f", _locationManager.location.coordinate.longitude];
        
        if(_searchWithTags) {
            for(NSString *tag in _tags) {
                NSString *req = [[NSString alloc] initWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%@,%@&radius=%@&type=restaurant&keyword=%@&opennow=true&key=%@", latitude,longitude,radius,tag,key];

                NSData* restaurantData = [NSData dataWithContentsOfURL: [NSURL URLWithString:req]];

                NSError* error;
                NSDictionary* json = [NSJSONSerialization JSONObjectWithData:restaurantData options:kNilOptions error:&error];
                NSArray* places = [json objectForKey:@"results"];
                for(NSDictionary *restaurant in places) {
                    [_queryResults addObject:[restaurant objectForKey:@"place_id"]];
                }
            }
        } else {
            NSString *req = [[NSString alloc] initWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%@,%@&radius=%@&type=restaurant&opennow=true&key=%@", latitude,longitude,radius,key];

            NSData* restaurantData = [NSData dataWithContentsOfURL: [NSURL URLWithString:req]];

            NSError* error;
            NSDictionary* json = [NSJSONSerialization JSONObjectWithData:restaurantData options:kNilOptions error:&error];
            NSArray* places = [json objectForKey:@"results"];
            for(NSDictionary *restaurant in places) {
                [_queryResults addObject:[restaurant objectForKey:@"place_id"]];
            }
        }
    }
    
    if ([_queryResults count] != 0) {
        int rest_count = 0;
        int max_count = 4;
        
        if(_queryResults.count < max_count){
            max_count = (int)_queryResults.count;
        }
        
        while (rest_count < max_count) {
            NSUInteger randomIndex = arc4random() % _queryResults.count;
            
            NSString *placeId = [_queryResults objectAtIndex:randomIndex];
            
            if(![_restaurants containsObject:placeId]) {
                [_restaurants addObject:placeId];
                rest_count++;
            }
        }
    } else {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Sorry" message:@"No Restaurants found. Please restart search With different criteria." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    [_searchResultTable reloadData];
}

- (IBAction)reSearch:(id)sender {
    if(_finishVotingButton.enabled) {
        if(_queryResults.count > 0) {
            [self search];
        }
    } else {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Voting has finished, for new suggestions please restart your search" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (IBAction)restartSearch:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)resetVotes:(id)sender {
    [self resetVote];
}

- (void)resetVote {
    if(_finishVotingButton.enabled) {
        for(int i = 0; i<4; i++) {
            SearchResultCell *cell = [_searchResultTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:i]];
            cell.voteCount = 0;
            cell.voteCountLabel.text = @"0";
        }
        
        [_searchResultTable reloadData];
    } else {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Voting has finished, for new suggestions please restart your search" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (IBAction)finishVoting:(id)sender {
    SearchResultCell *maxCell;
    NSString *maxRestaurant;
    int max = 0;
    
    for(int i = 0; i<4; i++) {
        SearchResultCell *cell = [_searchResultTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:i]];
        
        if (cell.voteCount > max) {
            max = cell.voteCount;
            maxCell = cell;
            maxRestaurant = [_restaurants objectAtIndex:i];
        }
        [cell.voteButtonOutlet setEnabled:false];
    }
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    
    Restaurants *newRestaurant = [NSEntityDescription insertNewObjectForEntityForName:@"Restaurants" inManagedObjectContext:context];
    
    [newRestaurant setValue:maxRestaurant forKey:@"restaurantPlaceID"];
    
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
