//
//  PickerDataDelegate.h
//  testprice
//
//  Created by Jason on 14-1-16.
//  Copyright (c) 2014年 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TableDataDelegate.h"

#define mFather   0
#define mChilder  1

@interface PickerDataDelegate : NSObject<UIPickerViewDelegate,UIPickerViewDataSource>

@property(retain ,nonatomic) IBOutlet UIPickerView *dependentPickerView; 
@property(retain,nonatomic) NSArray *fatherArray;
@property(retain,nonatomic) NSArray *childerArray;
@property(retain, nonatomic) NSDictionary *dictionary;
@property TableDataDelegate *tabledataDelegate;



@property NSString* selectedMarket;
@property NSString* selectedCoin;

@end
