package main

import (
	"fmt"
	"net/http"
	"strings"
	"os"
	"net"
	"time"
	"io"
	"strconv"
)

func main() {
	http.HandleFunc("/", hello)
	for _, listenAddr := range getRangeOfThingsWithoutPrefix(os.Environ(), "LISTEN_") {
		go listenOnASocket(listenAddr)
	}
	listenOnASocket("127.0.0.1:8080")
}

func getRangeOfThingsWithoutPrefix(env []string, prefix string) []string {
	checks := []string{}
	for _, pair := range env {
		if (strings.HasPrefix(pair, prefix)) {
			checks = append(checks, strings.SplitAfter(pair, "=")[1])
		}
	}
	return checks
}

func testASocketDial(addr string) bool {
	_, err := net.DialTimeout("tcp", addr, time.Second)
	fmt.Println("Test", addr, err == nil)
	return err == nil
}

func listenOnASocket(addr string) {
	fmt.Println("Listening on:", addr)
	http.ListenAndServe(addr, nil)
}

func hello(w http.ResponseWriter, req *http.Request) {
	var statusCode int = 200
	var buffer string
	for _, addr := range getRangeOfThingsWithoutPrefix(os.Environ(), "CHECK_") {
		var dialResponse = testASocketDial(addr)
		if !dialResponse {
			statusCode = 500
		}
		buffer = buffer + "Connect to " + addr + " " + strconv.FormatBool(dialResponse) + "\n"
	}
	w.WriteHeader(statusCode)
	io.WriteString(w, buffer)
}
