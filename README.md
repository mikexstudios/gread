GREAD Island Reader
===================

To enable autoscaling of workers on Heroku, need to login to the web interface
check the worker box and scale a worker and then agree to the billing conditions.

See: https://github.com/lostboy/workless/issues/42

Also, before running tests, need to setup the test database:
    rake db:test:prepare
