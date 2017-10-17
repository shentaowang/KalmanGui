from filterpy.kalman import UnscentedKalmanFilter as UKF 
from filterpy.kalman import MerweScaledSigmaPoints
import numpy as np 

observe_file = 'data02_observe.txt';
true_file = 'data02_true.txt'

fp = open(observe_file,'r')
observe_data = []
for line in fp.readlines():
	line_data = line.split('\t')
	line_data = line_data[0:len(line_data)-1]
	line_data = [float(i) for i in line_data]
	observe_data.append(line_data)
observe_data = np.array(observe_data)
print('the observe data shape is:')
print(observe_data.shape)

fp = open(true_file,'r')
true_data = []
for line in fp.readlines():
	line_data = line.split('\t')
	line_data = line_data[0:len(line_data)-1]
	line_data = [float(i) for i in line_data]
	true_data.append(line_data)
true_data = np.array(true_data)
print('the ture data shape is:')
print(true_data.shape)

sigmas = MerweScaledSigmaPoints(4, alpha=0.01, beta=2., kappa=0)

def trans_f(x,dt):
	F = np.array([[1, 0, dt,  0],
				[0,  1, 0,  dt],
				[0,  0, 1, 0],
				[0,  0, 0,  1]])
	return np.dot(F, x)

def trans_h(x):
	z1 = np.sqrt(x[0]*x[0]+x[1]*x[1])
	z2 = np.arctan(x[1]/x[0])
	z3 = (x[0]*x[2]+x[1]*x[3])/(x[0]*x[0]+x[1]*x[1])
	return(np.array([z1,z2,z3]))

sigmas = MerweScaledSigmaPoints(4, alpha=0.01, beta=2., kappa=0)
ukf = UKF(dim_x=4, dim_z=3, fx=trans_f,
          hx=trans_h, dt=0.106, points=sigmas)
ukf.x = np.array([8.46642, 0, 0, 0])
ukf.P = np.eye(4,4)
ukf.R = np.diag([0.09,0.009, 0.09]) 
ukf.Q = np.diag([0, 0, 0.09, 0.09])

filtered_data = []
for z in observe_data:
	ukf.predict()
	ukf.update(z)
	filtered_data.append(ukf.x.copy())
filtered_data = np.array( filtered_data)

print('the filtered data shape is:')
print( filtered_data.shape)

data_gap = filtered_data - true_data

MSE_X_0 = np.dot(data_gap[:,0].T,data_gap[:,0])/data_gap.shape[0]
print("MSE between filtered an true dim:%d is:%f")%(0,MSE_X_0)