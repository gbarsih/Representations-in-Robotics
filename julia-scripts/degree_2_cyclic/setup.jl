# Choose number of agents
num_agents = 7

# Define the world polygon (counter-clockwise)
polyOutersp = [
             0.0 0.0;
             3.0 0.0;
             3.5 1.2;
             3.5 2.0;
             1.5 3.0;
            -0.5 2.0;
            -0.5 1.2;
            ]'

# Define the obstacle (clockwise)
polyInnersp = [
              0.7 1.0;
              0.8 1.5;
              1.5 2.0;
              2.2 1.5;
              2.3 1.0;
            ]'

polyOuterep = circshift(polyOutersp, (0, -1))
polyInnerep = circshift(polyInnersp, (0, -1))
polysp = [polyOutersp polyInnersp]
polyep = [polyOuterep polyInnerep]

# Define the virtual gates
sp = [
     -0.5  1.5;
      1.5  3.0;
      2.2  1.5;
      2.3  1.0;
      1.2  1.0;
     ]'

ep = [
      0.8  1.5;
      1.5  2.0;
      3.5  2.0;
      3.0  0.0;
      1.2  0.0;
     ]'
clr = [
        :blue,
        :red,
        :green,
        :red,
        :green,
      ]

# Define initialization region
init_center = [0.2, 0.7]
init_width = 0.8
