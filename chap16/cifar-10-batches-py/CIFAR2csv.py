### the below code is not for R but for Python
# -*- coding: utf-8 -*-
# convert CIFAR-10 dataset into CSV
import numpy as np
import pickle as cPickle
import glob2 as glob

# define function
def unpickle(file):
  fo = open(file, "rb")
  dict = cPickle.load(fo)
  fo.close()
  return dict
  
# function to convert image into CSV
def write_csv_img(dict, path_out):
  label = dict["labels"]
  image = dict["data"]
  fout = open(path_out, "a")
  for lbl, img in zip(label, image):
    ary_out = np.append(lbl, img)
    fout.write(",".join(map(str, ary_out))+"\n")
  fout.close()
  
# function to convert label into CSV
def write_csv_labelname(dict, path_out):
  labelname = dict["label_names"]
  fout = open(path_out, "w")
  fout.write("\n".join(map(str, labelname)))
  fout.close()
  
# Read CIFAR-10 dataset and write CSV
if __name__ == "__main__":
    try:
    
# create list of training datasets
        files = glob.glob("./data_batch_*")
        # create CSV for training data
        for ftrain in files:
            write_csv_img(unpickle(ftrain), "./train.csv")
        # create CSV for test data
        write_csv_img(unpickle("./test_batch"), "./test.csv")
        # create CSV for label
        write_csv_labelname(unpickle("./batches.meta"), "./labelnames.csv")

    except:
        print("An error occurred during execution.")
