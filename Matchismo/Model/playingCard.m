//
//  playingCard.m
//  Matchismo
//
//  Created by Laurent GAIDON on 28/01/13.
//  Copyright (c) 2013 Laurent GAIDON. All rights reserved.
//

#import "playingCard.h"


@implementation playingCard


//Override the method match
-(int)match:(NSArray *)otherCards
{
    
    int score = 0;
    
    //to match only a single card, should be modified in homework
    if(otherCards.count == 1)
    {
        playingCard *otherCard = [otherCards lastObject];
        
        if([otherCard.suit isEqualToString:self.suit])
        {
            score = 1;
        }else if(otherCard.rank == self.rank)
        {
            score = 4;
        }
        
    }else if(otherCards.count == 2){
     
        playingCard *firstCard = otherCards[0];
        playingCard *secondCard = otherCards[1];
        
        //check to see if there is a suit match between the 3 cards
        if([firstCard.suit isEqualToString:secondCard.suit]){
            //the first 2 cards match in suit
            if([self.suit isEqualToString:firstCard.suit]){
                //it means the 3 cards match in suit
                score = 5;
            }
        }else if (firstCard.rank == secondCard.rank){
            //the first 2 cards match in rank
            if(self.rank == firstCard.rank){
            
                score = 10;
                
            }
            
        }
        
    }
    
    return score;
}


//Class method returning the valid suits allowed
+(NSArray *)validSuits
{
    return @[@"♣",@"♦",@"♥",@"♠"];
}

//Class method returning the valid rank allowed in a string form
+(NSArray *)rankStrings
{
    
    return @[@"?",@"a",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
    
}


//Class method returing the max rank allowed
+(NSUInteger)maxRank
{
    return [[self rankStrings] count] - 1;
  
}

//Instance method returning the concatenation of the rank and the suit of the card
//override the getter form the superClass
-(NSString *)contents
{
    
    NSArray *rankStrings = [playingCard rankStrings];
    return [NSString stringWithFormat:@"%@ %@",rankStrings[self.rank],self.suit];
    
}

//Implementation of getter AND stter of suit property
//So we have to @synthesize

@synthesize suit = _suit;
//getter of suit securing the fact the the card has no suit defined
-(NSString *)suit
{
    return _suit ? _suit : @"?";
}

//setter securing the fact that the card to set has no correct suit
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

//setter securing the rank of the card (no bad rank allowed)
-(void)setRank:(NSUInteger)rank
{
    
    if(rank <= [playingCard maxRank]){
        
        _rank = rank;
    }
    
}

//returning the card's image file name
-(NSString *)imageName
{
    NSArray *rankStrings = [playingCard rankStrings];
    
    if([self.suit isEqualToString:@"♣"]){
        return [NSString stringWithFormat:@"clubs-%@-75.png",rankStrings[self.rank]];
        
    }else if([self.suit isEqualToString:@"♦"]){
        return [NSString stringWithFormat:@"diamonds-%@-75.png",rankStrings[self.rank]];
        
    }else if ([self.suit isEqualToString:@"♥"]){
        return [NSString stringWithFormat:@"hearts-%@-75.png",rankStrings[self.rank]];
        
    }else if ([self.suit isEqualToString:@"♠"]){
        return [NSString stringWithFormat:@"spades-%@-75.png",rankStrings[self.rank]];
        
    }else{
        return nil;
    }
    
    
}


@end
