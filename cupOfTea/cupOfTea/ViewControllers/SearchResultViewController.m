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
    
    [_restaurants addObject:[[Restaurant alloc] initWithName:@"Papa John's" andAddress:@"99-06 Northern Blvd Ste 1, Queens, NY 11368" andPhoneNum:@"(718) 507-7991" andRestImage:@"" andStarRating:4.1 andPricing:1 andCuisines:[[NSMutableArray alloc] init]]];
    [_restaurants addObject:[[Restaurant alloc] initWithName:@"Uncle Thomas Pizza" andAddress:@"9023 37th Ave, Jackson Heights, NY 11372" andPhoneNum:@"(718) 898-0347" andRestImage:@"" andStarRating:4.6 andPricing:1 andCuisines:[[NSMutableArray alloc] init]]];
    [_restaurants addObject:[[Restaurant alloc] initWithName:@"Louie's" andAddress:@"8134 Baxter Ave # 1, Elmhurst, NY 11373" andPhoneNum:@"(718) 440-9346" andRestImage:@""  andStarRating:5.0 andPricing:1 andCuisines:[[NSMutableArray alloc] init]]];
    [_restaurants addObject:[[Restaurant alloc] initWithName:@"Domino's Pizza" andAddress:@"9045 Corona Ave., Queens, NY 11373" andPhoneNum:@"(718) 457-3030" andRestImage:@""  andStarRating:3.2 andPricing:1 andCuisines:[[NSMutableArray alloc] init]]];
    
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
    
    NSData *imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: currentRestaurant.restImage]];;
    cell.image.image = [[UIImage alloc] initWithData:imageData];
    
    NSMutableString *pricingMoneySigns = [[NSMutableString alloc] init];
    
    for (int i = 0; i<currentRestaurant.pricing; i++) {
        [pricingMoneySigns appendString:@"$"];
    }
    
    cell.pricing.text = pricingMoneySigns;
    cell.rating.text = [[NSString alloc] initWithFormat:@"%.1f", currentRestaurant.starRating];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath; {
    
}

- (IBAction)searchAgain:(id)sender {
    [self resetVote];
    [_restaurants removeAllObjects];
    //[self searchForRestaurants];
    
    [_restaurants addObject:[[Restaurant alloc] initWithName:@"La Pequena Taste of Italy Pizza" andAddress:@"37-72 90th St, Jackson Heights, NY 11372" andPhoneNum:@"(718) 505-2600" andRestImage:@"" andStarRating:4.3 andPricing:2 andCuisines:[[NSMutableArray alloc] init]]];
    [_restaurants addObject:[[Restaurant alloc] initWithName:@"Pizza Sam" andAddress:@"89-06 Northern Blvd, Jackson Heights, NY 11372" andPhoneNum:@"(718) 335-3800" andRestImage:@"" andStarRating:4.1 andPricing:2 andCuisines:[[NSMutableArray alloc] init]]];
    [_restaurants addObject:[[Restaurant alloc] initWithName:@"Little Caesars Pizza" andAddress:@"86-10 Roosevelt Ave #27, Jackson Heights, NY 11372" andPhoneNum:@"(718) 205-2350" andRestImage:@"" andStarRating:4.0 andPricing:1 andCuisines:[[NSMutableArray alloc] init]]];
    [_restaurants addObject:[[Restaurant alloc] initWithName:@"Susano’s" andAddress:@"95-12 35th Ave, Flushing, NY 11372" andPhoneNum:@"(929) 349-1280" andRestImage:@""  andStarRating:5.0 andPricing:1 andCuisines:[[NSMutableArray alloc] init]]];
    
    [_searchResultTable reloadData];
}

- (IBAction)restartSearch:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)searchForRestaurants {
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
