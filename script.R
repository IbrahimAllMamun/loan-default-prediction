library(vroom)
library(dplyr)
library(purrr)

# 1. Read the dataset
library(vroom)

coltypes <- c(
  id = "c",
  desc = "c",
  annual_inc_joint = "c",
  dti_joint = "c",
  verification_status_joint = "c",
  revol_bal_joint = "c",
  sec_app_fico_range_low = "c",
  sec_app_fico_range_high = "c",
  sec_app_earliest_cr_line = "c",
  sec_app_inq_last_6mths = "c",
  sec_app_open_acc = "c",
  sec_app_revol_util = "c",
  sec_app_open_act_il = "c",
  sec_app_num_rev_accts = "c",
  sec_app_collections_12_mths_ex_med = "c",
  sec_app_mths_since_last_major_derog = "c",
  sec_app_mort_acc = "c",
  sec_app_chargeoff_within_12_mths = "c",
  orig_projected_additional_accrued_interest = "c",
  debt_settlement_flag_date = "c",
  settlement_status = "c",
  settlement_date = "c",
  settlement_amount = "c",
  settlement_percentage = "c",
  settlement_term = "c",
  hardship_type = "c",
  hardship_reason = "c",
  hardship_status = "c",
  deferral_term = "c",
  hardship_amount = "c",
  hardship_start_date = "c",
  hardship_end_date = "c",
  payment_plan_start_date = "c",
  hardship_length = "c",
  hardship_loan_status = "c",
  hardship_payoff_balance_amount = "c",
  hardship_last_payment_amount = "c",
  hardship_dpd = "c",
  il_util = "c"
)

df01 <- vroom(
  "Data/Accepted/accepted_part_01.csv.gz",
  col_types = coltypes # "c" forces character type for column 20
)


for (i in 2:10){
  if (i!=10){
    df <- vroom(
      paste0("Data/Accepted/accepted_part_0",i,".csv.gz"),
      col_types = coltypes # "c" forces character type for column 20
    )
  } else {
    df <- vroom(
      paste0("Data/Accepted/accepted_part_",i,".csv.gz"),
      col_types = coltypes # "c" forces character type for column 20
    )
  }
  print(problems(df) %>% distinct(col))
  df01 <- bind_rows(df01,df)
}




colsd <- c()

df02 <- vroom(
  "Data/Rejected/rejected_part_01.csv.gz"
)


for (i in 2:10){
  if (i!=10){
    df <- vroom(
      paste0("Data/Rejected/rejected_part_0",i,".csv.gz")
    )
  } else {
    df <- vroom(
      paste0("Data/Rejected/rejected_part_",i,".csv.gz")
    )
  }
  colsd <- c(colsd, problems(df) %>% pull(col) %>% unique())
  df02 <- bind_rows(df02,df)
}

View(df02 %>% head())
