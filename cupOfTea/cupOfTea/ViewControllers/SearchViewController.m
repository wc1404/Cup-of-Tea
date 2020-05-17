//
//  SearchViewController.m
//  cupOfTea
//
//  Created by Wilfredo Cueto on 5/10/20.
//  Copyright © 2020 Nivvy Balakumar, Wilfredo Cueto. All rights reserved.
//

#import "SearchViewController.h"

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tagCollection.delegate = self;
    
    _tags = [[NSMutableArray alloc] init];
    
    [_tagCollection reloadData];
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"TagCell";
    
    TagCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];

    NSString *text = [_tags objectAtIndex:indexPath.row];
    
    cell.tagLabel.text = text;

    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _tags.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *selected = [_tags objectAtIndex:indexPath.row];
    
    [_tags removeObjectIdenticalTo:selected];
    
    [_tagCollection reloadData];
}

- (IBAction)addTag:(id)sender {
    if ([_tagTextField.text  isEqual: @""]){
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Please enter a valid tag." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    } else{
        // add input to array and clear text field
        [_tags addObject:_tagTextField.text];
        
        _tagTextField.text = @"";
        
        [_tagCollection reloadData];
    }
}
- (IBAction)randomSearch:(id)sender {
    [_tags removeAllObjects];
    [_tagCollection reloadData];
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    SearchResultViewController *searchResultScreen = segue.destinationViewController; // add view instance for switch and data transfer
    searchResultScreen.tags = _tags; // Send tags to search screen
}


@end
