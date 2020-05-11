//
//  SearchResultCell.m
//  cupOfTea
//
//  Created by Wilfredo Cueto on 5/11/20.
//  Copyright © 2020 Nivvy Balakumar, Wilfredo Cueto. All rights reserved.
//

#import "SearchResultCell.h"

@implementation SearchResultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _voteCount = 0;
    _voteCountLabel.text = @"0";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)voteButton:(id)sender {
    _voteCount += 1;
    _voteCountLabel.text = [NSString stringWithFormat:@"%d",_voteCount];
}

@end
