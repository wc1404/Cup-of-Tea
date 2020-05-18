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
    _searchWithTags = true;
    _searchEnabled = true;
    
    _tagCollection.delegate = self;
    
    _tags = [[NSMutableArray alloc] init];
    
    [_tagCollection reloadData];
    
    UITapGestureRecognizer *tapCancelEditing = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];

    [self.view addGestureRecognizer:tapCancelEditing];
    [tapCancelEditing setCancelsTouchesInView:NO];
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
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Please enter a tag." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    } else{
        // add input to array and clear text field
        NSString *tagEntered = _tagTextField.text;
        
        if ([tagEntered componentsSeparatedByString:@" "].count > 1) {
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Please enter cuisines with no spaces." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
            
            [alert addAction:defaultAction];
            
            [self presentViewController:alert animated:YES completion:nil];
        } else {
            
            [_tags addObject:tagEntered];
            _tagTextField.text = @"";
            
            [self.view endEditing:YES];
            
            [_tagCollection reloadData];
        }
    }
}

- (IBAction)infoScreen:(id)sender {
    _searchWithTags = false;
}

- (void)dismissKeyboard {
       [_tagTextField resignFirstResponder];
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender  {
    if([sender isEqual:_searchWithPreferencesButton]) {
        if(_tags.count > 0) {
            _searchEnabled = true;
            _searchWithTags = true;
        } else {
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Please enter tags to search with tags." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
            
            [alert addAction:defaultAction];
            
            [self presentViewController:alert animated:YES completion:nil];
        }
    } else if([sender isEqual:_randomSearchButton]) {
        _searchEnabled = true;
        _searchWithTags = false;
    }
    
//    if(_searchWithTags && _tags.count <= 0) {
//        NSLog(@"Alert User: Tags Enabled with No tags");
//        return false;
//    }
//
//    NSLog(@"Passing to Segue Prepare with:");
//    if(_searchEnabled) {
//        NSLog(@"Search Enabled");
//    } else {
//        NSLog(@"Search Disabled");
//    }
//
//    if(_searchWithTags) {
//        NSLog(@"Tags Enabled with: %lu tags", (unsigned long)_tags.count);
//    } else {
//        NSLog(@"Tags Disabled");
//    }
//    NSLog(@"END");
    
    return _searchEnabled;
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    SearchResultViewController *searchResultScreen = segue.destinationViewController; // add view instance for switch and data transfer
    searchResultScreen.tags = _tags; // Send tags to search screen
    
    if([sender isEqual:_infoScreenButton]) {
        _searchEnabled = false;
        _searchWithTags = false;
    }
    
    searchResultScreen.searchEnabled = _searchEnabled;
    searchResultScreen.searchWithTags = _searchWithTags;
}

@end
