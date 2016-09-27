var SalsaApi = React.createClass({
  getInitialState : function () {
    return {
      salsas: ''
    };
  },

  componentDidMount: function() {
    $.ajax({
      url: this.props.url,
      dataType: 'json',
      success: function (salsas) {
        this.setState({
          salsas : salsas
        });
      }.bind(this),
      error: function (xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  },

  renderSalsas: function(key) {
    let id = this.state.salsas[key].id;

    return <Salsa key= {this.state.salsas[key].id}
                  name= {this.state.salsas[key].name}
                  id=  {this.state.salsas[key].id}
                  handleChange= {this.props.handleChangeSalsaIds.bind(null, id)}
           />
  },

  render : function() {
    return (
      <div>
        <h5>Select Sauces to Find:</h5>
        {Object.keys(this.state.salsas).map(this.renderSalsas)}
      </div>
    );
  }
});
