module.exports =
/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = require('../../../ssr-module-cache.js');
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		var threw = true;
/******/ 		try {
/******/ 			modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/ 			threw = false;
/******/ 		} finally {
/******/ 			if(threw) delete installedModules[moduleId];
/******/ 		}
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, { enumerable: true, get: getter });
/******/ 		}
/******/ 	};
/******/
/******/ 	// define __esModule on exports
/******/ 	__webpack_require__.r = function(exports) {
/******/ 		if(typeof Symbol !== 'undefined' && Symbol.toStringTag) {
/******/ 			Object.defineProperty(exports, Symbol.toStringTag, { value: 'Module' });
/******/ 		}
/******/ 		Object.defineProperty(exports, '__esModule', { value: true });
/******/ 	};
/******/
/******/ 	// create a fake namespace object
/******/ 	// mode & 1: value is a module id, require it
/******/ 	// mode & 2: merge all properties of value into the ns
/******/ 	// mode & 4: return value when already ns object
/******/ 	// mode & 8|1: behave like require
/******/ 	__webpack_require__.t = function(value, mode) {
/******/ 		if(mode & 1) value = __webpack_require__(value);
/******/ 		if(mode & 8) return value;
/******/ 		if((mode & 4) && typeof value === 'object' && value && value.__esModule) return value;
/******/ 		var ns = Object.create(null);
/******/ 		__webpack_require__.r(ns);
/******/ 		Object.defineProperty(ns, 'default', { enumerable: true, value: value });
/******/ 		if(mode & 2 && typeof value != 'string') for(var key in value) __webpack_require__.d(ns, key, function(key) { return value[key]; }.bind(null, key));
/******/ 		return ns;
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 6);
/******/ })
/************************************************************************/
/******/ ({

/***/ "../node_modules/@babel/runtime-corejs2/core-js/json/stringify.js":
/*!************************************************************************!*\
  !*** ../node_modules/@babel/runtime-corejs2/core-js/json/stringify.js ***!
  \************************************************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

module.exports = __webpack_require__(/*! core-js/library/fn/json/stringify */ "core-js/library/fn/json/stringify");

/***/ }),

/***/ "../node_modules/@babel/runtime-corejs2/core-js/object/assign.js":
/*!***********************************************************************!*\
  !*** ../node_modules/@babel/runtime-corejs2/core-js/object/assign.js ***!
  \***********************************************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

module.exports = __webpack_require__(/*! core-js/library/fn/object/assign */ "core-js/library/fn/object/assign");

/***/ }),

/***/ "../node_modules/@babel/runtime-corejs2/helpers/esm/extends.js":
/*!*********************************************************************!*\
  !*** ../node_modules/@babel/runtime-corejs2/helpers/esm/extends.js ***!
  \*********************************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "default", function() { return _extends; });
/* harmony import */ var _core_js_object_assign__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ../../core-js/object/assign */ "../node_modules/@babel/runtime-corejs2/core-js/object/assign.js");
/* harmony import */ var _core_js_object_assign__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(_core_js_object_assign__WEBPACK_IMPORTED_MODULE_0__);

function _extends() {
  _extends = _core_js_object_assign__WEBPACK_IMPORTED_MODULE_0___default.a || function (target) {
    for (var i = 1; i < arguments.length; i++) {
      var source = arguments[i];

      for (var key in source) {
        if (Object.prototype.hasOwnProperty.call(source, key)) {
          target[key] = source[key];
        }
      }
    }

    return target;
  };

  return _extends.apply(this, arguments);
}

/***/ }),

/***/ "./constants.js":
/*!**********************!*\
  !*** ./constants.js ***!
  \**********************/
/*! exports provided: AUTH_TOKEN, HASURA_CLAIM, HASURA_USER_ID */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "AUTH_TOKEN", function() { return AUTH_TOKEN; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "HASURA_CLAIM", function() { return HASURA_CLAIM; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "HASURA_USER_ID", function() { return HASURA_USER_ID; });
const AUTH_TOKEN = 'mantra';
const HASURA_CLAIM = 'https://hasura.io/jwt/claims';
const HASURA_USER_ID = 'x-hasura-user-id';

/***/ }),

