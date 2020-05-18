//
//  SearchViewController.h
//  cupOfTea
//
//  Created by Wilfredo Cueto on 5/10/20.
//  Copyright © 2020 Nivvy Balakumar, Wilfredo Cueto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TagCell.h"
#import "SearchResultViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SearchViewController : UIViewController <UICollectionViewDelegate,UICollectionViewDataSource>

@property bool searchWithTags;
@property bool searchEnabled;

@property (strong, nonatomic) IBOutlet UICollectionView *tagCollection;

@property (strong, nonatomic) NSMutableArray *tags;

@property (strong, nonatomic) IBOutlet UITextField *tagTextField;

- (IBAction)addTag:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *randomSearchButton;
@property (strong, nonatomic) IBOutlet UIButton *searchWithPreferencesButton;
@property (strong, nonatomic) IBOutlet UIButton *infoScreenButton;

- (IBAction)infoScreen:(id)sender;

@end

NS_ASSUME_NONNULL_END
