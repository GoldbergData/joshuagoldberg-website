import random
import statistics as stats
import numpy
import math
import matplotlib.pyplot as plt
import seaborn as sns
import pandas as pd

my_nums = pd.read_csv("my_sample.csv") #sample is uniform
my_nums = my_nums["x"].tolist()
