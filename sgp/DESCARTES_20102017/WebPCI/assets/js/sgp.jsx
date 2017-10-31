(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
var ProcessDiv = React.createClass({displayName: "ProcessDiv",

    getInitialState: function () {
        return { myProps: {}, data: [] };
    },

    handleChange: function (event) {
        this.setState({data:event.target.value});
    },

    render: function () {
        return (
                React.createElement("div", {id: "divReact", class: "ProcessDiv"})
            )
    }
});

ReactDOM.render(
    React.createElement(ProcessDiv, null),
    document.getElementById('myReact')
);

function tick() {
    const element = (
        React.createElement("span", null, new Date().toLocaleTimeString())      
    );
    ReactDOM.render(
        element,
        document.getElementById('lblTime')
    );
}

setInterval(tick, 1000);
//https://stackoverflow.com/questions/681653/can-you-get-the-column-names-from-a-sqldatareader
/*
https://stackoverflow.com/questions/24841855/react-js-access-to-component-methods
https://reactjs.org/blog/2017/07/26/error-handling-in-react-16.html
https://reactjs.org/docs/portals.html
https://stackoverflow.com/questions/31612598/call-a-react-component-method-from-outside
https://reactjs.org/docs/state-and-lifecycle.html
https://stackoverflow.com/questions/38845489/accessing-component-method-from-outside-the-react-app */

},{}]},{},[1]);
