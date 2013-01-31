//
//  deck.m
//  Matchismo
//
//  Created by Laurent GAIDON on 28/01/13.
//  Copyright (c) 2013 Laurent GAIDON. All rights reserved.
//
//  Class that define a deck of cards

#import "deck.h"

@interface deck ()
//need a private property to store the cards
@property(nonatomic,strong)NSMutableArray *cards;
@end

@implementation deck

//Getter of cards property
-(NSMutableArray *)cards
{
    //lazy instantiation
    if(!_cards) _cards = [[NSMutableArray alloc]init];
    
    return _cards;
}


-(void)addCard:(Card *)card onTop:(BOOL)ontop
{
    
    if(card){
        
        if(ontop){
            [self.cards insertObject:card atIndex:0];
        
        }else{
            [self.cards addObject:card];
            
        }
    }
    
}

-(Card *)drawRandomCard
{
 
    Card *card = nil;
    
    if(self.cards.count){
    
    unsigned index = arc4random() % [self.cards count];
    card = self.cards[index];
    [self.cards removeObjectAtIndex:index];
        
    }
    
    return card;
}

@end
