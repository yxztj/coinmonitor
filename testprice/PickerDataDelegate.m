//
//  PickerDataDelegate.m
//  testprice
//
//  Created by Jason on 14-1-16.
//  Copyright (c) 2014年 Jason. All rights reserved.
//

#import "PickerDataDelegate.h"

@implementation PickerDataDelegate

-(id) init
{
    if(self=[super init])
    {
        NSBundle *bundle = [NSBundle mainBundle];//此调用的返回的束对象表示我们的应用程序
        NSString *path = [bundle pathForResource:@"market_coin" ofType:@"plist"];
        NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:path];
        self.dictionary = dic;
        
        NSArray *rootArray = [self.dictionary allKeys];
        NSArray *root = [rootArray sortedArrayUsingSelector:@selector(compare:)];
        self.fatherArray = root;
        
        NSString *fatherSec = [self.fatherArray objectAtIndex:0];
        NSArray *array = [self.dictionary objectForKey:fatherSec];
        self.childerArray = array;
        
    }
    return self;
}

//数据源协议方法实现
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == mFather) {
        return [self.fatherArray count];
    }else {
        return [self.childerArray count];
    }
}


//选取器委托方法实现
//显示在view上
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(component == mFather){
        return [self.fatherArray objectAtIndex:row];
    }else {
        return [self.childerArray objectAtIndex:row];
    }
}

//一个选取器选取改变另一个依赖得选择器
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == mFather) {
        NSString *string = [self.fatherArray objectAtIndex:row];
        NSArray *array = [self.dictionary objectForKey:string];
        self.childerArray = array;
        [pickerView selectRow:0 inComponent:mChilder animated:YES];
        [pickerView reloadComponent:mChilder];
        
        self.selectedMarket=string;
    }
    else
    {
        self.selectedCoin=[self.childerArray objectAtIndex:row];
    }
    
    NSLog(@"触发依赖");
}
//改变两个部件宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if(component == mFather)
        return (200);
    return 100;
}

@end
