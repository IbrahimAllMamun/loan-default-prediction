library(vroom)
library(dplyr)
library(purrr)

# 1. Read the dataset
df <- vroom("accepted_2007_to_2018Q4.csv.gz")

# 2. Add a group column splitting rows into 10 equal parts
n_chunks <- 10
df_split <- df %>%
  mutate(chunk_id = ntile(row_number(), n_chunks)) %>%
  group_split(chunk_id, .keep = FALSE)

# 3. Write each data frame to its own .csv.gz file
iwalk(df_split, function(sub_df, index) {
  filename <- sprintf("accepted_part_%02d.csv.gz", index)
  vroom_write(sub_df, file = filename, delim = ",")
  message(sprintf("Saved: %s (%d rows)", filename, nrow(sub_df)))
})



# 1. Read the dataset
df <- vroom("rejected_2007_to_2018Q4.csv.gz")

# 2. Add a group column splitting rows into 10 equal parts
n_chunks <- 10
df_split <- df %>%
  mutate(chunk_id = ntile(row_number(), n_chunks)) %>%
  group_split(chunk_id, .keep = FALSE)

# 3. Write each data frame to its own .csv.gz file
iwalk(df_split, function(sub_df, index) {
  filename <- sprintf("rejected_part_%02d.csv.gz", index)
  vroom_write(sub_df, file = filename, delim = ",")
  message(sprintf("Saved: %s (%d rows)", filename, nrow(sub_df)))
})