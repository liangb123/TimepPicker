//
//  SEEDPickerHMManager.h
//  driver
//
//  Created by liangbing on 2019/7/29.
//  Copyright © 2019 LB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SEEDDatePickerBaseManager.h"

NS_ASSUME_NONNULL_BEGIN

/** hh-mm  */
@interface SEEDPickerHMManager : SEEDDatePickerBaseManager<SEEDPickerManagerBasicDelegate>

/** 便利构造器*/
- (NSMutableArray <SEEDPickerSectionItem *>*)creatDateArrayWithIszh:(BOOL)isZh
                                                 withminuteInterval:(NSInteger)minuteInterval
                                                        withMinDate:(NSDate*)mindate;

@end

NS_ASSUME_NONNULL_END
