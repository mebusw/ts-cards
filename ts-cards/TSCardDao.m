//
//  TSCardDao.m
//  ts-cards
//
//  Created by mebusw on 12-3-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TSCardDao.h"
#import "TSCard.h"
#import "FMResultSet.h"

@implementation TSCardDao

-(TSCard*) parseCards:(FMResultSet*)rs {
    TSCard *card = [[TSCard alloc] init];
    card.number = [rs intForColumnIndex:0];
    card.title = [rs stringForColumnIndex:1];
    card.ops = [rs intForColumnIndex:2];
    card.side = [rs stringForColumnIndex:3];
    card.period = [rs stringForColumnIndex:4];
    card.event = [rs stringForColumnIndex:5];
    card.europe = [rs stringForColumnIndex:6];
    card.asia = [rs stringForColumnIndex:7];
    card.middle_east = [rs stringForColumnIndex:8];
    card.south_america = [rs stringForColumnIndex:9];
    card.central_america = [rs stringForColumnIndex:10];
    card.africa = [rs stringForColumnIndex:11];
    card.se_asia = [rs stringForColumnIndex:12];
    card.vp = [rs intForColumnIndex:13];
    card.not_defcon2 = [rs stringForColumnIndex:14];
    card.disposable = [rs stringForColumnIndex:15];
    card.sustained = [rs stringForColumnIndex:16];
    
    return card;
}

-(NSArray*)selectByNumber: (int)number {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    FMResultSet *rs = [db executeQuery: [NSString stringWithFormat:@"select * from cards where number='%d'", number]];

    while ([rs next]) {
        [result addObject:[self parseCards:rs]];
    }
    [rs close];
    return result;
}


@end
