# BFT task distribution model
Simulation model for task pool size calculation.

## Description
This model allows to perform experiments of task distribution process in 
bft environment. Model has 3 parameters:
- number of nodes `-n`
- number of tasks `-v`
- precision (number of experiments) `-e`

Model produces size of node's task pool for chosen precision.

Detailed information about task distribution problem can be found on 
[medium article](https://medium.com/@neospcc/task-distribution-over-consensus-nodes-42f1349442ad).


## Usage
You can run model inside a docker container or run app manually with 
`go run`. Don't forget to turn on gomodules in that case!

```
$ make up
Sending build context to Docker daemon  114.7kB
. . .
/ #
/ # bft-task-distrib-model -n 10 -v 100 -e 1000
#  BFT TASK DISTRIBUTION MODEL v.1.0
#  N = 10 V = 100
#  EXP = 1000
#  AVAILABLE WORKERS = 8
#  STARTING AT: 2019-01-14T09:49:00Z
3:67 (1.000) 1(1)
6:50 (0.980) 2(2)
9:45 (1.000) 1(1)
#  ENDED AT: 2019-01-14T09:49:00Z
#  DURATION: 40.430027ms
```

Output string `3:67 (1.000) 1(1)` means, that for `3` nodes, pool 
size must be `67` tasks.

Relation between max pool size and obtained pool size is 
`1.000` - so they equal. 

Last column is a number of tries to reduce pool size.

There is also gnuplot file with example from [medium article](https://medium.com/@neospcc/task-distribution-over-consensus-nodes-42f1349442ad):
```
$ gnuplot
Terminal type is now 'qt'
gnuplot> load 'results.gp'
``` 

## License
This project is licensed under the GPLv3 License - 
see the [LICENSE.md](LICENSE.md) file for details
