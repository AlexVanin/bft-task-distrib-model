package main

import (
	"flag"
	"fmt"
	"os"
	"runtime"
	"strconv"
	"sync"
	"time"
	. "bft-task-distrib-model/model"
)

type (
	result struct {
		mu     *sync.Mutex
		unused int
	}
)

func newResult() *result {
	return &result{
		mu:     new(sync.Mutex),
		unused: 0,
	}
}

func calcPool(n, v int) int {
	return (((n/3 + 1) * v) / n) + 1
}

func calcBad(n int) int {
	return n / 3
}

func worker(job chan struct{}, group *sync.WaitGroup, r *result, N, V, B, S int) {
	defer func() {
		group.Done()
	}()
	for range job {
		res := ExecuteModelB(N, V, B, S)
		r.mu.Lock()
		r.unused += res.ViolatedCounter
		r.mu.Unlock()
	}
}

func ParallelExperiment(N, V, B, experiments, step int) int {
	var (
		workerCount = runtime.NumCPU() //+ runtime.NumCPU()/2
		wg          = new(sync.WaitGroup)
		r           = newResult()
	)
	wg.Add(workerCount)

	jobs := make(chan struct{}, experiments)
	for i := 0; i < experiments; i++ {
		jobs <- struct{}{}
	}

	for i := 0; i < workerCount; i++ {
		go worker(jobs, wg, r, N, V, B, step)
	}
	close(jobs)
	wg.Wait()
	return r.unused
}

func main() {
	var (
		Nodes       *int
		Experiments *int
		Tasks       *int

		n       int
		total   int
		rate    float64
		st      time.Time
		version = "1.0"
	)

	Tasks = flag.Int("v", 1000, "number of tasks to split")
	Experiments = flag.Int("e", 100000, "number of tasks to split")
	Nodes = flag.Int("n", 100, "maximum number of nodes")
	flag.Parse()
	st = time.Now()

	if *Nodes < 3 {
		fmt.Println("error: number of nodes must be greater than 3")
		os.Exit(1)
	}
	if *Tasks < *Nodes {
		fmt.Println("error: number of tasks must be greater than number of nodes")
		os.Exit(1)
	}
	if *Experiments < 1 {
		fmt.Println("error: number of experiments must be positive number")
		os.Exit(1)
	}

	fmt.Println("#  BFT TASK DISTRIBUTION MODEL v." + version)
	fmt.Println("#  N = " + strconv.Itoa(*Nodes) + " V = " + strconv.Itoa(*Tasks))
	fmt.Println("#  EXP = " + strconv.Itoa(*Experiments))
	fmt.Println("#  AVAILABLE WORKERS = " + strconv.Itoa(runtime.NumCPU()))
	fmt.Println("#  STARTING AT: " + st.Format(time.RFC3339))

	for N := 3; N <= *Nodes; N += 3 { // step 3 because for every 3 query there will be spike
		badNodes := calcBad(N)
		maxStep := calcPool(N, *Tasks)
		n = (n / 3) * 2
		//n = n / 2
		startn := n
		enoughStep := maxStep - n
		for step := enoughStep; step > 0; step -= 1 {
			total = ParallelExperiment(N, *Tasks, badNodes, *Experiments, step)
			if total == 0 {
				enoughStep = step
				n++
			} else {
				rate = float64(enoughStep) / float64(maxStep)
				fmt.Printf("%d:%d (%.3f) %d(%d)\n", N, enoughStep, rate, n, n-startn)
				break
			}
		}
	}
	fmt.Println("#  ENDED AT: " + time.Now().Format(time.RFC3339))
	fmt.Println("#  DURATION: " + time.Since(st).String())
}
