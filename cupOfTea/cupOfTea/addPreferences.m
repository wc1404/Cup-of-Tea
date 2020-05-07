//
//  addPreferences.m
//  cupOfTea
//
//  Created by nivvy balakumar on 5/6/20.
//  Copyright © 2020 Nivvy Balakumar, Wilfredo Cueto. All rights reserved.
//

#import "addPreferences.h"

@interface addPreferences ()

@end

@implementation addPreferences

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tags = [[NSMutableArray alloc] init];
}

// when user presses +, add user input tags into array
- (IBAction)addTag:(id)sender {
    // alert if invalid input
    if ([_textBarAdd.text  isEqual: @""]){
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Alert"
        message:@"Please enter a valid tag."
        preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
           handler:^(UIAlertAction * action) {}];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    } else{
        // add input to array and clear text field
        [_tags addObject:_textBarAdd.text];
        _textBarAdd.text = @"";
        //for (NSString *i in _tags)
        //{NSLog(@"%@", i);}
    }
}

- (NSInteger)prefView:(UICollectionView *)prefView numberOfItemsInSection:(NSInteger)section {
    return _tags.count;
}
- (UICollectionViewCell *)prefView:(UICollectionView *)prefView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    
    UICollectionViewCell *cell = [prefView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    /*
    
     */
    
    return cell;
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
