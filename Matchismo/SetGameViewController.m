//
//  SetGameViewController.m
//  Matchismo
//
//  Created by Laurent GAIDON on 10/02/13.
//  Copyright (c) 2013 Laurent GAIDON. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetMatchingGame.h"
#import "SetDeck.h"

@interface SetGameViewController ()

@property (nonatomic,strong)SetMatchingGame *game;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

@end

@implementation SetGameViewController

//lazy instantiation of the game
-(SetMatchingGame *)game
{
    
    if(!_game){
        
        _game = [[SetMatchingGame alloc]initWithCardCount:[self.cardButtons count]
                                                 usingDeck:[[SetDeck alloc]init]];
    }
    
    return _game;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    
}

-(void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateCards];
}

-(void)updateCards
{
    
    //iterate over the each cards in the UI and ask the model for what to display
    for (UIButton *cardButton in self.cardButtons) {
        //We get the card from the model
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        
        //We set the button Title to be the card in the selected state, we also highlight the button to show the user it's selected
        [cardButton setAttributedTitle:card.contentsAttributed
                              forState:UIControlStateSelected];
        
        
        //We also would like to display the content in the selected AND disabled state
        [cardButton setAttributedTitle:card.contentsAttributed forState:UIControlStateSelected|UIControlStateDisabled];
        
        //We would also display to the user in a unselected state (to have an easier game)
        [cardButton setAttributedTitle:card.contentsAttributed
                              forState:UIControlStateNormal];
        
        
        //We make the button selected if the card is faceUp
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnPlayable;
        
        if(cardButton.selected == YES){
            [cardButton setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.5]];
        }else{
            [cardButton setBackgroundColor:[UIColor clearColor]];
        }
        
        //We hide the button if the card is unplayable and to opaque if playable
        cardButton.alpha = card.isUnPlayable ? 0 : 1;
        
    }
    
    
}

-(NSAttributedString *)flipTranslationFromDictionnary:(NSDictionary *)flipDictionnary
{
    Card *firstCard = flipDictionnary[FIRST_CARD];
    Card *secondCard = flipDictionnary[SECOND_CARD];
    Card *thirdCard = flipDictionnary[THIRD_CARD];
    NSNumber *score = flipDictionnary[MATCH_SCORE];
    BOOL mismatch = NO;
    if([flipDictionnary[MISMATCH] isEqualToString:@"YES"]) mismatch = YES;
    
    NSAttributedString *firstCardAttString = firstCard.contentsAttributed;
    NSAttributedString *secondCardAttString = secondCard.contentsAttributed;
    NSAttributedString *thirdCardAttString = thirdCard.contentsAttributed;
    
    NSAttributedString *response = nil;
    
    //here this is a single flip
    if(firstCard && !secondCard && !mismatch){
        //response =  [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"You flipped up the %@ it cost you %d points",firstCardAttString,[score intValue]]];
        
        
        return firstCardAttString;
        
        //here is a set mismatch
    }else if (firstCard && secondCard && mismatch){
        response = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ / %@ And %@ don't match! it cost you %d points",firstCardAttString,secondCardAttString,thirdCardAttString, [score intValue]]];
        return firstCardAttString;
        
        //here is a set match
    }else if(firstCard && secondCard){
        response = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@ %@ is a SET! You win %d points",firstCardAttString,secondCardAttString,thirdCardAttString,[score intValue]]];
        return firstCardAttString;
        
    }else{
        return nil;
    }
    
}


@end
