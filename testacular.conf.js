// Testacular configuration
// Generated on Sat Feb 02 2013 03:24:42 GMT-0300 (BRT)

// base path, that will be used to resolve files and exclude
basePath = '';

preprocessors = {
  '**/*.coffee': 'coffee'
}

// list of files / patterns to load in the browser
files = [
  JASMINE,
  JASMINE_ADAPTER,
  "assets/js/vendor/jsbn.js",
  "assets/js/vendor/jsbn2.js",
  "assets/js/vendor/prng4.js",
  "assets/js/vendor/rng.js",
  "assets/js/vendor/rsa.js",
  "assets/js/vendor/rsa2.js",
  "assets/js/vendor/base64.js",
  "assets/js/vendor/angular.js",
  "test/vendor/angular-mocks.js",
  "assets/js/app/**/*.coffee",
  "test/spec/**/*.coffee"
];

// list of files to exclude
exclude = [
];

// test results reporter to use
// possible values: 'dots', 'progress', 'junit'
reporters = ['progress'];

// web server port
port = 8088;

// cli runner port
runnerPort = 9100;

// enable / disable colors in the output (reporters and logs)
colors = true;

// level of logging
// possible values: LOG_DISABLE || LOG_ERROR || LOG_WARN || LOG_INFO || LOG_DEBUG
logLevel = LOG_INFO;

// enable / disable watching file and executing tests whenever any file changes
autoWatch = true;

// Start these browsers, currently available:
// - Chrome
// - ChromeCanary
// - Firefox
// - Opera
// - Safari (only Mac)
// - PhantomJS
// - IE (only Windows)
browsers = ['Chrome'];

// If browser does not capture in given timeout [ms], kill it
captureTimeout = 5000;

// Continuous Integration mode
// if true, it capture browsers, run tests and exit
singleRun = false;
