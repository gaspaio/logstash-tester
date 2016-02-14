# Logstash Tester [![MIT License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)](/LICENSE)

## TL;DR

A set of tools to test your logstash config and custom patterns, using RSpec and
Logstash running in a Docker container

## Long version of same thing

When your logstash config starts getting long, and you start loosing control of
all the cases covered by your custom Grok patterns, you know you're entering **Logstash
Config Hell**

**Logstash Tester** allowed me to grow logstash config files, AND keep my
sanity, by unit testing everything.

## How to use

### 1. Setup Docker

You should have a working Docker environment for **Logstash Tester** to work.

### 1. Setup the projet

This assumes your logstash config files are setup as follows:
-   ```/etc/logstash/conf.d```:

    The Logstash filter config files should follow a naming convention: ```[some-custom-label].filter.conf```). They'll be loaded in alphabetical order.

-   ```/etc/logstash/patterns```: your custom pattern files.

Put you config files and patterns in the right directories (```/config/conf.d``` and
```/config/patterns``` respectivelly).

### 2. Write your test cases

Add your filter test cases to ```/test/spec/conf.d/filter_data.rb```. An example
has been provided for you.

Add your pattern test cases to ```/test/spec/patterns/patterns_data.rb```. An example
has been provided for you.

### 3. Add any other spec files you want

You can add any other specific test suites to /test/spec/patterns and
/test/spec/conf.d. They should be named [somename]_spec.rb, and they will be run
along with the default tests.

### 4. Run tha thing

It's simple: ```./run.sh``` to run all tests, ```./run.sh patterns``` to run
pattern tests only, ```./run.sh filters``` to run filter tests only.

This will create a docker container, install Logstash in it, and run the tests
using RSpec.

## Some other stuff

I'm not a rubyist, the ruby code in the test suits was hacked together from bits
and pieces found here and there. If you're a rubyist, please clean up my mess
and do me a pull request :-). If you're not a rubyistm dont worry, it works.

## Credits

**Logstash Tester** is basically a forked version of Taichi Nakashima's
[RSpec logstash filter](https://github.com/tcnksm/rspec-logstash-filter). Many
thanks to him.


