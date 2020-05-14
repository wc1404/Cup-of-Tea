//
//  PreviouslyVisitedViewController.m
//  cupOfTea
//
//  Created by Wilfredo Cueto on 5/11/20.
//  Copyright © 2020 Nivvy Balakumar, Wilfredo Cueto. All rights reserved.
//

#import "PreviouslyVisitedViewController.h"

@interface PreviouslyVisitedViewController ()

@end

@implementation PreviouslyVisitedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _visitedTable.delegate = self;
    _visitedTable.dataSource = self;
    
    _restaurants = [[NSMutableArray alloc] init];
    
    [_restaurants addObject:[[Restaurant alloc] initWithName:@"Satori Burgers" andAddress:@"9109 31st Ave, East Elmhurst, NY 11369" andPhoneNum:@"(718) 205-7676" andRestImage:@"" andDescription:@"" andStarRating:4 andPricing:2 andCuisines:[[NSMutableArray alloc] init]]];
    [_restaurants addObject:[[Restaurant alloc] initWithName:@"Sammy's Halal Food" andAddress:@"Broadway &, 73rd St, Jackson Heights, NY 11372" andPhoneNum:@"(718) 775-8369" andRestImage:@"" andDescription:@"" andStarRating:4 andPricing:1 andCuisines:[[NSMutableArray alloc] init]]];
    [_restaurants addObject:[[Restaurant alloc] initWithName:@"Asian Taste 86 Halal Indonesian Fusion" andAddress:@"86-10 Whitney Ave, Elmhurst, NY 11373" andPhoneNum:@"(718) 779-8686" andRestImage:@"" andDescription:@"" andStarRating:5 andPricing:1 andCuisines:[[NSMutableArray alloc] init]]];
    [_restaurants addObject:[[Restaurant alloc] initWithName:@"Sea Star" andAddress:@"91-21 37th Ave, Jackson Heights, NY 11372" andPhoneNum:@"(718) 458-4742" andRestImage:@"" andDescription:@"" andStarRating:4 andPricing:1 andCuisines:[[NSMutableArray alloc] init]]];
    [_restaurants addObject:[[Restaurant alloc] initWithName:@"Rincon Criollo" andAddress:@"40-09 Junction Blvd, Corona, NY 11368" andPhoneNum:@"(718) 458-0236" andRestImage:@"" andDescription:@"" andStarRating:5 andPricing:3 andCuisines:[[NSMutableArray alloc] init]]];

    
    [_visitedTable reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _restaurants.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"VisitedRestaurantCell";
    
    VisitedRestaurantCell *cell = [_visitedTable dequeueReusableCellWithIdentifier:cellIdentifier];
    
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

@end