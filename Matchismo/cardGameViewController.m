//
//  cardGameViewController.m
//  Matchismo
//
//  Created by Laurent GAIDON on 28/01/13.
//  Copyright (c) 2013 Laurent GAIDON. All rights reserved.
//

#import "cardGameViewController.h"
#import "playingDeck.h"
#import "Card.h"
#import "cardMatchingGame.h"

@interface cardGameViewController ()



//outlet for the label on the UI
@property (weak, nonatomic) IBOutlet UILabel *numberOfTap;
//property to keep trace of the number of tap
@property(nonatomic) int TapCount;
//Collection of outlet to the cards in the UI
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

@property(strong,nonatomic)cardMatchingGame *game;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (weak, nonatomic) IBOutlet UILabel *historicLabel;
@end

@implementation cardGameViewController



//lazy instantiation of the game
-(cardMatchingGame *)game
{
    if(!_game) _game = [[cardMatchingGame alloc]initWithCardCount:[self.cardButtons count]
                                                        usingDeck:[[playingDeck alloc]init]];
    return _game;
}



-(void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}


//Method used to update the UI by asking what happen to the model
-(void)updateUI
{
        
    //iterate over the each cards in the UI and ask the model for what to display
    for (UIButton *cardButton in self.cardButtons) {
        //We get the card from the model
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        
        //We set the button's image to be the card in the selected state
        [cardButton setImage:[UIImage imageNamed:card.imageName]
                    forState:UIControlStateSelected];
        
        [cardButton setImage:[UIImage imageNamed:card.imageName]
                    forState:UIControlStateSelected|UIControlStateDisabled];
        
        
        
        //We select the button if the card is faceUp
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnPlayable;
        
        //We set the alpha to transparent if the card is unplayable and to opaque if playable
        cardButton.alpha = card.isUnPlayable ? 0.3 : 1;
        
        //We update the scoreLabel with the score coming from the model
        self.scoreLabel.text = [NSString stringWithFormat:@"Score : %d",self.game.score];
        
    }
    
    self.historicLabel.text = [self.game descriptionOfLastFlip];

    
}


//use the setter of TapCount to update the label in the UI
-(void)setTapCount:(int)TapCount
{
    _TapCount = TapCount;
    
    self.numberOfTap.text = [NSString stringWithFormat:@"Card Touch: %d",_TapCount];
    
}


//Action performed when a card is touch
//The model is now managing that
- (IBAction)cardTouch:(UIButton *)sender
{
    // We tell to the model that it need to flip a specified card in the game
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    
           self.TapCount ++;
    
    
    // and then we update the UI to let the model tell us what to display
    [self updateUI];
    
}




@end
