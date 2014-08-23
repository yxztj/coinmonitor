//
//  CoinTableCell.m
//  testprice
//
//  Created by Jason on 14-1-18.
//  Copyright (c) 2014年 Jason. All rights reserved.
//

#import "CoinTableCell.h"

@implementation CoinTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews

{
    [super layoutSubviews];
    
    [self.imageView setFrame:CGRectMake(10, 10,29, 29)];
    
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
}

@end
