package main

import (
	"testing"
	"github.com/stretchr/testify/assert"
	"time"
)

func Test_getRangeOfThingsWithoutPrefix(t *testing.T) {
	env := []string{"CHECK_one=192.168.0.1:80", "CHECK_two=192.168.0.2:80", "ignore=192.168.0.2:80"}
	assert.Equal(t, []string{"192.168.0.1:80", "192.168.0.2:80"}, getRangeOfThingsWithoutPrefix(env, "CHECK_"))
}

func Test_listenOnASocket(t *testing.T) {
	go listenOnASocket("0.0.0.0:9090")
	time.Sleep(time.Second)
	assert.True(t, testASocketDial("localhost:9090"))
}

func Test_testASocketDialGood(t *testing.T) {
	assert.True(t, testASocketDial("google.com:80"))
}

func Test_testASocketDialBad(t *testing.T) {
	assert.False(t, testASocketDial("google.com:9090"))
}
