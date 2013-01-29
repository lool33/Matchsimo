//
//  cardGameViewController.m
//  Matchismo
//
//  Created by Laurent GAIDON on 28/01/13.
//  Copyright (c) 2013 Laurent GAIDON. All rights reserved.
//

#import "cardGameViewController.h"
#import "playingDeck.h"
#import "card.h"

@interface cardGameViewController ()

@property(nonatomic,strong) playingDeck *deck;

@property (weak, nonatomic) IBOutlet UILabel *numberOfTap;
@property(nonatomic) int TapCount;

@end

@implementation cardGameViewController



-(playingDeck *)deck
{
    
    if(!_deck) _deck = [[playingDeck alloc]init];
    
    return _deck;

}

-(void)setTapCount:(int)TapCount
{
    _TapCount = TapCount;
    
    self.numberOfTap.text = [NSString stringWithFormat:@"Card request: %d",_TapCount];
    
}



- (IBAction)cardTouch:(UIButton *)sender {
    
    sender.selected = !sender.isSelected;
    
    if(sender.selected)
    {
        card *card = [self.deck drawRandomCard];
        
        if(card){
            [sender setTitle:card.contents forState:UIControlStateSelected];
            
            [sender setImage:[UIImage imageNamed:card.imageName] forState:UIControlStateSelected];
            
            self.TapCount ++;
            
        }
    }
    
    
}




@end
