var Salsa = React.createClass({
  render : function() {
    const { name, id, handleChange } = this.props;
    return (
      <div>
        <input type="checkbox"
               name={name}
               value={id}
               onChange={handleChange}
        />
               {name}
      </div>
    );
  }
});
