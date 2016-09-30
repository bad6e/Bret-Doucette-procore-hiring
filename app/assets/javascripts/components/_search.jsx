var Search = React.createClass({

  getInitialState: function () {
    return {
      stores: [],
      checkedTacoIds: [],
      checkedSalsaIds: []
    };
  },

  findItem: function(itemIds, id) {
    let foundItem = _.find(itemIds, function(itemId) {
      return id === itemId;
    });
    return foundItem
  },

  removeItemFromState: function(itemIds, id) {
    let removeItem = _.remove(itemIds, function(itemId) {
      return itemId !== id
    })
    return removeItem
  },

  updateTacosState: function(updatedState, callback) {
    this.setState({
      checkedTacoIds: updatedState
    }, callback)
  },

  updateSalsasState: function(updatedState, callback) {
    this.setState({
      checkedSalsaIds: updatedState
    }, callback)
  },

  handleChangeTacoIds: function(id) {
    const checkedTacoState = this.state.checkedTacoIds
    const foundTaco = this.findItem(checkedTacoState, id);

    if (foundTaco) {
      const remainingCheckedTacos = this.removeItemFromState(checkedTacoState, id);
      this.updateTacosState(remainingCheckedTacos, this.searchTacosAndSalas)
    } else {
      const updatedCheckedTacos = checkedTacoState.slice();
      updatedCheckedTacos.push(id);
      this.updateTacosState(updatedCheckedTacos, this.searchTacosAndSalas)
    }
  },

  handleChangeSalsaIds: function(id) {
    const checkedSalsaState = this.state.checkedSalsaIds
    const foundSalsa = this.findItem(checkedSalsaState, id);

    if (foundSalsa) {
      let remainingCheckedSalsas = this.removeItem(checkedSalsaState, id);
      this.updateSalsasState(remainingCheckedSalsas, this.searchTacosAndSalas)
    } else {
      let updatedCheckedSalsas = checkedSalsaState.slice();
      updatedCheckedSalsas.push(id);
      this.updateSalsasState(updatedCheckedSalsas, this.searchTacosAndSalas)
    }
  },

  formatSearchUrl: function() {
    let url = `/api/v1/search?`;
    if (this.state.checkedTacoIds.length > 0) {
      url += `&tacos=${this.state.checkedTacoIds}`;
    }
    if (this.state.checkedSalsaIds.length > 0) {
      url += `&salsas=${this.state.checkedSalsaIds}`;
    }
    return url;
  },

  searchTacosAndSalas: function() {
    const tacos = this.state.checkedTacoIds;
    const salsas = this.state.checkedSalsaIds;

    if (tacos.length === 0 && salsas.length === 0) {
      this.setState({
        stores: []
      });
    } else {
      $.ajax({
        url: this.formatSearchUrl(),
        dataType: 'json',
        type: 'GET',
        success: function(stores) {
          this.setState({
            stores : stores
          });
        }.bind(this),
        error: function(xhr, status, err) {
          console.error(this.props.url, status, err.toString());
        }.bind(this)
      });
    }
  },

  renderStores: function(store) {
    return <Store key= {store.id}
                  name= {store.name}
                  id= {store.id}
                  city = {store.city.name}
            />
  },

  renderStoreTableHeader: function() {
    return this.state.checkedTacoIds.length > 0 || this.state.checkedSalsaIds.length > 0 ? <th>Store</th> : <th className="title">Select Tacos and Sauces on the Left!</th>
  },

  renderCityTableHeader: function() {
    return this.state.checkedTacoIds.length > 0 || this.state.checkedSalsaIds.length > 0 ? <th>City</th> : null
  },

  render: function() {
    return (
      <div className="container">
        <div className="row">
          <div className="col-md-4 taco-field">
            <Tacos url= '/api/v1/tacos'
                     handleChangeTacoIds= {this.handleChangeTacoIds}
            />
          </div>
          <div className="col-md-6">
            <h5>Stores matching your requirements:</h5>
            <table>
              <thead>
                <tr>
                  {this.renderStoreTableHeader()}
                  {this.renderCityTableHeader()}
                </tr>
              </thead>
              <tbody>
                {this.state.stores.map(this.renderStores)}
              </tbody>
            </table>
          </div>
        </div>
        <div className="row">
          <div className="col-md-4 salsa-field">
            <Salsas url= '/api/v1/salsas'
                      handleChangeSalsaIds= {this.handleChangeSalsaIds}
            />
          </div>
        </div>
      </div>
    );
  }
})
