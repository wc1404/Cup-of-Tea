//
//  addPreferences.h
//  cupOfTea
//
//  Created by nivvy balakumar on 5/6/20.
//  Copyright © 2020 Nivvy Balakumar, Wilfredo Cueto. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface addPreferences : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *plusAdd;
@property (weak, nonatomic) IBOutlet UITextField *textBarAdd;
@property (weak, nonatomic) IBOutlet UICollectionView *prefView;

// array of user input tags
@property (strong, nonatomic) NSMutableArray *tags;


@end

NS_ASSUME_NONNULL_END
