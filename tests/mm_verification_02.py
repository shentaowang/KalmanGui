import numpy as np
from filterpy.kalman import KalmanFilter
from filterpy.common import Q_discrete_white_noise 

file_observe = 'mm_observe_01.txt'
file_true = 'mm_true_01.txt'

f = open(file_observe,'r')

observe_data = []
for line in f.readlines():
	line_observe_data = [float(i) for i in line.split('\t')]
	observe_data.append(line_observe_data)
observe_data  = np.array(observe_data)
print(observe_data.shape)

f = open(file_true,'r')
true_data = []
for line in f.readlines():
	line_observe_data = [float(i) for i in line.split('\t')]
	true_data.append(line_observe_data)
true_data = np.array(true_data)
print(true_data.shape)

def pos_vel_filter(x, P, R, Q=0., dt=1.0):
    """ Returns a KalmanFilter which implements a
    constant velocity model for a state [x dx].T
    """
    
    kf = KalmanFilter(dim_x=2, dim_z=1)
    kf.x = np.array([x[0], x[1]]) # location and velocity
    kf.F = np.array([[1., dt],
                     [0.,  1.]])  # state transition matrix
    kf.H = np.array([[1., 0]])    # Measurement function
    kf.R *= R                     # measurement uncertainty
    if np.isscalar(P):
        kf.P *= P                 # covariance matrix 
    else:
        kf.P[:] = P               # [:] makes deep copy
    if np.isscalar(Q):
        kf.Q = Q_discrete_white_noise(dim=2, dt=dt, var=Q)
    else:
        kf.Q[:] = Q
    return kf

def run(x0=(0.,0.), P=500, R=0, Q=0, dt=1.0, 
        track=None, zs=None,
        count=0, do_plot=True, **kwargs):
    """
    track is the actual position of the dog, zs are the 
    corresponding measurements. 
    """

    # Simulate dog if no observe_data provided. 
    if zs is None:
        track, zs = compute_dog_observe_data(R, Q, count)

    # create the Kalman filter
    kf = pos_vel_filter(x0, R=R, P=P, Q=Q, dt=dt)  

    # run the kalman filter and store the results
    xs, cov = [], []
    for z in zs:
        kf.predict()
        kf.update(z)
        xs.append(kf.x)
        cov.append(kf.P)

    xs, cov = np.array(xs), np.array(cov)
    # if do_plot:
    #     plot_track(xs[:, 0], track, zs, cov, 
    #                dt=dt, **kwargs)
    return xs, cov

P = np.diag([500., 49.])
Ms, Ps = run(count=50, R=10, Q=0.01, P=P, zs=observe_data)

print(Ms.shape)

data_gap = Ms - true_data

MSE = np.dot(data_gap[:,0],data_gap[:,0].T)/data_gap.shape[0]
print("MSE between filtered and true is:%f")%(MSE)

data_gap = Ms - observe_data
print(data_gap.shape)
MSE = np.dot(data_gap[:,0],data_gap[:,0].T)/data_gap.shape[0]
print("MSE between filtered and observe is:%f")%(MSE)

