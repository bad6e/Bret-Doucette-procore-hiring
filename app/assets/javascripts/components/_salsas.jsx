var Salsas = React.createClass({
  getInitialState: function () {
    return {
      salsas: []
    };
  },

  componentDidMount: function() {
    $.ajax({
      url: this.props.url,
      dataType: 'json',
      success: function (salsas) {
        this.setState({
          salsas: salsas
        });
      }.bind(this),
      error: function (xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  },

  renderSalsas: function(salsa) {
    return <Salsa key= {salsa.id}
                  name= {salsa.name}
                  id=  {salsa.id}
                  handleChange= {this.props.handleChangeSalsaIds.bind(null, salsa.id)}
           />
  },

  render: function() {
    return (
      <div>
        <h5>Select Sauces to Find:</h5>
        {this.state.salsas.map(this.renderSalsas)}
      </div>
    );
  }
});
