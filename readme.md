### Tire Model Reference

For consistency of the script, the following version of the tire magic formula[1] is enforced to express lateral performance of a axle/tire during pure sideslip condition across various loadcases

$$
\begin{equation}
F_y = D sin [ C arctan{\{B\alpha}-E(B\alpha-arctan(B\alpha))\}]
\end{equation}
$$

$$
\begin{equation}
D = \mu F_z \\
\end{equation}
$$

$$
\begin{equation}
B = C_{F\alpha}/(CD)
\end{equation}
$$

$$
\begin{equation}
C_{F\alpha} = c_1(sin[2arctan\{F_z/c_2\}])
\end{equation}
$$

The above function of the equation is packed inside the funciton "magicBCED.m"

$$
F_y = magicBCDE(\mu, c_1, c_2, C, E, \alpha, F_z)
$$

### Solotuion for Yaw Moment

#### Bicycle Model

The equations of motion of the simple bicycle model for $v$ and $r$  now read

$$
\begin{equation}
\left\{\begin{matrix}
 m(\dot v + ur) = F_{y1} + F_{y2}\\\\
I \dot r = a F_{y1} + bF_{y2}
\end{matrix}\right.
\end{equation}
$$

In above equations: $v$ denoting the lateral velocity of the center of gravity; $r$ denoting the yawrate; $F_{y1}$ and $F_{y2}$ denoting the front and rear lateral forces; $a$ and $b$ representing the front and rear portion of the wheelbase; with $m$ and $I$ representing obviously the mass and inertia around z-axis of the vehicle.

$F_{y1}$ and $F_{y2}$ are the functions of side slip angles, and

$$
\begin{equation}
\left\{\begin{matrix}
F_{y1} = F_{y1}(\alpha_1)\\\\
F_{y2} = F_{y2}(\alpha_2)
\end{matrix}\right.
\end{equation}
$$

as mentioned in our case $Fy = magicBCDE(\alpha,...()))$. Whereas $\alpha_1$ and $\alpha_2$ are expressed by

$$
\begin{equation}
\left\{\begin{matrix}
\alpha_1 = \delta - \frac{1}{u}(v+ar)\\
\\
\alpha_2 = - \frac{1}{u}(v-br)
\end{matrix}\right.
\end{equation}
$$

as a matter of fact, the sideslip angle $\beta$ is defined as

$$
\beta = v/u
$$

then the equations above can be expressed

$$
\begin{equation}
\left\{\begin{matrix}
\alpha_1 = \delta - \beta + l_a * a_y/V_x^2)\\
\\
\alpha_2 = - \frac{1}{u}(v-br)
\end{matrix}\right.
\end{equation}
$$

#### Lateral Acc. and Yaw Moment
