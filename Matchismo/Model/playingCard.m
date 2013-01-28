//
//  playingCard.m
//  Matchismo
//
//  Created by Laurent GAIDON on 28/01/13.
//  Copyright (c) 2013 Laurent GAIDON. All rights reserved.
//

#import "playingCard.h"

@implementation playingCard

+(NSArray *)validSuits
{
    return @[@"clubs",@"diamonds",@"hearts",@"spades"];
}






+(NSArray *)rankStrings
{
    
    return @[@"?",@"a",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"j",@"q",@"k"];
    
}



+(NSUInteger)maxRank
{
    return [[self rankStrings] count] - 1;
  
}


@end
