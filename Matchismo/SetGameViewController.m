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


-(void)updateCards
{
    
    //iterate over the each cards in the UI and ask the model for what to display
    for (UIButton *cardButton in self.cardButtons) {
        //We get the card from the model
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        
        //We set the button's image to be the card in the selected state
        [cardButton setAttributedTitle:card.contentsAttributed
                              forState:UIControlStateSelected];
        //We also would like to display the content in the selected AND disabled state
        [cardButton setAttributedTitle:card.contentsAttributed forState:UIControlStateSelected|UIControlStateDisabled];
        
        //We would also display to the user in a unselected state (to have an easier game)
        [cardButton setAttributedTitle:card.contentsAttributed
                              forState:UIControlStateNormal];
        
        
        /*
         Instead of animate, we probably would like to make something (highligh the selection or something)
        //Here we animate the selected button only for the flip
        if(cardButton.selected != card.isFaceUp){
            
            [UIView beginAnimations:@"flipbutton" context:NULL];
            [UIView setAnimationDuration:0.2];
            [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:cardButton cache:YES];
            [UIView commitAnimations];
            
        }
        */
        
        //We make the button selected if the card is faceUp
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnPlayable;
        
        //We hide the button if the card is unplayable and to opaque if playable
        cardButton.alpha = card.isUnPlayable ? 0 : 1;
        
    }
    
    
}

-(NSString *)flipTranslationFromDictionnary:(NSDictionary *)flipDictionnary
{
    
    
    return nil;
}


@end
