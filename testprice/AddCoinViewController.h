//
//  AddCoinViewController.h
//  testprice
//
//  Created by Jason on 14-1-16.
//  Copyright (c) 2014年 Jason. All rights reserved.
//

#import "RootCoinViewController.h"

@interface AddCoinViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIPickerView *pckCoin;
@property (nonatomic) PickerDataDelegate *pickerdataDelegate;
@property TableDataDelegate* tabledataDelegate;
@property RootCoinViewController *mainView;
@end