/***/ "./lib/logger.js":
/*!***********************!*\
  !*** ./lib/logger.js ***!
  \***********************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony default export */ __webpack_exports__["default"] = (log => {
  return {
    info: (desc, body) => {
      console.log(log, desc);
      console.table(body);
    },
    debug: (desc, body) => {
      console.log(log, desc);
      console.table(body);
    },
    error: (desc, body) => {
      console.log(log, desc);
      console.table(body);
    }
  };
});

/***/ }),

/***/ "./lib/with-protect-route.js":
/*!***********************************!*\
  !*** ./lib/with-protect-route.js ***!
  \***********************************/
/*! exports provided: withProtectRoute */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "withProtectRoute", function() { return withProtectRoute; });
/* harmony import */ var _babel_runtime_corejs2_helpers_esm_extends__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! @babel/runtime-corejs2/helpers/esm/extends */ "../node_modules/@babel/runtime-corejs2/helpers/esm/extends.js");
/* harmony import */ var _babel_runtime_corejs2_core_js_object_assign__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @babel/runtime-corejs2/core-js/object/assign */ "../node_modules/@babel/runtime-corejs2/core-js/object/assign.js");
/* harmony import */ var _babel_runtime_corejs2_core_js_object_assign__WEBPACK_IMPORTED_MODULE_1___default = /*#__PURE__*/__webpack_require__.n(_babel_runtime_corejs2_core_js_object_assign__WEBPACK_IMPORTED_MODULE_1__);
/* harmony import */ var react__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! react */ "react");
/* harmony import */ var react__WEBPACK_IMPORTED_MODULE_2___default = /*#__PURE__*/__webpack_require__.n(react__WEBPACK_IMPORTED_MODULE_2__);
/* harmony import */ var next_router__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! next/router */ "next/router");
/* harmony import */ var next_router__WEBPACK_IMPORTED_MODULE_3___default = /*#__PURE__*/__webpack_require__.n(next_router__WEBPACK_IMPORTED_MODULE_3__);
/* harmony import */ var _constants__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! ../constants */ "./constants.js");


var _jsxFileName = "/cloud-computer/cloud-computer/apps/webapp/client/lib/with-protect-route.js";



const withProtectRoute = BaseComponent => Object(next_router__WEBPACK_IMPORTED_MODULE_3__["withRouter"])((_ref) => {
  let props = _babel_runtime_corejs2_core_js_object_assign__WEBPACK_IMPORTED_MODULE_1___default()({}, _ref);

  if (false) {}

  if (false) {}
  /** This is for handling the index page cause its being used
   * for handling the token
   */


  let token;

  if (false) {}

  if (!token) {
    return "Loading...";
  }

  return react__WEBPACK_IMPORTED_MODULE_2___default.a.createElement(BaseComponent, Object(_babel_runtime_corejs2_helpers_esm_extends__WEBPACK_IMPORTED_MODULE_0__["default"])({}, props, {
    __source: {
      fileName: _jsxFileName,
      lineNumber: 29
    },
    __self: undefined
  }));
});

/***/ }),

/***/ "./lib/with-stream-client.js":
/*!***********************************!*\
  !*** ./lib/with-stream-client.js ***!
  \***********************************/
