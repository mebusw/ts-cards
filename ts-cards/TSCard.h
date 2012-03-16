//
//  TSCard.h
//  ts-cards
//
//  Created by mebusw on 12-3-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSCard : NSObject


@property (nonatomic) int number;
@property (nonatomic, strong) NSString *title;
@property (nonatomic) int ops;
@property (nonatomic, strong) NSString *side;
@property (nonatomic, strong) NSString *period;
@property (nonatomic, strong) NSString *event;
@property (nonatomic, strong) NSString *europe;
@property (nonatomic, strong) NSString *asia;
@property (nonatomic, strong) NSString *middle_east;
@property (nonatomic, strong) NSString *south_america;
@property (nonatomic, strong) NSString *central_america;
@property (nonatomic, strong) NSString *africa;
@property (nonatomic, strong) NSString *se_asia;
@property (nonatomic) int vp;
@property (nonatomic, strong) NSString *not_defcon2;
@property (nonatomic, strong) NSString *disposable;
@property (nonatomic, strong) NSString *sustained;

@end
