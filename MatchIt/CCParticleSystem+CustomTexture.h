//
//  CCParticleSystem+CustomTexture.h
//  MatchIt
//
//  Created by Bill on 13-2-16.
//
//

#import "CCParticleSystem.h"
#import "CCFileUtils.h"

@interface CCParticleSystem (CCParticleSystem_CustomTexture)

-(id)initWithFile:(NSString *)plistFile CustomTextureFile:(NSString*)imageName;


+(id)particleWithFile:(NSString*)plistFile CustomTextureFile:(NSString*)imageName;


@end
