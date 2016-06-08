GREAD - a good reader
=====================

**This is no longer developed with last commits in 2013.**

![GREAD Screenshot](https://github.com/mikexstudios/gread/raw/master/app/assets/images/screenshot_w800.png)

What is this?
-------------

GREAD is an unfinished Google Reader clone. Its goal is to provide a similar interface 
as Google Reader with all of the front and backend implemented with standard and
modern frameworks. Specifically:

*   Frontend uses Bootstrap. (AngularJS was planned.)
*   Backend implemented in Rails 4.
*   Feed polling relies on the Superfeedr service to reduce the complexity and load of 
    the app.
*   Deploy to Heroku.

What is the status?
-------------------

The project began as a replacement to the deprecated Google Reader. Over time, it became 
clear that Feedly was the clear winner of the new RSS readers war. Therefore, I decided 
to stop development on GREAD and use Feedly instead.

How do I use this?
------------------

1.  Check out this repository.
2.  Install the gems using bundler.
3.  Create a superfeedr account.
4.  Set environment variables for superfeedr notifications  (see `config/application.rb` 
    or else app will not be able to subscribe or get feed updates.
5.  Push to Heroku. Set up the database using rake.
6.  To enable autoscaling of workers on Heroku, need to login to the web interface, check
    the worker box, scale a worker, and then agree to the billing conditions.
    See: https://github.com/lostboy/workless/issues/42
7.  Also, before running tests, need to setup the test database: `rake db:test:prepare`
