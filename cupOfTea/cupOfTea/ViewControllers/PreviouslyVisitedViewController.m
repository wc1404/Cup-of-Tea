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
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Configure the request's entity, and optionally its predicate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    _fetchController = [[NSFetchedResultsController alloc]
            initWithFetchRequest:fetchRequest
            managedObjectContext:context
            sectionNameKeyPath:nil
            cacheName:@""];
     
//    NSError *error;
//    BOOL success = [controller performFetch:&error];
    
    [_visitedTable reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
   return 5;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *separationView = [UIView new];
    [separationView setBackgroundColor:[UIColor clearColor]];
    return separationView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[_fetchController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([[_fetchController sections] count] > 0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[_fetchController sections] objectAtIndex:section];
        return [sectionInfo numberOfObjects];
    } else
        return 0;
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"VisitedRestaurantCell";
    
    VisitedRestaurantCell *cell = [_visitedTable dequeueReusableCellWithIdentifier:cellIdentifier];
    
    //Restaurant *currentRestaurant = [_restaurants objectAtIndex:indexPath.section];
    Restaurants *currentRestaurantData = [_fetchController objectAtIndexPath:indexPath];
    
    cell.name.text = currentRestaurantData.name;
    cell.address.text = currentRestaurantData.address;
    cell.phoneNum.text = currentRestaurantData.phoneNum;
    
    NSMutableString *pricingMoneySigns = [[NSMutableString alloc] init];
    
    for (int i = 0; i<currentRestaurantData.pricing; i++) {
        [pricingMoneySigns appendString:@"$"];
    }
    
    cell.pricing.text = pricingMoneySigns;
    cell.rating.text = [[NSString alloc] initWithFormat:@"%.1f", currentRestaurantData.starRating];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath; {
    
}

@end
