//
//  InvestCell.m
//  555
//
//  Created by otouzi on 16/3/11.
//  Copyright © 2016年 李浩宇. All rights reserved.
//
#import "InvestCell.h"
#import "Masonry.h"
#import "MyInvestModel.h"
#import "RepaymentPlanController.h"
#import "UIView+UIViewController.h"
#import "InvestmentAgreementController.h"
#import "UICommons.h"
@implementation InvestCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self custumContentView];
       self.selectionStyle = UITableViewCellSelectionStyleNone;
        //@property (nonatomic, strong)NSString *money;//投资金额
        //
        //@property (nonatomic, strong)NSString *invest_annual;//项目年化收益
        //
        //@property (nonatomic, strong)NSString *invest_state;//状态
        //
        //@property (nonatomic, strong)NSString *total_income;//项目应收收益
        //
        //@property (nonatomic, strong)NSString *investment_release_start_time;//计息日期
        //
        //@property (nonatomic, strong)NSString *investment_release_end_time;//计息结束日期
        
        

    }
    return self;
    
}
- (void)awakeFromNib {
    // Initialization code
}
- (void)setModel:(MyInvestModel *)model{
    _model = model;
    
    
    
    NSString *const Invest_Money = @"投资金额(元):";
    NSString *const Invest_Annual = @"预期年化收益:";
    NSString *const Total_Income = @"预计收益(元):";
    NSString *const Invest_State = @"状态:";
    NSString *const Investment_Release_Start_Time = @"计息日期:";
    NSString *const Investment_Release_End_Time = @"到期日期:";

    _nameLabel.text = [NSString stringWithFormat:@"项目名称：%@",_model.project_name];
    
   
    //_moneyLabel.text = [NSString stringWithFormat:@"投资金额：%@",_model.money];
    NSString *prompt = [NSString stringWithFormat:@"%@%@",Invest_Money,_model.money];
    NSMutableAttributedString *mulFullStr = [[NSMutableAttributedString alloc] initWithString:prompt];
    NSRange range = [[mulFullStr string] rangeOfString:_model.money];
    [mulFullStr addAttribute:NSForegroundColorAttributeName value:kColorMain range:range];
    
    _moneyLabel.attributedText = mulFullStr;
    

    
    NSString *investment_increase;
    //_invest_annualLabel.text = [NSString stringWithFormat:@"年化收益：%@%%",_model.invest_annual];
    double revenue=  [_model.project_annual  doubleValue];
    double increase =  [_model.investment_increase  doubleValue];
    investment_increase = [NSString stringWithFormat:@"%.1f%%+%.1f%%",revenue,increase];
    
    if ([_model.investment_increase  isEqualToString:@"0"]||[_model.investment_increase  isEqualToString:@"0.0"]||[_model.investment_increase  isEqualToString:@"0.00"]) {
        
      investment_increase = [NSString stringWithFormat:@"%.f%%",revenue];
    
    }

    NSString *annual = [NSString stringWithFormat:@"%@%@",Invest_Annual,investment_increase];
    NSMutableAttributedString *annualFullStr = [[NSMutableAttributedString alloc] initWithString:annual];
    NSRange rangeAnnual = [[annualFullStr string] rangeOfString:investment_increase];
    [annualFullStr addAttribute:NSForegroundColorAttributeName value:kColorMain range:rangeAnnual];

    _invest_annualLabel.attributedText = annualFullStr;

    
    
    
    
    
      //_total_incomeLabel.text =[NSString stringWithFormat:@"预计收益：%@",_model.total_income];
    NSString *income = [NSString stringWithFormat:@"%@%@",Total_Income,_model.total_income];
    NSMutableAttributedString *incomeFullStr = [[NSMutableAttributedString alloc] initWithString:income];
    NSRange incomeRange = [[incomeFullStr string] rangeOfString:_model.total_income];
    [incomeFullStr addAttribute:NSForegroundColorAttributeName value:kcolorFontGray range:incomeRange];
    
    _total_incomeLabel.attributedText = incomeFullStr;
    
    
//    if ([_invest_state_key intValue]==3) {
//        _planButton.hidden = YES;
//        _investmentAgreement.hidden = YES;
//        
//        
//    }else{
//        
//        if ([_isloanType intValue]==0) {
//            _planButton.hidden = YES;
//            _investmentAgreement.hidden = NO;
//        }else if ([_isloanType intValue]==1){
//            _planButton.hidden = NO;
//            _investmentAgreement.hidden = NO;
//        }
//        
//        
//        
//    }
    
    
    
    
    _isloanType = [NSString stringWithFormat:@"%@",_model.isloan];
    
    _invest_state_key = [NSString stringWithFormat:@"%@",_model.invest_state_key];
    

// _invest_stateLabel.text = [NSString stringWithFormat:@"投资状态：%@",_model.invest_state];
    if ([_invest_state_key intValue] ==1){
        NSString *state = [NSString stringWithFormat:@"%@%@",Invest_State,_model.invest_state];
        NSMutableAttributedString *stateFullStr = [[NSMutableAttributedString alloc] initWithString:state];
        NSRange stateRange = [[stateFullStr string] rangeOfString:_model.invest_state];
        [stateFullStr addAttribute:NSForegroundColorAttributeName value:kcolorFontGray range:stateRange];
        
        _invest_stateLabel.attributedText = stateFullStr;
        if ([_isloanType intValue]==0) {
            _planButton.hidden = YES;
            _investmentAgreement.hidden = NO;
        }else if ([_isloanType intValue]==1){
            _planButton.hidden = NO;
            _investmentAgreement.hidden = NO;
        }

    
    
    }
    
       else if ([_invest_state_key intValue] ==3) {
           
           _planButton.hidden = YES;
           _investmentAgreement.hidden = YES;
           
           NSString *state = [NSString stringWithFormat:@"%@%@",Invest_State,_model.invest_state];
           NSMutableAttributedString *stateFullStr = [[NSMutableAttributedString alloc] initWithString:state];
           NSRange stateRange = [[stateFullStr string] rangeOfString:_model.invest_state];
           [stateFullStr addAttribute:NSForegroundColorAttributeName value:kcolorFontGray range:stateRange];
           _invest_stateLabel.attributedText = stateFullStr;
  
          }else if ([_invest_state_key intValue]==4){
    
              if ([_isloanType intValue]==0) {
                  _planButton.hidden = YES;
                  _investmentAgreement.hidden = NO;
              }else if ([_isloanType intValue]==1){
                  _planButton.hidden = NO;
                  _investmentAgreement.hidden = NO;
              }

        NSString *state = [NSString stringWithFormat:@"%@%@",Invest_State,_model.invest_state];
        NSMutableAttributedString *stateFullStr = [[NSMutableAttributedString alloc] initWithString:state];
        NSRange stateRange = [[stateFullStr string] rangeOfString:_model.invest_state];
        [stateFullStr addAttribute:NSForegroundColorAttributeName value:kcolorGreen range:stateRange];
        
        _invest_stateLabel.attributedText = stateFullStr;

    
    
    }else if([_invest_state_key intValue]==2){
    
        if ([_isloanType intValue]==0) {
            _planButton.hidden = YES;
            _investmentAgreement.hidden = NO;
        }else if ([_isloanType intValue]==1){
            _planButton.hidden = NO;
            _investmentAgreement.hidden = NO;
        }

        NSString *state = [NSString stringWithFormat:@"%@%@",Invest_State,_model.invest_state];
        NSMutableAttributedString *stateFullStr = [[NSMutableAttributedString alloc] initWithString:state];
        NSRange stateRange = [[stateFullStr string] rangeOfString:_model.invest_state];
        [stateFullStr addAttribute:NSForegroundColorAttributeName value:kColorMain range:stateRange];
        
        _invest_stateLabel.attributedText = stateFullStr;

    
    }
    
    
    //_investment_release_start_timeLabel.text = [NSString stringWithFormat:@"计息日期：%@",_model.investment_release_start_time];
    
    NSString *start_time = [NSString stringWithFormat:@"%@%@",Investment_Release_Start_Time,_model.investment_release_start_time];
    NSMutableAttributedString *start_timeFullStr = [[NSMutableAttributedString alloc] initWithString:start_time];
    NSRange start_timeRange = [[start_timeFullStr string] rangeOfString:_model.investment_release_start_time];
    [start_timeFullStr addAttribute:NSForegroundColorAttributeName value:kcolorFontGray range:start_timeRange];
    
    _investment_release_start_timeLabel.attributedText = start_timeFullStr;
    
    

    
    
    
    //_investment_release_end_timeLabel.text = [NSString stringWithFormat:@"到期日期：%@",_model.investment_release_end_time];
    
    NSString *end_time = [NSString stringWithFormat:@"%@%@",Investment_Release_End_Time,_model.investment_release_end_time];
    NSMutableAttributedString *end_timeFullStr = [[NSMutableAttributedString alloc] initWithString:end_time];
    NSRange end_timeRange = [[end_timeFullStr string] rangeOfString:_model.investment_release_end_time];
    [end_timeFullStr addAttribute:NSForegroundColorAttributeName value:kcolorFontGray range:end_timeRange];
    
    _investment_release_end_timeLabel.attributedText = end_timeFullStr;
    

    
    _project_id = [NSString stringWithFormat:@"%@",_model.project_id];
    _investment_id = [NSString stringWithFormat:@"%@",_model.investment_id];
    
    _protocol_url = [NSString stringWithFormat:@"%@",_model.protocol_url];

    
    
    
}

