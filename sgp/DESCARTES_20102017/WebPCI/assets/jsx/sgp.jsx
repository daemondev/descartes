var ProcessDiv = React.createClass({

    getInitialState: function () {
        return { myProps: {}, data: [] };
    },

    handleChange: function (event) {
        this.setState({data:event.target.value});
    },

    render: function () {
        return (
                <div id="divReact" class="ProcessDiv"></div>
            )
    }
});

ReactDOM.render(
    <ProcessDiv />,
    document.getElementById('myReact')
);

function tick() {
    const element = (
        <span>{new Date().toLocaleTimeString()}</span>      
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