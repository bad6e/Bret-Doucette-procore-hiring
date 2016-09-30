var Taco = React.createClass({
  render: function() {
    const { name, id, handleChange } = this.props;
    return (
      <div>
        <label>
          <input type="checkbox"
               name={name}
               value={id}
               onChange={handleChange}
          />
               {name}
        </label>
      </div>
    );
  }
});
