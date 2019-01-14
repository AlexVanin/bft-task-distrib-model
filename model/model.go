package model

import (
	"math/rand"
	"time"
)

type (
	Node struct {
		IR []int
	}
	ExperimentResult struct {
		ViolatedCounter int
	}
)

func getRandomN(n, max, seed int, r *rand.Rand) []int {
	r.Seed(time.Now().UnixNano() + int64(seed))

	if n > max/2 {
		return r.Perm(max)[:n]

	} else {
		result := make([]int, 0, n)
		re := make(map[int]struct{}, max)

		for len(result) < n {
			num := r.Intn(max)
			if _, ok := re[num]; !ok {
				result = append(result, num)
				re[num] = struct{}{}
			}
		}
		return result
	}
}

func ExecuteModelA(ircount, containers, badcount, choose int) *ExperimentResult {
	var (
		nodes   = make([]Node, containers)
		badring = make(map[int]struct{})
		result  = new(ExperimentResult)
	)

	r := rand.New(rand.NewSource(time.Now().UnixNano()))
	for len(badring) < badcount {
		n := r.Intn(ircount)
		if _, ok := badring[n]; !ok {
			badring[n] = struct{}{}
		}
	}

	for i := 0; i < ircount; i++ {
		if _, ok := badring[i]; ok {
			continue
		}
		rands := getRandomN(choose, containers, i+1, r)
		for _, host := range rands {
			nodes[host].IR = append(nodes[host].IR, i)
		}
	}

	for _, node := range nodes {
		if len(node.IR) == 0 {
			result.ViolatedCounter++
		}
	}

	return result
}

func ExecuteModelB(ircount, containers, badcount, choose int) *ExperimentResult {
	var (
		nodes   = make([]Node, containers)
		badring = make(map[int]struct{})
		result  = new(ExperimentResult)
	)
	r := rand.New(rand.NewSource(time.Now().UnixNano()))

	for len(badring) < badcount {
		n := r.Intn(ircount)
		if _, ok := badring[n]; !ok {
			badring[n] = struct{}{}
		}
	}

	for i := 0; i < ircount; i++ {
		if _, ok := badring[i]; ok {
			continue
		}
		ind := (i * choose) % containers
		for j := 0; j < choose; j++ {
			nodes[ind].IR = append(nodes[ind].IR, i)
			ind++
			if ind == containers {
				ind = 0
			}
		}
	}

	for _, node := range nodes {
		if len(node.IR) == 0 {
			result.ViolatedCounter++
		}
	}

	return result
}
