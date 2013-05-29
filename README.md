GREAD Island Reader
===================

Need to set environment variables for superfeedr notifications  (see  
`config/application.rb` or else app will not be able to subscribe or get
feed updates.

To enable autoscaling of workers on Heroku, need to login to the web interface
check the worker box and scale a worker and then agree to the billing conditions.

See: https://github.com/lostboy/workless/issues/42

Also, before running tests, need to setup the test database:
    rake db:test:prepare
