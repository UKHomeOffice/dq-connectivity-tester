# Connectivity Tester

[![Docker Repository on Quay](https://quay.io/repository/ukhomeofficedigital/connectivity-tester/status)](https://quay.io/repository/ukhomeofficedigital/connectivity-tester)
[![GitHub issues](https://img.shields.io/github/issues/ukhomeofficedigital/connectivity-tester.svg)](https://github.com/ukhomeofficedigital/connectivity-tester/issues)
[![GitHub forks](https://img.shields.io/github/forks/ukhomeofficedigital/connectivity-tester.svg)](https://github.com/ukhomeofficedigital/connectivity-tester/network)
[![GitHub stars](https://img.shields.io/github/stars/ukhomeofficedigital/connectivity-tester.svg)](https://github.com/ukhomeofficedigital/connectivity-tester/stargazers)
[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/ukhomeofficedigital/connectivity-tester/master/LICENSE)


Simple app written in golang that can be used to test network connectivity, useful when mocking up an infrastructure

We've packaged it in a few ways to make running it easy and quick to get going:
 - [Native binary](https://github.com/UKHomeOffice/connectivity-tester/releases/latest) (Windows, Linux, MacOS)
 - [Docker](https://quay.io/repository/ukhomeofficedigital/connectivity-tester/status)
 - [Amazon AMIs](./packer.json)
 - Anything else you make a PR for (hint)
 - [Terraform example](./example.tf)

## Usage
It is configured with environment variables for example:
```
CHECK_self=127.0.0.1:80
CHECK_google=google.com:80
CHECK_googletls=google.com:443
LISTEN_http=0.0.0.0:80
LISTEN_httpagain=0.0.0.0:8088
```

It serves http on any port you specify to listen on, which returns a simple text result of the checks. If any of the checks fail it will return a `500` so you could write some simple healthcheck thing to assert your whole.

If you use one of the AMIs then you specify this in the [Instance User Data](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-metadata.html#instancedata-add-user-data)

If you'd like to use our AMIs and you're in the UK Home Office then feel free to make a PR to the Packer adding your account id to `ami_users`.

### TO DO:
(Pull Requests welcome)
- [ ] Windows AMI build - partial, work in [feature/packer-ansible-windows](/UKHomeOffice/connectivity-tester/tree/feature/packer-ansible-windows)
- [ ] Example Kubernetes config
- [x] Example Terraform config
- [x] Mac x64 binary
- [x] Windows x64 binary
- [x] Linux x64 binary
- [x] Docker Image published to quay
- [x] CI pipeline