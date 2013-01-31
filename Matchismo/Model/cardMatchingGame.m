//
//  cardMatchingGame.m
//  Matchismo
//
//  Created by Laurent GAIDON on 31/01/13.
//  Copyright (c) 2013 Laurent GAIDON. All rights reserved.
//

#import "cardMatchingGame.h"

@interface cardMatchingGame ()

@property(nonatomic,strong) NSMutableArray *cards; //of cards
@property(nonatomic) int score; //already declared as readOnly in header. So make it read/write in our implementation

@end


@implementation cardMatchingGame

//lazy instantiation of the cards property
-(NSMutableArray *)cards
{
    if(!_cards) _cards = [[NSMutableArray alloc]init];
    return _cards;
}


//implementation of the designated initializer
-(id)initWithCardCount:(NSUInteger)cardCount
             usingDeck:(deck *)deck
{
    self = [super init];
    //checking for correct super init
    if(self)
    {
        //iteration over the number of card
        for (int i = 0; i < cardCount; i++) {
            //asking a random card to the deck
            card *card = [deck drawRandomCard];
            //check if the card exist to avoid ading nil in our array that will crash the app
            if(!card)
            {
                //We return nil if we can't initialize ourself
                self = nil;
                
            }else{
                //if we have a correct card then add it to our poperty
                self.cards[i] = card;
            }
        }
        
    }
    
    return self;
}


-(void)flipCardAtIndex:(NSUInteger)index
{
    
    
    
}

//We return the card for the given index after checking that the index is not out of bounds
-(card *)cardAtIndex:(NSUInteger)index
{
    return (index < self.cards.count) ? self.cards[index] : nil;
    
}


@end
