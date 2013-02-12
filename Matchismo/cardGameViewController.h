//
//  cardGameViewController.h
//  Matchismo
//
//  Created by Laurent GAIDON on 28/01/13.
//  Copyright (c) 2013 Laurent GAIDON. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface cardGameViewController : UIViewController

//it's just public to override
//should be a bad thing :-(
-(NSAttributedString *)flipTranslationFromDictionnary:(NSDictionary *)flipDictionnary;
-(void)updateCards;





@end
