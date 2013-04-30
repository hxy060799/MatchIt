//
//  AboutLayer.m
//  MatchIt
//
//  Created by Bill on 13-4-30.
//
//

#import "AboutLayer.h"

@implementation AboutLayer

+(CCScene*)scene{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	AboutLayer *layer = [AboutLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id)init{
    if (self=[super init]) {
        CGSize winSize=[[CCDirector sharedDirector]winSize];
        
        CCLabelTTF *label=[CCLabelTTF labelWithString:@"关于\nMatch It－iPhone版连连看Demo\n为妹妹做的App\n去年的11月,妹妹看到了我的音乐播放器\n于是问我是否能开发出一款iPhone游戏\n我懵懵懂懂地说应该可以\n于是便决定做连连看\n接近一个月的准备:打草稿,写计划,做算法...\n2012.12.9我在xCode建立下了这个项目\n由于学业繁忙,项目进展缓慢\n一直过了五个月,才基本完成一个Demo\n便是现在看到的这个" fontName:@"Marker Felt" fontSize:20];
        
        label.position=ccp(winSize.width/2,winSize.height/2);
        
        [self addChild:label];
    }
    return self;
}

@end
