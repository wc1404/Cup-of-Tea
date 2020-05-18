//
//  PreviouslyVisitedViewController.m
//  cupOfTea
//
//  Created by Wilfredo Cueto on 5/11/20.
//  Copyright © 2020 Nivvy Balakumar, Wilfredo Cueto. All rights reserved.
//

#import "PreviouslyVisitedViewController.h"

@interface PreviouslyVisitedViewController ()

@property (strong, nonatomic) NSFetchedResultsController *fetchController;

@end

@implementation PreviouslyVisitedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _visitedTable.delegate = self;
    _visitedTable.dataSource = self;
    
    [self loadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
   return 5;
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
    
    static NSString *cellIdentifier = @"VisitedRestaurantCell";
    
    VisitedRestaurantCell *cell = [_visitedTable dequeueReusableCellWithIdentifier:cellIdentifier];
    
    NSString *currentRestaurant = [[_restaurants objectAtIndex:indexPath.section] restaurantPlaceID];
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath; {
    
}

- (IBAction)reloadData:(id)sender {
    [self loadData];
}

- (void)loadData {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Restaurants"];
     
    NSError *error = nil;
    
    NSArray *results = [context executeFetchRequest:request error:&error];
    if (!results) {
        NSLog(@"Error fetching Restaurant objects: %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
    
    _restaurants = results;
    
    [_visitedTable reloadData];
}

@end
