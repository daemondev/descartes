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
//https://stackoverflow.com/questions/681653/can-you-get-the-column-names-from-a-sqldatareader