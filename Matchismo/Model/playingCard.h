//
//  playingCard.h
//  Matchismo
//
//  Created by Laurent GAIDON on 28/01/13.
//  Copyright (c) 2013 Laurent GAIDON. All rights reserved.
//

#import "card.h"

@interface playingCard : card

@property(nonatomic,strong) NSString *suits;
@property(nonatomic) NSUInteger rank;

+(NSArray *)validSuits;

+(NSUInteger)maxRank;


@end
