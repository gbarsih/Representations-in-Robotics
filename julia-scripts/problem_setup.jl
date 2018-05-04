# Choose number of agents
num_agents = 5

# Define the world polygon (counter-clockwise)
poly = [
        0.0 0.0;
        0.5 0.0;
        0.8 1.5;
        1.5 2.0;
        2.2 1.5;
        2.5 0.0;
        3.0 0.0;
        3.5 1.2;
        3.5 2.0;
        1.5 3.0;
       -0.5 2.0;
       -0.5 1.2;
       ]'

# Define the virtual gates
sp = [
     -0.5  1.5;
      1.5  3.0;
      2.2  1.5;
     ]'

ep = [
      0.8  1.5;
      1.5  2.0;
      3.5  1.5;
     ]'
clr = [
        :blue,
        :red,
        :blue,
      ]

# Define initialization region
init_center = [0.2, 0.7]
init_width = 0.8
