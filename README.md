# UnknownTerrainNavigation

This project is done as my Final Year Research Project and focuses on building a navigation system to explore and map unknown rough terrains. uses ROS and Octomap frameworks. Developed as a single packaage and contains 4 subsystems as follows,

    1. Goal Identifier
    2. Path Planner
    3. Ground Evaluator
    4. Velocity Controller
    
each component is implemented as a ros node and has additional nodes for visiualizing intermidiate results. all nodes as follows


    1. Goal Identifer node  - implements Goal Identifier subsystem. Identifes nearest unexplored node to create a path
    2. Goal Visualizer node - implements a system that interprets goal identifier node's result and intermediate values. Used for testing the Goal Identifier node