#pragma mark - 自定义子视图
- (void)custumContentView{
    int padding;

    int rightPadding =0.031*kScreenWidth;
    int height = 0.019*kScreenHeight;
    //int fontHeight =  0.019*kScreenHeight;
    int fontHeight;
    if (kScreenWidth == 320) {
          padding = 0.031*kScreenWidth;
        fontHeight =36/3;
    }else{
      padding = 0.056*kScreenWidth;
       fontHeight =41/3;
    }
  
  
    
    
    UIView *topView =[UIView new];
    topView.backgroundColor =RGB(235, 235, 235, 1);
    
    [self.contentView addSubview:topView];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
        make.top.equalTo(self.contentView);
        make.height.mas_equalTo(0.018*kScreenHeight);
    }];
    
    
    
    //名称
    _nameLabel = [[UILabel alloc]init];
    _nameLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:48/3];
    [self.contentView addSubview:_nameLabel];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom).offset(0.029*kScreenHeight);
        make.left.equalTo(self.contentView).offset(0.056*kScreenWidth);
        make.right.equalTo(self.contentView).offset(-0.031*kScreenWidth);
        make.height.mas_equalTo(0.022*kScreenHeight);
        
    }];
    
    //线
    UILabel *lineGray = [UILabel new];
    lineGray.backgroundColor = kcolorGrayNew;
    [self.contentView addSubview:lineGray];
    [lineGray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel.mas_bottom).offset(0.029*kScreenHeight);
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
        make.height.mas_equalTo(@1);
        
        
    }];
    
    
    

    
    /*
     *投资金额
     */
    _moneyLabel = [[UILabel alloc]init];
    _moneyLabel.font = Font(fontHeight);
    [self.contentView addSubview:_moneyLabel];
    [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineGray.mas_bottom).offset(0.034*kScreenHeight);
        make.left.equalTo(self.contentView).offset(padding);
        make.right.equalTo(self.contentView.mas_centerX);
        make.height.mas_equalTo(0.019*kScreenHeight);
        
    }];
    
    