/*! exports provided: withStreamClient */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "withStreamClient", function() { return withStreamClient; });
/* harmony import */ var _babel_runtime_corejs2_helpers_esm_extends__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! @babel/runtime-corejs2/helpers/esm/extends */ "../node_modules/@babel/runtime-corejs2/helpers/esm/extends.js");
/* harmony import */ var _babel_runtime_corejs2_core_js_json_stringify__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @babel/runtime-corejs2/core-js/json/stringify */ "../node_modules/@babel/runtime-corejs2/core-js/json/stringify.js");
/* harmony import */ var _babel_runtime_corejs2_core_js_json_stringify__WEBPACK_IMPORTED_MODULE_1___default = /*#__PURE__*/__webpack_require__.n(_babel_runtime_corejs2_core_js_json_stringify__WEBPACK_IMPORTED_MODULE_1__);
/* harmony import */ var _babel_runtime_corejs2_core_js_object_assign__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! @babel/runtime-corejs2/core-js/object/assign */ "../node_modules/@babel/runtime-corejs2/core-js/object/assign.js");
/* harmony import */ var _babel_runtime_corejs2_core_js_object_assign__WEBPACK_IMPORTED_MODULE_2___default = /*#__PURE__*/__webpack_require__.n(_babel_runtime_corejs2_core_js_object_assign__WEBPACK_IMPORTED_MODULE_2__);
/* harmony import */ var react__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! react */ "react");
/* harmony import */ var react__WEBPACK_IMPORTED_MODULE_3___default = /*#__PURE__*/__webpack_require__.n(react__WEBPACK_IMPORTED_MODULE_3__);
/* harmony import */ var _logger__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! ./logger */ "./lib/logger.js");



var _jsxFileName = "/cloud-computer/cloud-computer/apps/webapp/client/lib/with-stream-client.js";


const log = Object(_logger__WEBPACK_IMPORTED_MODULE_4__["default"])('stream-client');
const withStreamClient = BaseComponent => (_ref) => {
  let props = _babel_runtime_corejs2_core_js_object_assign__WEBPACK_IMPORTED_MODULE_2___default()({}, _ref);

  const api = {
    get: async url => {
      try {
        log.info('GET', `${"https://dev.stream.webapp.jackson.cloud-computer.dev"}${url}`);
        /**
         * Fetch data
         * @type {Response}
         */

        const res = await fetch(`${"https://dev.stream.webapp.jackson.cloud-computer.dev"}${url}`, {
          method: 'GET',
          headers: {}
        });
        /**
         * Check if its ok else throw it
         */

        if (res.ok) {
          /** Serialize result **/
          const result = await res.json();
          log.info('RESULT', result);
          return result;
        }

        log.error('ERROR', res);
        throw await res.json();
      } catch (e) {
        throw e;
      }
    },
    post: async (url, body) => {
      try {
        log.info(`POST ${"https://dev.stream.webapp.jackson.cloud-computer.dev"}${url}`, body);
        /**
         * Fetch data
         * @type {Response}
         */

        const res = await fetch(`${"https://dev.stream.webapp.jackson.cloud-computer.dev"}${url}`, {
          method: 'POST',
          body: _babel_runtime_corejs2_core_js_json_stringify__WEBPACK_IMPORTED_MODULE_1___default()(body),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
          }
        });
        /**
         * Check if its ok else throw it
         */

        if (res.ok) {
          /** Serialize result **/
          const result = await res.json();
          log.info('RESULT', result);
          return result;
        }

        log.error('ERROR', res);
        throw await res.json();
      } catch (e) {
        throw e;
      }
    }
  };
  return react__WEBPACK_IMPORTED_MODULE_3___default.a.createElement(BaseComponent, Object(_babel_runtime_corejs2_helpers_esm_extends__WEBPACK_IMPORTED_MODULE_0__["default"])({}, props, {
    streamAPI: api,
    __source: {
      fileName: _jsxFileName,
      lineNumber: 73
    },
    __self: undefined
  }));
};

/***/ }),

/***/ "./pages/stream.js":
/*!*************************!*\
  !*** ./pages/stream.js ***!
  \*************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var react__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! react */ "react");
