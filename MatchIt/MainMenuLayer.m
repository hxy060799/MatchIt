//
//  MainMenuLayer.m
//  MatchIt
//
//  Created by Bill on 13-4-30.
//
//

#import "MainMenuLayer.h"
#import "GameLayer.h"
#import "AboutLayer.h"

@implementation MainMenuLayer

+(CCScene*)scene{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	MainMenuLayer *layer = [MainMenuLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id)init{
    if (self=[super init]) {
        CGSize winSize=[[CCDirector sharedDirector]winSize];
        
        CCMenuItemLabel *startLabel = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Start Game" fontName:@"Marker Felt" fontSize:40]
                                                            block:^(id sender) {
                                                                [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[GameLayer scene] withColor:ccWHITE]];

                                                            }];
        startLabel.position=ccp(winSize.width/2,winSize.height/2+40);
        
        CCMenuItemLabel *aboutLabel = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"About This App" fontName:@"Marker Felt" fontSize:40]
                                                               block:^(id sender) {
                                                                   [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[AboutLayer scene] withColor:ccWHITE]];
                                                                   
                                                               }];
        aboutLabel.position=ccp(winSize.width/2,winSize.height/2);
        
        CCMenu *menu = [CCMenu menuWithItems:startLabel,aboutLabel, nil];
        
        menu.anchorPoint=ccp(0,0);
        menu.position=ccp(0,0);
        
        [self addChild:menu];
    }
    return self;
}

@end
