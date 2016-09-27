var TacoApi = React.createClass({
  getInitialState : function () {
    return {
      tacos: '',
    };
  },

  componentDidMount: function() {
    $.ajax({
      url: this.props.url,
      dataType: 'json',
      success: function (tacos) {
        this.setState({
          tacos : tacos
        });
      }.bind(this),
      error: function (xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  },

  renderTacos: function(key) {
    let id = this.state.tacos[key].id;

    return <Taco key= {this.state.tacos[key].id}
                 name= {this.state.tacos[key].name}
                 id= {this.state.tacos[key].id}
                 handleChange= {this.props.handleChangeTacoIds.bind(null, id)}
           />
  },

  render : function() {
    return (
      <div>
        <h5>Select Tacos to Find:</h5>
        {Object.keys(this.state.tacos).map(this.renderTacos)}
      </div>
    );
  }
});
