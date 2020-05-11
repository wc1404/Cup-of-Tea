//
//  SearchResultCell.h
//  cupOfTea
//
//  Created by Wilfredo Cueto on 5/11/20.
//  Copyright © 2020 Nivvy Balakumar, Wilfredo Cueto. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchResultCell : UITableViewCell

@property int voteCount;

@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UILabel *cuisines;
@property (strong, nonatomic) IBOutlet UILabel *address;
@property (strong, nonatomic) IBOutlet UILabel *pricing;
@property (strong, nonatomic) IBOutlet UILabel *rating;
@property (strong, nonatomic) IBOutlet UILabel *phoneNum;

@property (strong, nonatomic) IBOutlet UILabel *voteCountLabel;


- (IBAction)voteButton:(id)sender;



@end

NS_ASSUME_NONNULL_END
