import pandas as pd

# create (method 1: list of list)
df_left = pd.DataFrame(
    [
        [1, 2, 3],
        [6, 7, 8],
        [1, 7, 9],
    ],
    columns=["A", "B", "C"],
)
#    A  B  C
# 0  1  2  3
# 1  6  7  8
# 2  1  7  9

# create (method 2: dict of colums)
df_right = pd.DataFrame({"D": [2, 3]}, index=[0, 2])
#    D
# 0  2
# 2  3

# merge left and right using index
df3 = pd.merge(df_left, df_right, how="left", left_index=True, right_index=True)
#    A  B  C    D
# 0  1  2  3  2.0
# 1  6  7  8  NaN
# 2  1  7  9  3.0

# create (method 3: list of rows)