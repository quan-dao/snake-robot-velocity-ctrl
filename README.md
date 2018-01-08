# snake-robot-velocity-ctrl

This is my program conducting the simmulation of the Lateral Undulation gait of snake-like robots having no passive wheels. I constructed this programm based on the mathematics model established in [1] and [2] to reproduce their results of controlling snake-like robots crawling direction and velocity.
<p>
  In my simmulation, the set point of robot heading direction and velocity are respectively <img src="https://latex.codecogs.com/gif.latex?-&space;\pi&space;/4"> (rad), 0.05 (m/s).
</p>

The simmulation result is displayed in Fig.1 and Fig.2. Fig.1 show that after a short period of transient robot heading angle was stabilized in a neighborhood of its set point. On the other hand, robot crawling velocity (the blue line in Fig.2) also exhibited transient and steady-state behavior, but the value around which robot crawling velocity oscillated was below the velocity set point (the red line).
<p align="center">
  <img src="https://i.imgur.com/CfXRKks.png">
</p>
<p align="center">
  <em> Fig.1 Robot heading direction <em>
</p>
<p align="center">
  <img src="https://i.imgur.com/xiTZsG6.png">
</p>
<p align="center">
  <em> Fig.2 Robot crawling velocity <em>
</p>

## Reference
[1] Mohammadi, E. Rezapour, M. Maggiore, and K. Y.Pettersen, ”Direction Following Control of Planar Snake Robots Using Virtual Holonomic Constraints”, in Proc. 53rd IEEE Conf. on Decision and Control (CDC 2014), Los Angeles, CA, Dec. 15 – 17, 2014.

[2] Mohammadi, Alireza, Ehsan Rezapour, Manfredi Maggiore, and Kristin Y. Pettersen. "Maneuvering control of planar snake robots using virtual holonomic constraints." IEEE Transactions on Control Systems Technology 24, no. 3 (2016): 884-899.

#### Note
* To activate the simulation, run the Numerical_Sim_1.m or Numerical_Sim_2.m
