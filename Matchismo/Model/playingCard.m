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


-(NSString *)contents
{
    
    NSArray *rankStrings = [playingCard rankStrings];
    return [NSString stringWithFormat:@"%@-%@",self.suit,rankStrings[self.rank]];
    
}

//Implementation of getter AND stter of suit property
//So we have to @synthesize

@synthesize suit = _suit;

-(NSString *)suit
{
    
    return _suit ? _suit : @"?";
    
}

-(void)setSuit:(NSString *)suit
{
    if(_suit != suit)
    {
        if([[playingCard validSuits] containsObject:suit])
        {
            _suit = suit;
            
        }
        
    }
    
}

-(void)setRank:(NSUInteger)rank
{
    
    if(rank <= [playingCard maxRank]){
        
        _rank = rank;
    }
    
}

-(NSString *)imageName
{
    return [self.contents stringByAppendingString:@"-75.png"];
}


@end