//    /*
//     *预计年化收益
//     */
//    
    _invest_annualLabel = [[UILabel alloc]init];
    _invest_annualLabel.font = Font(fontHeight);
    [self.contentView addSubview:_invest_annualLabel];
    [_invest_annualLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineGray.mas_bottom).offset(0.034*kScreenHeight);
        make.left.equalTo(self.contentView.mas_centerX).offset(padding);
        make.right.equalTo(self.contentView).offset(rightPadding);
        make.height.mas_equalTo(height);
        
        
    }];
    
    
    
    /*
     *预计收益
     */
    _total_incomeLabel =  [UILabel new];
    _total_incomeLabel.font = Font(fontHeight);
    [self.contentView addSubview:_total_incomeLabel];
    
    [_total_incomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(padding);
        make.top.equalTo(_moneyLabel.mas_bottom).offset(0.025*kScreenHeight);
        make.right.equalTo(self.contentView.mas_centerX);
        make.height.mas_equalTo(height);

        
    }] ;

    /*
     *还款状态
     */
    _invest_stateLabel =  [UILabel new];
    _invest_stateLabel.font = Font(fontHeight);
    [self.contentView addSubview:_invest_stateLabel];
    
    [_invest_stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_invest_annualLabel.mas_bottom).offset(0.025*kScreenHeight);
        make.left.equalTo(self.contentView.mas_centerX).offset(padding);
        make.right.equalTo(self.contentView).offset(rightPadding);
        make.height.mas_equalTo(height);
        
    }] ;
    
    /*
     *计息开始时间
     */
    _investment_release_start_timeLabel =  [UILabel new];
    _investment_release_start_timeLabel.font = Font(fontHeight);
    [self.contentView addSubview:_investment_release_start_timeLabel];
    
    [_investment_release_start_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_total_incomeLabel.mas_bottom).offset(0.025*kScreenHeight);
        make.left.equalTo(self.contentView).offset(padding);
        make.right.equalTo(self.contentView.mas_centerX);
        make.height.mas_equalTo(height);
        

        
        //
    }] ;

    /*
     *计息结束
     */
    _investment_release_end_timeLabel =  [UILabel new];
    _investment_release_end_timeLabel.font = Font(fontHeight);
    [self.contentView addSubview:_investment_release_end_timeLabel];
    
    [_investment_release_end_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_invest_stateLabel.mas_bottom).offset(0.025*kScreenHeight);
        make.left.equalTo(self.contentView.mas_centerX).offset(padding);
        make.right.equalTo(self.contentView).offset(rightPadding);
        make.height.mas_equalTo(height);
        
        //
    }] ;

    //线
    UILabel *lineRed = [UILabel new];
    lineRed .backgroundColor = kColorMain;
    [self.contentView addSubview:lineRed ];
    [lineRed  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_investment_release_start_timeLabel.mas_bottom).offset(0.028*kScreenHeight);
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
        make.height.mas_equalTo(@1);
        
        
    }];
    
    
    

    
    
     _planButton= [UIButton new];
    [_planButton setImage:[UIImage imageNamed:@"RepaymentPlan"] forState:UIControlStateNormal];
   // [planButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
   // [planButton setTitle:@"还款计划" forState:UIControlStateNormal];
    [_planButton  addTarget:self
                    action:@selector(planAction:)
          forControlEvents:UIControlEventTouchUpInside];
  //  planButton.layer.borderWidth = 1;
    
    [self.contentView addSubview:_planButton];
    [_planButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(padding);
        make.top.equalTo(lineRed.mas_bottom).offset(0.025*kScreenHeight);
        make.width.mas_equalTo(0.265*kScreenWidth);
        make.height.mas_equalTo(0.044*kScreenHeight);
        
        
    }];
    
    _investmentAgreement = [UIButton new];
    [_investmentAgreement setImage:[UIImage imageNamed:@"InvestmentAgreement@3x"] forState:UIControlStateNormal];
