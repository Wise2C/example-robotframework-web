=====================================================
Web testing with Robot Framework and Selenium2Library
=====================================================

示例应用
================

示例程序是一个非常简单的登录页面（如下所示）。使用用户名`demo`和密码'mode'你可以等到到应用首页，否则进入错误页面

.. figure:: demoapp.png

Test cases
==========

测试用例以及相应的资源文件包含在`login_test`目录下

`valid_login.robot`_
    A test suite with a single test for valid login.

    This test has a workflow that is created using keywords in
    the imported resource file.

`invalid_login.robot`_
    A test suite containing tests related to invalid login.

    These tests are data-driven by their nature. They use a single
    keyword, specified with the ``Test Template`` setting, that is called
    with different arguments to cover different scenarios.

    This suite also demonstrates using setups and teardowns in
    different levels.

`gherkin_login.robot`_
    A test suite with a single Gherkin style test.

    This test is functionally identical to the example in the
    `valid_login.robot`_ file.

`resource.robot`_
    A resource file with reusable keywords and variables.

    The system specific keywords created here form our own
    domain specific language. They utilize keywords provided
    by the imported Selenium2Library_.

生成测试报告
=================

执行测试用例之后，可以得到测试报告以及测试日志文件

- `report.html`_
- `log.html`_

运行示例
============

环境准备
-------------

为了运行该测试用例我们需要在本地安装Robot Framework以及Selenium2Library,使用pip我们可以快速安装相应的环境依赖

    pip install robotframework
    pip install robotframework-selenium2library


启动应用程序
-------------------------

运行测试用例之前需要在本机启动测试的应用程序，示例程序源码位于`demoapp`目录下

执行命令::

    python demoapp/server.py

示例程序启动之后，可以通过http://localhost:7272访问该示例应用，你可以尝试进行手动测试，使用`demo/mode`登录该应用

运行自动化测试
-------------

测试用例位于login_tests目录下，我们可以直接执行命令::

    robot login_tests

.. note:: Robot Framework 2.9以及跟早的版本使用pybot命令

运行``robot --help``查看更多帮助信息

切换浏览器支持
------------------------

在`resource.robot`文件中我们定义了环境变量``${BROWSER}``,用以切换测试用浏览器

通过以下命令我们可以快速切换UI测试时使用的浏览器

    robot --variable BROWSER:Chrome login_tests
    robot --variable BROWSER:IE login_tests

基于Dokcer的自动化测试
----------------

在容器中运行UI相关的自动化测试用例时最主要的问题是docker容器当中不包含Screen信息，所以无法打开firefox进行UI相关的测试。

这里我们可以通过使用phantomjs作为浏览器虚拟实现，来完成UI相关的自动化验收测试

使用一下命令可以在容器当中实现容器内的UI自动化测试::

    docker run --rm -v `pwd`:/app rocketcity/robotframework-docker  sh -c 'cd /app && pybot -v BROWSER:phantomjs -v  SERVER:10.0.0.6:7272 -d report --xunit xunit login_tests'
