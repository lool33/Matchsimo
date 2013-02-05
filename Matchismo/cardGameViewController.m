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
#import "cardMatchingGame3Cards.h"

@interface cardGameViewController ()<UIAlertViewDelegate>



//outlet for the label on the UI
@property (weak, nonatomic) IBOutlet UILabel *numberOfTap;
//property to keep trace of the number of tap
@property(nonatomic) int TapCount;
//Collection of outlet to the cards in the UI
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
//instanciate the cardMatchingGame class
@property(strong,nonatomic)cardMatchingGame *game;
//Outlet to the ScoreLabale in the view
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
//property to the historicLabel in the View
@property (weak, nonatomic) IBOutlet UILabel *historicLabel;
//Outlet to the segmented control(Needed to disabme the segmented control during a game, and initialize the game at startUp)
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
//Outlet to the slider (Needed to set it's max and min proerty...
@property (weak, nonatomic) IBOutlet UISlider *HistorySlider;
@end

@implementation cardGameViewController


//lazy instantiation of the game
-(cardMatchingGame *)game
{
    
    if(!_game){
        
        if(self.segmentedControl.selectedSegmentIndex == 0){
            
            _game = [[cardMatchingGame alloc]initWithCardCount:[self.cardButtons count]
                                                     usingDeck:[[playingDeck alloc]init]];
            
        }else{
            
            _game = [[cardMatchingGame3Cards alloc]initWithCardCount:[self.cardButtons count]
                                                           usingDeck:[[playingDeck alloc]init]];
            
        }
        
    }
    
       return _game;
}




-(void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}

//use the setter of TapCount to update the label in the UI
-(void)setTapCount:(int)TapCount
{
    _TapCount = TapCount;
    
    self.numberOfTap.text = [NSString stringWithFormat:@"Card Touch: %d",_TapCount];
    
}

-(void)displayAnAlertYesNoWithTitle:(NSString *)title andMessage:(NSString *)message
{
    
    UIAlertView *prompt = [[UIAlertView alloc]initWithTitle:title
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:@"No"
                                          otherButtonTitles:@"Yes", nil];
    
    [prompt show];
    
    
}

#pragma mark - ViewLifcycle

-(void)viewDidLoad
{
    
    [super viewDidLoad];
    self.HistorySlider.minimumValue = 0;
    self.HistorySlider.maximumValue = 0;
    self.HistorySlider.value = self.HistorySlider.maximumValue;
    self.HistorySlider.enabled = NO;
    
}

#pragma mark - UpdateUI

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
        
        
        
        
        //Here we animate the selected button only for the flip
        if(cardButton.selected != card.isFaceUp){
            
            [UIView beginAnimations:@"flipbutton" context:NULL];
            [UIView setAnimationDuration:0.2];
            [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:cardButton cache:YES];
            [UIView commitAnimations];
            
        }
        
        
        //We make the button selected if the card is faceUp
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnPlayable;
        
        //We set the alpha to transparent if the card is unplayable and to opaque if playable
        cardButton.alpha = card.isUnPlayable ? 0.3 : 1;
        
        //We update the scoreLabel with the score coming from the model
        self.scoreLabel.text = [NSString stringWithFormat:@"Score : %d",self.game.score];
        
    }
    
    self.historicLabel.text = [self.game descriptionOfLastFlip];
    
    //check if the game is over
    if([self.game gameIsOver])
    {
        //game is over
        [self displayAnAlertYesNoWithTitle:@"You Finished the Game!!!" andMessage:@"Do you want to restart a new one?"];
    }

    
}

#pragma mark - Target/Action

//Action performed when a card is touch
//The model is now managing that
- (IBAction)cardTouch:(UIButton *)sender
{
    // We tell to the model that it need to flip a specified card in the game
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    
           self.TapCount ++;
    
    
    // and then we update the UI to let the model tell us what to display
    [self updateUI];
    
    //disable the segmented control for the first card flip
    if(self.segmentedControl.enabled = YES) self.segmentedControl.enabled = NO;
    //Enable the history slider after the first flip
    self.HistorySlider.enabled = YES;
    self.HistorySlider.maximumValue ++;
    self.HistorySlider.value = self.HistorySlider.maximumValue;
    self.HistorySlider.alpha = 1;
    
}

- (IBAction)gameModeChanged:(UISegmentedControl *)sender {
    
    self.game = nil;
    
    
}

- (IBAction)HistoryChanged:(UISlider *)sender {
    
    float sliderValue = sender.value;
    
    int intSliderValue = [[NSNumber numberWithFloat:sliderValue]intValue];
    
    //NSLog(@"the value of the slider is: %f and the int is: %d",sliderValue,intSliderValue);
    
    
    self.historicLabel.text = [self.game descriptionOfFlipAtIndex:intSliderValue];
    if(!self.historicLabel.text){
        self.historicLabel.text = [self.game descriptionOfLastFlip];
        
    }
    
    //setting the slider alpha
    if(sliderValue != self.HistorySlider.maximumValue){
        if(sliderValue > self.HistorySlider.maximumValue / 2){
            self.HistorySlider.alpha = 0.60;
        }else{
            self.HistorySlider.alpha = 0.35;
        }
        
    }else{
        self.HistorySlider.alpha = 1;
    }
    
}


- (IBAction)DealNewGame:(UIButton *)sender {
    /*when deal a new game is requested we should:
     1-prompt the user if he is sure (optionnal)
     2-reset all the UI Stuff (cardTouch, Score, cards...)
     3-ask to the model a new game
     */

    //1-prompt the user
    
    [self displayAnAlertYesNoWithTitle:@"Re-Deal" andMessage:@"Are you sure to restart the game?"];

}



#pragma mark - Delegate Methods

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    if(buttonIndex == 0){
        [alertView dismissWithClickedButtonIndex:0 animated:YES];
        
    }else{
        //2-Reste all the UI stuff
        //labels reset
        self.scoreLabel.text = @"Score:";
        self.TapCount = 0;
        self.numberOfTap.text = @"Card Touch:";
        self.historicLabel.text = nil;
        
        //3-reset the model to get a new game and reset it
        self.game = nil;
        
        //4-reset the history slider
        self.HistorySlider.minimumValue = 0;
        self.HistorySlider.maximumValue = 0;
        self.HistorySlider.value = self.HistorySlider.maximumValue;
        self.HistorySlider.enabled = NO;

        
        //5-update the cards
        [self updateUI];
        
        //6-enable the segmented control
        self.segmentedControl.enabled = YES;
        
    }
    
}



@end
