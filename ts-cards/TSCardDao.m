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
    card.number = [rs stringForColumnIndex:0];
    card.title = [rs stringForColumnIndex:1];
    return card;
}

-(NSArray*)selectByNumber: (NSString*)number {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    FMResultSet *rs = [db executeQuery: [NSString stringWithFormat:@"select * from cards where number='%@'", number]];

    while ([rs next]) {
        [result addObject:[self parseCards:rs]];
    }
    [rs close];
    return result;
}


@end
