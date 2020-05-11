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
    
    _restaurants = [[NSMutableArray alloc] init];
    
    [_restaurants addObject:[[Restaurant alloc] initWithName:@"Papa John's" andAddress:@"99-06 Northern Blvd Ste 1, Queens, NY 11368" andPhoneNum:@"(718) 507-7991" andRestImage:@"" andDescription:@"" andStarRating:4 andPricing:1 andCuisines:[[NSMutableArray alloc] init]]];
    [_restaurants addObject:[[Restaurant alloc] initWithName:@"Uncle Thomas Pizza" andAddress:@"9023 37th Ave, Jackson Heights, NY 11372" andPhoneNum:@"(718) 898-0347" andRestImage:@"" andDescription:@"" andStarRating:4 andPricing:1 andCuisines:[[NSMutableArray alloc] init]]];
    [_restaurants addObject:[[Restaurant alloc] initWithName:@"Louie's" andAddress:@"8134 Baxter Ave # 1, Elmhurst, NY 11373" andPhoneNum:@"(718) 440-9346" andRestImage:@"" andDescription:@"" andStarRating:5 andPricing:1 andCuisines:[[NSMutableArray alloc] init]]];
    [_restaurants addObject:[[Restaurant alloc] initWithName:@"Domino's Pizza" andAddress:@"9045 Corona Ave., Queens, NY 11373" andPhoneNum:@"(718) 457-3030" andRestImage:@"" andDescription:@"" andStarRating:3 andPricing:1 andCuisines:[[NSMutableArray alloc] init]]];
    
    [_searchResultTable reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _restaurants.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"SearchResultCell";
    
    SearchResultCell *cell = [_searchResultTable dequeueReusableCellWithIdentifier:cellIdentifier];
    
    Restaurant *currentRestaurant = [_restaurants objectAtIndex:indexPath.row];
    
    cell.name.text = currentRestaurant.name;
    cell.address.text = currentRestaurant.address;
    cell.phoneNum.text = currentRestaurant.phoneNum;
    
    NSData *imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: currentRestaurant.restImage]];;
    cell.image.image = [[UIImage alloc] initWithData:imageData];
    
    NSMutableString *pricingMoneySigns = [[NSMutableString alloc] init];
    
    for (int i = 0; i<currentRestaurant.pricing; i++) {
        [pricingMoneySigns appendString:@"$"];
    }
    
    cell.pricing.text = pricingMoneySigns;
    cell.rating.text = [[NSString alloc] initWithFormat:@"%d", currentRestaurant.starRating];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath; {
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)searchAgain:(id)sender {
    [self resetVote];
    [_restaurants removeAllObjects];
    //[self searchForRestaurants];
    
    [_restaurants addObject:[[Restaurant alloc] initWithName:@"La Pequena Taste of Italy Pizza" andAddress:@"37-72 90th St, Jackson Heights, NY 11372" andPhoneNum:@"(718) 505-2600" andRestImage:@"" andDescription:@"" andStarRating:4 andPricing:2 andCuisines:[[NSMutableArray alloc] init]]];
    [_restaurants addObject:[[Restaurant alloc] initWithName:@"Pizza Sam" andAddress:@"89-06 Northern Blvd, Jackson Heights, NY 11372" andPhoneNum:@"(718) 335-3800" andRestImage:@"" andDescription:@"" andStarRating:4 andPricing:2 andCuisines:[[NSMutableArray alloc] init]]];
    [_restaurants addObject:[[Restaurant alloc] initWithName:@"Little Caesars Pizza" andAddress:@"86-10 Roosevelt Ave #27, Jackson Heights, NY 11372" andPhoneNum:@"(718) 205-2350" andRestImage:@"" andDescription:@"" andStarRating:4 andPricing:1 andCuisines:[[NSMutableArray alloc] init]]];
    [_restaurants addObject:[[Restaurant alloc] initWithName:@"Susano’s" andAddress:@"95-12 35th Ave, Flushing, NY 11372" andPhoneNum:@"(929) 349-1280" andRestImage:@"" andDescription:@"" andStarRating:5 andPricing:1 andCuisines:[[NSMutableArray alloc] init]]];
    
    [_searchResultTable reloadData];
}

- (IBAction)restartSearch:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)searchForRestaurants {
    NSDictionary *headers = @{ @"x-rapidapi-host": @"tripadvisor1.p.rapidapi.com",
                               @"x-rapidapi-key": @"45241d658bmshea0a11227305bddp1f248cjsnc221b2fd389c" };

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://tripadvisor1.p.rapidapi.com/restaurants/list-in-boundary?min_rating=3&lunit=mi&combined_food=sushi&restaurant_tagcategory=10591&limit=4&currency=USD&prices_restaurants=4&restaurant_tagcategory_standalone=10591&lang=en_US&open_now=true&bl_latitude=11.847676&bl_longitude=109.095887&tr_latitude=12.838442&tr_longitude=109.149359"]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];

    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"%@", error);
                                                    } else {
                                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                        NSLog(@"%@", httpResponse);
                                                    }
                                                }];
    [dataTask resume];
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
    Restaurant *maxRestaurant;
    SearchResultCell *maxCell;
    int max = 0;
    
    for(int i = 0; i<4; i++) {
        SearchResultCell *cell = [_searchResultTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        if (cell.voteCount > max) {
            max = cell.voteCount;
            maxRestaurant = [_restaurants objectAtIndex:[NSIndexPath indexPathForRow:i inSection:0].row];
            maxCell = cell;
        }
    }
    
    maxCell.selected = true;
}

@end
