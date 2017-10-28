var ProcessDiv = React.createClass({

    getInitialState: function () {
        return { myProps: {}, data: [] };
    },

    handleChange: function (event) {
        this.setState({data:event.target.value});
    },

    render: function () {
        return (
                <div id="divReact" style="width:100%; height:100%; background-color:red; position:static; z-index:9999;"></div>
            )
    }
});

ReactDOM.render(
    <ProcessDiv />,
    document.getElementById('myReact')
);