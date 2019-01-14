package model

import (
	"fmt"
	"math/rand"
	"testing"
)

func TestGetRandom_A(t *testing.T) {
	src := rand.NewSource(0)
	t.Log(getRandomN(1, 10, 1, rand.New(src)))
	t.Log(getRandomN(1, 10, 1, rand.New(src)))
	t.Log(getRandomN(1, 10, 2, rand.New(src)))
}

func TestExecuteModelA(t *testing.T) {
	var (
		avg          float32
		nExperiments = 10000
		results      = make([]*ExperimentResult, nExperiments)

		totalNodes   = 10
		tasks        = 100
		badNodes     = 3
		taskPoolSize = 33
	)
	for i := 0; i < nExperiments; i++ {
		results[i] = ExecuteModelA(totalNodes, tasks, badNodes, taskPoolSize)
		avg += float32(results[i].ViolatedCounter)
	}
	avg = avg / float32(nExperiments)
	fmt.Printf("(%d) V=%d N=%d/%d AvgFailedV = %f (%.2f%%)\n", nExperiments, tasks, totalNodes, badNodes, avg, avg/float32(tasks)*100.00)
}

func TestExecuteModelB(t *testing.T) {
	var (
		avg          float32
		nExperiments = 10000
		results      = make([]*ExperimentResult, nExperiments)

		totalNodes   = 10
		tasks        = 100
		badNodes     = 3
		taskPoolSize = 33
	)
	for i := 0; i < nExperiments; i++ {
		results[i] = ExecuteModelB(totalNodes, tasks, badNodes, taskPoolSize)
		avg += float32(results[i].ViolatedCounter)
	}
	avg = avg / float32(nExperiments)
	fmt.Printf("(%d) V=%d N=%d/%d AvgFailedV = %f (%.2f%%)\n", nExperiments, tasks, totalNodes, badNodes, avg, avg/float32(tasks)*100.00)
}
