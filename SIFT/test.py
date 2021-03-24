
import os,sys
import matlab.engine
# sys.path.append('D:/experiment/feature_func/sift/')
eng = matlab.engine.start_matlab()

eng.sift_main(nargout=0)

