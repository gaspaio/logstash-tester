# Logstash Tester [![MIT License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)](/LICENSE)

### TL;DR

A set of tools to test your logstash config and custom patterns, using RSpec and
Logstash running in a Docker container

Test it, it works: ```./run.sh```.

### Long version

When your logstash config starts getting really long, and you start loosing control of
all the cases covered by your custom Grok patterns, you know you're entering **Logstash
Config Hell**.

**Logstash Tester** allows us (hopefully) to grow your logstash config files, AND keep your
sanity, by unit testing everything.

#### HOWTO use it

You should have a working Docker environment for **Logstash Tester** to work.

An example is worth a thousant doc pages (sometimes), checkout the example runner file "run_example.sh":
-   Configuration files for logstash are located in ```example/filter/conf.d```
(filter definitions) and ```example/patterns/patternsdir``` (custom patterns).
-   Test cases can be found in ```example/filter/test_cases``` and
```example/patterns/test_cases```. Their syntax is described below.
-   You should create your own directory containing the config & pattern files
    you'll be testing as well as the test cases for both filters and patterns.
-   Then you'll copy run_example.sh into that directory, rename it and
    put the correct directories in the conf section.
-   Run it.

Useful info:
-   The Logstash filter config files should follow a naming convention
    (```[some-custom-label].filter.conf```).
    They'll be loaded in alphabetical order.

-   Logstash-tester assumes the patternsdir setting in grok filters is set to
    ```/etc/logstash/patterns```.

#### Test case syntax

Test cases are described in JSON.

*3.  Write your test cases*

Add your filter test cases to ```/test/spec/conf.d/filter_data.rb```. An example
has been provided for you.

Add your pattern test cases to ```/test/spec/patterns/patterns_data.rb```. An example
has been provided for you.

*4.  Add any other spec files you want*

You can add any other specific test suites to ```/test/spec/patterns``` and
```/test/spec/conf.d```. They should be named [somename]_spec.rb, and they will be run
along with the default tests.

*5.  Run tha thing*

It's simple:

-   ```./run.sh``` to run all tests
-   ```./run.sh patterns``` to run pattern tests only
-   ```./run.sh filters``` to run filter tests only.

This will create a docker container, install Logstash in it, and run the tests
using RSpec.

### Some other stuff

I'm not a rubyist, the ruby code in the test suites was hacked together from bits
and pieces found here and there. If you're a rubyist, please clean up my mess
and do me a pull request :-). If you're not a rubyistm don't worry, it works.

### Credits

**Logstash Tester** is really little more than a forked version of Taichi Nakashima's
[RSpec logstash filter](https://github.com/tcnksm/rspec-logstash-filter). Many
thanks to him.


