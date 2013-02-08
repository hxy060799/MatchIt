//
//  MIMap.m
//  MatchIt
//
//  Created by Bill on 13-2-3.
//
//

#import "MIMap.h"

@interface MIMap ()
-(NSMutableDictionary*)readPlistWithPlistName:(NSString*)plistName;
@end

@implementation MIMap

@synthesize map;
@synthesize blockInformation;

-(id)init{
    if(self=[super init]){
        NSMutableArray *mapArray=[[self readPlistWithPlistName:@"MatchItMap"]objectForKey:@"MatchItMap"];
        self.map=[[NSMutableArray alloc]initWithArray:mapArray];
        
        NSMutableArray *infArray=[[self readPlistWithPlistName:@"BlockInformation"]objectForKey:@"BlockInformation"];
        self.blockInformation=[[NSMutableArray alloc]initWithArray:infArray];
    }
    return self;
}

-(void)dealloc{
    [map release];
    [super dealloc];
}

-(int)blockAtX:(int)x Y:(int)y{
    return [[[[map objectAtIndex:8]objectAtIndex:y]objectAtIndex:x]intValue];
}

-(NSString*)imageNameWithImgId:(int)imgId{
    return [[blockInformation objectAtIndex:imgId]objectForKey:@"ImageName"];
}

-(NSString*)imageNameAtX:(int)x Y:(int)y{
    int imgId=[self blockAtX:x Y:y];
    return [self imageNameWithImgId:imgId];
}

-(NSMutableDictionary*)readPlistWithPlistName:(NSString*)plistName{
    NSString *error=nil;
    NSPropertyListFormat format;
    NSMutableDictionary *dict=nil;
    NSString *filePath=[[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
    NSData *plistXML=[[NSFileManager defaultManager]contentsAtPath:filePath];
    dict=(NSMutableDictionary*)[NSPropertyListSerialization propertyListFromData:plistXML mutabilityOption:NSPropertyListMutableContainersAndLeaves format:&format errorDescription:&error];
    return dict;
}
@end
