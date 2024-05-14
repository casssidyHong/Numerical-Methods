import numpy as np
import matplotlib.pyplot as plt

# Define the function and range
x = np.linspace(-1, 1, 100)
cos_true = np.cos(x)

# Chebyshev coefficients for cos(x)
cheb_coeffs = [1, -0.5, 0, 0.0417]  # these are the exact coefficients

# Calculate the Chebyshev approximation
cheb_approx = cheb_coeffs[0] * np.ones_like(x) + \
              cheb_coeffs[1] * (2*x**2 - 1) + \
              cheb_coeffs[3] * (8*x**4 - 8*x**2 + 1)

# Power series approximation
power_approx = 1 - x**2 / 2 + x**4 / 24

# Calculate errors
cheb_error = np.abs(cos_true - cheb_approx)
power_error = np.abs(cos_true - power_approx)

# Plotting
plt.figure()
plt.plot(x, cheb_error, 'r-', label='Chebyshev Error')
plt.plot(x, power_error, 'b--', label='Power Series Error')
plt.legend()
plt.title('Error Comparison')
plt.xlabel('x')
plt.ylabel('Error')
plt.show()