/* harmony import */ var react__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(react__WEBPACK_IMPORTED_MODULE_0__);
/* harmony import */ var jwt_decode__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! jwt-decode */ "jwt-decode");
/* harmony import */ var jwt_decode__WEBPACK_IMPORTED_MODULE_1___default = /*#__PURE__*/__webpack_require__.n(jwt_decode__WEBPACK_IMPORTED_MODULE_1__);
/* harmony import */ var antd__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! antd */ "antd");
/* harmony import */ var antd__WEBPACK_IMPORTED_MODULE_2___default = /*#__PURE__*/__webpack_require__.n(antd__WEBPACK_IMPORTED_MODULE_2__);
/* harmony import */ var graphql_tag__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! graphql-tag */ "graphql-tag");
/* harmony import */ var graphql_tag__WEBPACK_IMPORTED_MODULE_3___default = /*#__PURE__*/__webpack_require__.n(graphql_tag__WEBPACK_IMPORTED_MODULE_3__);
/* harmony import */ var react_apollo__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! react-apollo */ "react-apollo");
/* harmony import */ var react_apollo__WEBPACK_IMPORTED_MODULE_4___default = /*#__PURE__*/__webpack_require__.n(react_apollo__WEBPACK_IMPORTED_MODULE_4__);
/* harmony import */ var _constants__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(/*! ../constants */ "./constants.js");
/* harmony import */ var _lib_with_protect_route__WEBPACK_IMPORTED_MODULE_6__ = __webpack_require__(/*! ../lib/with-protect-route */ "./lib/with-protect-route.js");
/* harmony import */ var _lib_with_stream_client__WEBPACK_IMPORTED_MODULE_7__ = __webpack_require__(/*! ../lib/with-stream-client */ "./lib/with-stream-client.js");
/* harmony import */ var next_router__WEBPACK_IMPORTED_MODULE_8__ = __webpack_require__(/*! next/router */ "next/router");
/* harmony import */ var next_router__WEBPACK_IMPORTED_MODULE_8___default = /*#__PURE__*/__webpack_require__.n(next_router__WEBPACK_IMPORTED_MODULE_8__);
/* harmony import */ var ansi_up__WEBPACK_IMPORTED_MODULE_9__ = __webpack_require__(/*! ansi_up */ "ansi_up");
/* harmony import */ var ansi_up__WEBPACK_IMPORTED_MODULE_9___default = /*#__PURE__*/__webpack_require__.n(ansi_up__WEBPACK_IMPORTED_MODULE_9__);
var _jsxFileName = "/cloud-computer/cloud-computer/apps/webapp/client/pages/stream.js";











const ansi_up = new ansi_up__WEBPACK_IMPORTED_MODULE_9___default.a();

