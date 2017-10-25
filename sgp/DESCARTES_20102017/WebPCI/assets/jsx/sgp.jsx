//My Components for SGP Project
var ProcessDiv = React.createClass({
    getInitialState: function () {
        return { myProps: {}, data: [] };
    },
    handleChange: function (e) {
        this.setState({data:e.target.value});
    },
    render: function () {

    }
});

ReactDOM.render(
    <ProcessDiv />,
    document.getElementById('divSGP')
);