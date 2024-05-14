import numpy as np
import matplotlib.pyplot as plt
from scipy.interpolate import CubicSpline

# Define the piecewise function
def f(x):
    return (np.abs(x) <= 0.5) * (1 - 2 * np.abs(x))

# Define five evenly spaced points in the interval [-1, 1]
x = np.linspace(-1, 1, 5)
y = f(x)

# Set up the cubic spline interpolation with natural boundaries (second derivatives at the end are zero)
cs_clamped = CubicSpline(x, y, bc_type=('natural'))

# Define a finer mesh to evaluate
xx = np.linspace(-1, 1, 100)
yy_condition3 = cs_clamped(xx)

# Create a cubic spline with not-a-knot boundary condition (default)
cs_not_a_knot = CubicSpline(x, y)
yy_not_a_knot = cs_not_a_knot(xx)

# True function values
yy_true = f(xx)

# Plotting
plt.figure()
plt.plot(xx, yy_true, 'k', linewidth=2, label='True function')
plt.plot(xx, yy_condition3, 'b--', linewidth=2, label='Condition 3')
plt.plot(xx, yy_not_a_knot, 'r-.', linewidth=2, label='Condition 4')
plt.plot(x, y, 'mo', markerfacecolor='m', label='Data Points')
plt.yticks(np.arange(min(y), max(y) + 0.5, 0.5))
plt.legend(loc='best')
plt.title('Comparison of Spline Fits')
plt.xlabel('x')
plt.ylabel('f(x)')
plt.show()