const Stream = ({
  client,
  streamAPI
}) => {
  const token = localStorage[_constants__WEBPACK_IMPORTED_MODULE_5__["AUTH_TOKEN"]];
  const userId = jwt_decode__WEBPACK_IMPORTED_MODULE_1___default()(token)[_constants__WEBPACK_IMPORTED_MODULE_5__["HASURA_CLAIM"]][_constants__WEBPACK_IMPORTED_MODULE_5__["HASURA_USER_ID"]];
  const [provisioning, setProvisioning] = Object(react__WEBPACK_IMPORTED_MODULE_0__["useState"])(false);
  const [build, setBuild] = Object(react__WEBPACK_IMPORTED_MODULE_0__["useState"])(null);
  /**
   * 1. Check if there is an existing build
   * 2. If none then provision the box
   * 3. If existing just redirect to the new box but check the build if it is successful
   */

  Object(react__WEBPACK_IMPORTED_MODULE_0__["useEffect"])(() => {
    client.query({
      query: graphql_tag__WEBPACK_IMPORTED_MODULE_3___default.a`
                query GetLatestBuild($id : Int){
                    build(where: {user_id: {_eq: $id}}, order_by: {id: desc}, limit: 1) {
                        id
                        code
                    }
                }

            `,
      variables: {
        id: userId
      }
    }).then(({
      data: {
        build
      }
    }) => {
      if (!build.length) {
        return streamAPI.get(`/provision?userId=${userId}`).then(data => {
          if (data.redirect) {
            window.location = data.redirect;
            return;
          }

          setBuild(data.build.id);
          setProvisioning(true);
        });
      }

      setBuild(build[0].id);
      setProvisioning(true);
    });
  }, []);

  const redirect = () => {
    client.query({
      query: graphql_tag__WEBPACK_IMPORTED_MODULE_3___default.a`
                query getCloudUrl($userId : bigint){
                    user(where :{
                        id : {
                            _eq :$userId
                        }
                    }) {
                        cloud_url
                    }
                }

            `,
      variables: {
        userId: userId
      }
    }).then(({
      data: {
        user
      }
    }) => {
      setTimeout(() => {
        window.location = user[0].cloud_url;
      }, 2000);
    });
  };

  if (provisioning) {
    return react__WEBPACK_IMPORTED_MODULE_0___default.a.createElement(react_apollo__WEBPACK_IMPORTED_MODULE_4__["Subscription"], {
      variables: {
        id: build
      },
      subscription: graphql_tag__WEBPACK_IMPORTED_MODULE_3___default.a`
                    subscription getLogs($id : Int){
                      log(where: {build_id: {_eq: $id}}) {
                        log
                      }
                    }
                `,
      __source: {
        fileName: _jsxFileName,
        lineNumber: 85
      },
      __self: undefined
    }, ({
      data,
      loading
    }) => {
      if (loading || !data) {
        return react__WEBPACK_IMPORTED_MODULE_0___default.a.createElement("div", {
          __source: {
            fileName: _jsxFileName,
            lineNumber: 98
          },
          __self: undefined
        }, "Fetching logs...");
      }

      const logs = data.log.map(({
        log
      }, index) => {
        return react__WEBPACK_IMPORTED_MODULE_0___default.a.createElement("p", {
          key: `log-${index}`,
          style: {
            padding: '0 15px'
          },
          __source: {
            fileName: _jsxFileName,
            lineNumber: 103
          },
          __self: undefined
        }, react__WEBPACK_IMPORTED_MODULE_0___default.a.createElement("div", {
          styles: {
            'white-space': 'pre-wrap'
          },
          dangerouslySetInnerHTML: {
            __html: ansi_up.ansi_to_html(log).replace(/\n/g, "<br />")
          },
          __source: {
            fileName: _jsxFileName,
            lineNumber: 104
          },
          __self: undefined
        }));
      });
      return react__WEBPACK_IMPORTED_MODULE_0___default.a.createElement("div", {
        __source: {
          fileName: _jsxFileName,
          lineNumber: 109
        },
        __self: undefined
      }, react__WEBPACK_IMPORTED_MODULE_0___default.a.createElement("div", {
        style: {
          margin: '30px'
        },
        __source: {
          fileName: _jsxFileName,
          lineNumber: 110
        },
        __self: undefined
      }, react__WEBPACK_IMPORTED_MODULE_0___default.a.createElement(react_apollo__WEBPACK_IMPORTED_MODULE_4__["Subscription"], {
        variables: {
          id: build
        },
        subscription: graphql_tag__WEBPACK_IMPORTED_MODULE_3___default.a`
                                        subscription getBuild($id : Int){
                                              build(where:{
                                                id :{
                                                  _eq :$id
                                                }
                                              }) {
                                                code
                                              }
                                         }
                                    `,
        __source: {
          fileName: _jsxFileName,
          lineNumber: 113
        },
        __self: undefined
      }, ({
        data
      }) => {
        if (data && data.build[0]) {
          const buildCode = data.build[0].code;

          if (+buildCode == 0) {
            redirect();
            return react__WEBPACK_IMPORTED_MODULE_0___default.a.createElement("div", {
              __source: {
                fileName: _jsxFileName,
                lineNumber: 134
              },
              __self: undefined
            }, "Redirecting...");
          }
        }

        return react__WEBPACK_IMPORTED_MODULE_0___default.a.createElement("div", {
          __source: {
            fileName: _jsxFileName,
            lineNumber: 138
          },
          __self: undefined
        }, "Building...");
      })), react__WEBPACK_IMPORTED_MODULE_0___default.a.createElement("div", {
        style: {
          overflowX: 'scroll',
          margin: '30px',
          background: '#2b2b2b',
          paddingTop: '20px',
          paddingBottom: '20px',
          color: '#f1f1f1'
        },
        __source: {
          fileName: _jsxFileName,
          lineNumber: 142
        },
        __self: undefined
      }, logs));
    });
  }

  return react__WEBPACK_IMPORTED_MODULE_0___default.a.createElement("div", {
    __source: {
      fileName: _jsxFileName,
      lineNumber: 158
    },
    __self: undefined
  }, "Fetching Status...");
};
/** add HOC's need for the component **/


