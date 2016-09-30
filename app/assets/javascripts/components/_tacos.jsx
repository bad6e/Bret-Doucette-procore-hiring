var Tacos = React.createClass({
  getInitialState: function () {
    return {
      tacos: [],
    };
  },

  componentDidMount: function() {
    $.ajax({
      url: this.props.url,
      dataType: 'json',
      success: function (tacos) {
        this.setState({
          tacos: tacos
        });
      }.bind(this),
      error: function (xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  },

  renderTacos: function(taco) {
    return <Taco key= {taco.id}
                 name= {taco.name}
                 id= {taco.id}
                 handleChange= {this.props.handleChangeTacoIds.bind(null, taco.id)}
           />
  },

  render: function() {
    return (
      <div>
        <h5>Select Tacos to Find:</h5>
        {this.state.tacos.map(this.renderTacos)}
      </div>
    );
  }
});
