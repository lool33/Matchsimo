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

@interface cardGameViewController ()

//The Deck to play with
@property(nonatomic,strong) playingDeck *deck;

//outlet for the label on the UI
@property (weak, nonatomic) IBOutlet UILabel *numberOfTap;
//property to keep trace of the number of tap
@property(nonatomic) int TapCount;
//Collection of outlet to the cards in the UI
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

@end

@implementation cardGameViewController


//Lasy instantiation of the Deck
-(playingDeck *)deck
{
    
    if(!_deck) _deck = [[playingDeck alloc]init];
    
    return _deck;

}


-(void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    //Use a for loop to fill each button in the collection with a card
    for (UIButton *cardButton in cardButtons) {
        Card *card = [self.deck drawRandomCard];
        [cardButton setImage:[UIImage imageNamed:card.imageName] forState:UIControlStateSelected];
    }
    
}




//use the setter of TapCount to update the label in the UI
-(void)setTapCount:(int)TapCount
{
    _TapCount = TapCount;
    
    self.numberOfTap.text = [NSString stringWithFormat:@"Card request: %d",_TapCount];
    
}


//Action performed when a card is touch
//This method will be modified to match new requirement
- (IBAction)cardTouch:(UIButton *)sender {
    
    //1-Reverse the button state (selected state or unselected state)
    sender.selected = !sender.isSelected;
    /*
    //2-Draw the card figure if in state selected
    if(sender.selected)
    {
        //2.1-retrieve a random card from the deck
        card *card = [self.deck drawRandomCard];
        
        //if we have a card
        if(card){
            //2.2-set the title of the button in the UI with the suit and ranl of the card (not usefull if we perform step 2.3 below)
            [sender setTitle:card.contents forState:UIControlStateSelected];
            //2.3-set the image of the card in the UI 
            [sender setImage:[UIImage imageNamed:card.imageName] forState:UIControlStateSelected];
            //2.4-Increase the TapCount property to track the number of tap
            self.TapCount ++;
            
        }
    }
    */
     self.TapCount ++;
}




@end
