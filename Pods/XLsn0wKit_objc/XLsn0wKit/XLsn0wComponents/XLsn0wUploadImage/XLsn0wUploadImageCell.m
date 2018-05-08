
#import "XLsn0wUploadImageCell.h"
#import "XLsn0wDisplayImageCell.h"

@implementation XLsn0wUploadImageCell

- (void)dealloc {
    self.collectionViewFlowLayout = nil;
    self.collectionView = nil;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatCollectionView];
        [self.contentView addSubview:self.collectionView];
    }
    return self;
}

- (void)creatCollectionView {
    self.collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionViewFlowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.collectionViewFlowLayout.itemSize = CGSizeMake(100, 100);
    
    self.collectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.collectionViewFlowLayout];
    [self.collectionView registerClass:[XLsn0wDisplayImageCell class] forCellWithReuseIdentifier:@"DisplayImageCell"];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.collectionView.frame = self.contentView.bounds;
}

@end