//    investmentAgreement.layer.borderWidth = 1;
//    [investmentAgreement setTitle:@"投资协议" forState:UIControlStateNormal];
    [_investmentAgreement  addTarget:self
                    action:@selector(investmentAgreement:)
          forControlEvents:UIControlEventTouchUpInside];
    
    [_investmentAgreement setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.contentView addSubview:_investmentAgreement];
    [_investmentAgreement mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView.mas_centerX).offset(padding);
//        make.top.equalTo(lineRed.mas_bottom).offset(0.014*kScreenHeight);
////        make.width.mas_equalTo(0.264*kScreenWidth);
////        make.height.mas_equalTo(0.024*kScreenHeight);
//        make.width.mas_equalTo(328/3);
//        make.height.mas_equalTo(97/3);

        make.top.equalTo(lineRed.mas_bottom).offset(0.025*kScreenHeight);
        make.width.mas_equalTo(0.265*kScreenWidth);
        make.height.mas_equalTo(0.044*kScreenHeight);
        
    }];
    
 
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - 还款计划
- (void)planAction:(UIButton *)sender{
    RepaymentPlanController *repayMentPlanVC = [[RepaymentPlanController alloc]init];
    repayMentPlanVC.project_id = _project_id;
    repayMentPlanVC.investment_id = _investment_id;
    repayMentPlanVC.hidesBottomBarWhenPushed = YES;
    [self.viewController.navigationController pushViewController:repayMentPlanVC animated:YES];
    
    
    

}
#pragma mark - 投资协议
- (void)investmentAgreement:(UIButton *)sender{
    InvestmentAgreementController *investmentAgreementVC = [[InvestmentAgreementController alloc]init];
    investmentAgreementVC.investUrl = _protocol_url;
    investmentAgreementVC.hidesBottomBarWhenPushed = YES;
    [self.viewController.navigationController pushViewController:investmentAgreementVC animated:YES];
    


}
@end
