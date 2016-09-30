var Store = React.createClass({
  render: function() {
    const { name, id, city } = this.props;
    return (
      <tr>
        <td>{name}</td>
        <td>{city}</td>
      </tr>
    );
  }
});