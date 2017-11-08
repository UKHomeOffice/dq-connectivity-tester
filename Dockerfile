FROM scratch
ADD connectivity-tester-linux-amd64 /connectivity-tester
CMD ["/connectivity-tester"]