/* harmony default export */ __webpack_exports__["default"] = (Object(react_apollo__WEBPACK_IMPORTED_MODULE_4__["compose"])(_lib_with_protect_route__WEBPACK_IMPORTED_MODULE_6__["withProtectRoute"], react_apollo__WEBPACK_IMPORTED_MODULE_4__["withApollo"], _lib_with_stream_client__WEBPACK_IMPORTED_MODULE_7__["withStreamClient"], next_router__WEBPACK_IMPORTED_MODULE_8__["withRouter"])(Stream));

/***/ }),

/***/ 6:
/*!*******************************!*\
  !*** multi ./pages/stream.js ***!
  \*******************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

module.exports = __webpack_require__(/*! /cloud-computer/cloud-computer/apps/webapp/client/pages/stream.js */"./pages/stream.js");


/***/ }),

/***/ "ansi_up":
/*!**************************!*\
  !*** external "ansi_up" ***!
  \**************************/
/*! no static exports found */
/***/ (function(module, exports) {

module.exports = require("ansi_up");

/***/ }),

/***/ "antd":
/*!***********************!*\
  !*** external "antd" ***!
  \***********************/
/*! no static exports found */
/***/ (function(module, exports) {

module.exports = require("antd");

/***/ }),

/***/ "core-js/library/fn/json/stringify":
/*!****************************************************!*\
  !*** external "core-js/library/fn/json/stringify" ***!
  \****************************************************/
/*! no static exports found */
/***/ (function(module, exports) {

module.exports = require("core-js/library/fn/json/stringify");

/***/ }),

/***/ "core-js/library/fn/object/assign":
/*!***************************************************!*\
  !*** external "core-js/library/fn/object/assign" ***!
  \***************************************************/
/*! no static exports found */
/***/ (function(module, exports) {

module.exports = require("core-js/library/fn/object/assign");

/***/ }),

/***/ "graphql-tag":
/*!******************************!*\
  !*** external "graphql-tag" ***!
  \******************************/
/*! no static exports found */
/***/ (function(module, exports) {

module.exports = require("graphql-tag");

/***/ }),

/***/ "jwt-decode":
/*!*****************************!*\
  !*** external "jwt-decode" ***!
  \*****************************/
/*! no static exports found */
/***/ (function(module, exports) {

module.exports = require("jwt-decode");

/***/ }),

/***/ "next/router":
/*!******************************!*\
  !*** external "next/router" ***!
  \******************************/
/*! no static exports found */
/***/ (function(module, exports) {

module.exports = require("next/router");

/***/ }),

/***/ "react":
/*!************************!*\
  !*** external "react" ***!
  \************************/
/*! no static exports found */
/***/ (function(module, exports) {

module.exports = require("react");

/***/ }),

/***/ "react-apollo":
/*!*******************************!*\
  !*** external "react-apollo" ***!
  \*******************************/
/*! no static exports found */
/***/ (function(module, exports) {

module.exports = require("react-apollo");

/***/ })

/******/ });
//# sourceMappingURL=stream.js.map