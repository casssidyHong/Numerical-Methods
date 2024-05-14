import numpy as np
from scipy.interpolate import RectBivariateSpline
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

# Define the grid points and their corresponding z-values
x_values = np.array([1.3, 2.5, 3.1, 4.7, 5.5])
y_values = np.array([0.2, 0.4, 0.5, 0.7, 0.9])
z_values = np.array([
    [2.521, 3.721, 4.321, 5.921, 6.721],
    [2.792, 3.992, 4.592, 6.192, 6.992],
    [2.949, 4.149, 4.749, 6.349, 7.149],
    [3.314, 4.514, 5.114, 6.714, 7.514],
    [3.760, 4.960, 5.560, 7.160, 7.960]
])

# Create a Bivariate Spline interpolator
spline = RectBivariateSpline(x_values, y_values, z_values)

# Evaluate the spline at the specific point (2.8, 0.54)
z_estimated = spline.ev(2.8, 0.54)

print(f'The estimated value of z(2.8, 0.54) is {z_estimated:.4f}')

# Prepare meshgrid for plotting
x_plot = np.linspace(min(x_values), max(x_values), 100)
y_plot = np.linspace(min(y_values), max(y_values), 100)
x_mesh, y_mesh = np.meshgrid(x_plot, y_plot)

# Evaluate the spline over the grid
z_mesh = spline(x_plot, y_plot)

# Plotting
fig = plt.figure(figsize=(10, 7))
ax = fig.add_subplot(111, projection='3d')
surf = ax.plot_surface(x_mesh, y_mesh, z_mesh, rstride=1, cstride=1, cmap='viridis', edgecolor='none')
ax.set_title('B-Spline Surface')
ax.set_xlabel('X axis')
ax.set_ylabel('Y axis')
ax.set_zlabel('Z axis')
fig.colorbar(surf, ax=ax, shrink=0.5, aspect=5)  # Add a color bar which maps values to colors.
plt.show()
