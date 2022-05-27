# Jupyter lite notebook site for Trading Strategy python modules

This repo builds a GitHub Pages site to run the examples from the trading-strategy pypi module.

Build with cmake in place, like

```
cmake .
cmake --build .
```

This builds three things:
1) Pyodide (WASM based CPython), along with various custom modules which are dependencies of trading-strategy. 
This is a stock build of pyodide v20.0, with the exception of added packages

2) Packages for pyodide
    Pyodide packages have to be built inside a pyodide build, which is what we do here.
    Most of the dependencies included are pure python so just work in pyodide, or simple C extensions which build 
    easily using the pyodide automatic build system.. Exceptions are:
    - PyArrow: this is a bit of a pig to build, so I built a custom repository which builds version 7.0 in pyodide.
    - Requests: pyodide doesn't have sockets, so requests is shimmed with a custom library that calls XMLHttpRequest. 
      Under the hood, this library relies on a service worker running in the browser to make progress bars work. This
      means that if you run in an incognito window, you lose progress bars. This *might* be fixable by doing chunked 
      requests if the server supports it (technically the combination of on the wire compression and range requests 
      is in theory unsupported in HTTP, but lots of servers do support it)

3) jupyterlite
    Jupyter-lite is a jupyter notebook environment which uses the pyodide kernel to allow you to run iPython notebooks
    entirely in the browser. We use a stock build here, currently version 0.1.0b7.

Versions of all packages used are set in CMakeLists.txt near the top. Edit these to get a newer version.