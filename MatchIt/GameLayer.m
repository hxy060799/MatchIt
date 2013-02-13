//
//  HelloWorldLayer.m
//  MatchIt
//
//  Created by Bill on 13-1-29.
//  Copyright __MyCompanyName__ 2013年. All rights reserved.
//

#import "GameLayer.h"

#import "MIBlockManager.h"

@implementation GameLayer

CCLabelTTF *welcomeLabel;

+(CCScene*)scene{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameLayer *layer = [GameLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id)init{
    if(self=[super init]){
        CCLOG(@"你知道吗,这个应用是哥哥用心为你去做的.");
        //2012.12.09
        CCLOG(@"开始做连连看了哦!要加油啊!");
        CCLOG(@"不要去害怕苦难哦!你最棒了!");
        //2012.12.30
        CCLOG(@"很好,你已经可以实现MIBlock的Sprite加载功能了.");
        CCLOG(@"非常好,这次你看到的方块已经是由BlockManager创建的了.");
        CCLOG(@"很棒,你已经为整个游戏的二维地图打下了基础,你已经可以把MIBlock建立在数组里面了.");
        //2012.12.31
        CCLOG(@"非常棒!其实创建一个二维网格非常简单,这不是已经完成了吗?");
        CCLOG(@"很好,你可以自定义方块图像了.");
        CCLOG(@"很不错!这个坐标到索引转换的算法没有问题.");
        CCLOG(@"很好,你能够自定义方块组大小，并且将它放置到屏幕中间了.");
        CCLOG(@"到此为止,方块基础部分已经全部完成了,是不是很简单呢?");
        //2013.01.05
        CCLOG(@"今天很成功地把屏幕坐标->方块坐标的算法写好了,接下来要继续努力哦!");
        CCLOG(@"今天弄得真是累,没想到简单的方块选择居然那么难弄,不过也为后面的东西打下基础.妹妹为我加油了,我也要为自己加油哦!");
        CCLOG(@"我觉得用数组存储选中的方块不是最简便的,要寻找另外一种数据存储方式.");
        //2013.01.12
        CCLOG(@"好吧,这回修正了一个Bug,这Bug纯粹是粗心大意导致的,花了那么多时间...");
        CCLOG(@"非常棒,一共四种方案,前两种已经完成了,离成功已经不远了!");
        //2013.01.13
        CCLOG(@"加油啊!就差一种情况了!");
        CCLOG(@"很棒,已经把之前的大漏洞修复好了,接下来要更加努力哦!");
        //2013.01.29
        CCLOG(@"很好,经提早把基础算法部分弄好了,可以开始做坐标转换了.");
        //2013.01.31
        CCLOG(@"昨天做了一个尝试,今天已经找到相对较好的方法了.今天返校,起床太早,犯困想睡觉了.明天继续!");
        //2013.02.01
        CCLOG(@"之前的一个错误用法造成了后面那么大的祸害...");
        //2013.02.03
        CCLOG(@"明天继续,效果很明显,但是今天实在是太累了.");
        //2013.02.04
        CCLOG(@"做了一个半钟头,也总算把第三种情况完成了.");
        
        CGSize winSize=[[CCDirector sharedDirector]winSize];
        NSLog(@"%f:%f",winSize.width,winSize.height);
        
        CCLabelTTF *helloWorldLabel=[CCLabelTTF labelWithString:@"妹妹,我会努力的!" fontName:@"Marker Felt" fontSize:32];
        //CCLabelTTF *helloWorldLabel=[CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:32];
        helloWorldLabel.position=ccp(winSize.width/2,winSize.height/2);
        [self addChild:helloWorldLabel z:1];
        
        welcomeLabel=[CCLabelTTF labelWithString:@"请点击方块" fontName:@"Marker Felt" fontSize:20];
        welcomeLabel.position=ccp(winSize.width/2,winSize.height/2-48);
        [self addChild:welcomeLabel z:1];
        
        MIBlockManager *blockManager=[MIBlockManager blockManager];
        
        blockManager.delegate=self;
        
        [self addChild:(CCLayer*)blockManager z:0];
    }
    return self;
}
-(void)traceWithString:(NSString *)string{
    [welcomeLabel setString:string];
}

@end
