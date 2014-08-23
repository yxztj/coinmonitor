//
//  PriceDataElement.h
//  testprice
//
//  Created by Jason on 14-1-13.
//  Copyright (c) 2014年 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef  struct {
    
    float Price;
    float Volume;
    
}PriceVolumePair;

@interface PriceDataElement : NSObject

//@property (readwrite) NSString *name;
@property (readwrite) float current_Price;
@property (readwrite) float old_Price;
@property (readwrite) NSDate *updateTime;
@property (readwrite) NSString* imageName;
@property float highest;
@property float lowest;
@property float volume;
@property NSMutableArray* lstBuy;
@property NSMutableArray* lstSell;

//-(id) initWithName:(NSString*) name;

@end
