var DynamicSearch = React.createClass({

  // sets initial state
  getInitialState: function(){
    return { searchString: '', items : [] };
  },

  // sets state, triggers render method
  handleChange: function(event){
    // grab value form input box
    this.setState({searchString:event.target.value});
    console.log("scope updated!");
  },

  componentWillMount: function() {
  //loadCommentsFromServer: function() {
    var xhr = new XMLHttpRequest();
    xhr.open('get', this.props.url, true);
    xhr.onload = function() {
      var data = JSON.parse(xhr.responseText);
      this.setState({ items: data });
    }.bind(this);
    xhr.send();
  },

  componentDidMount: function() {
    //this.loadCommentsFromServer();
    //window.setInterval(this.loadCommentsFromServer, this.props.pollInterval);
  },

  render: function() {

    //var countries = this.props.items;
    var countries = this.state.items;
    var searchString = this.state.searchString.trim().toLowerCase();

    // filter countries list by value from input box
    if(searchString.length > 0){
      countries = countries.filter(function(country){
        return country.name.toLowerCase().match( searchString );
      });
    }

    return (
      <div>
        <input type="text" value={this.state.searchString} onChange={this.handleChange} placeholder="Search!" />
        <ul>
          { countries.map(function(country){ return <li>{country.name} | {country.total}</li> }) }
        </ul>
      </div>
    )
  }

});

// list of countries, defined with JavaScript object literals
var countries = [
  {"name": "Sweden"}, {"name": "China"}, {"name": "Peru"}, {"name": "Czech Republic"},
  {"name": "Bolivia"}, {"name": "Latvia"}, {"name": "Samoa"}, {"name": "Armenia"},
  {"name": "Greenland"}, {"name": "Cuba"}, {"name": "Western Sahara"}, {"name": "Ethiopia"},
  {"name": "Malaysia"}, {"name": "Argentina"}, {"name": "Uganda"}, {"name": "Chile"},
  {"name": "Aruba"}, {"name": "Japan"}, {"name": "Trinidad and Tobago"}, {"name": "Italy"},
  {"name": "Cambodia"}, {"name": "Iceland"}, {"name": "Dominican Republic"}, {"name": "Turkey"},
  {"name": "Spain"}, {"name": "Poland"}, {"name": "Haiti"}, {"name": "Rusia"}
];

ReactDOM.render(
  //<DynamicSearch items={ countries } />,
  //<DynamicSearch url="/items" pollInterval={2000} items={ countries }/>,
  <DynamicSearch url="/items" pollInterval={2000} />,
  document.getElementById('main')
);
