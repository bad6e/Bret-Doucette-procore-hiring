var Search = React.createClass({

  getInitialState : function () {
    return {
      stores: '',
      checkedTacoIds: [],
      checkedSalsaIds: []
    };
  },

  findItem: function(state, id) {
    let foundItem = _.find(state, function(o) {
      return id === o;
    });
    return foundItem
  },

  removeItem: function(state, id) {
    let removeItem = _.remove(state, function(o) {
      return o != id
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
    let checkedTacoState = this.state.checkedTacoIds
    let foundTaco = this.findItem(checkedTacoState, id);

    if (foundTaco) {
      let remainingCheckedTacos = this.removeItem(checkedTacoState, id);
      this.updateTacosState(remainingCheckedTacos, this.searchTacosAndSalas)
    } else {
      let updatedCheckedTacos = checkedTacoState.slice();
      updatedCheckedTacos.push(id);
      this.updateTacosState(updatedCheckedTacos, this.searchTacosAndSalas)
    }
  },

  handleChangeSalsaIds: function(id) {
    let checkedSalsaState = this.state.checkedSalsaIds
    let foundSalsa = this.findItem(checkedSalsaState, id);

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

  searchTacosAndSalas : function() {
    console.log(this.state.checkedTacoIds)
    console.log(this.state.checkedSalsaIds)

    if (this.state.checkedTacoIds.length === 0 && this.state.checkedSalsaIds.length === 0) {
      this.setState({
        stores: ''
      })
    } else {
      $.ajax({
        url: this.formatSearchUrl(),
        dataType: 'json',
        type: 'GET',
        success:   function(stores) {
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

  renderStores: function(key) {
    let selectStore = this.state.stores[key];

    return <Store key= {selectStore.id}
                  name= {selectStore.name}
                  id= {selectStore.id}
                  city = {selectStore.city.name}
           />
  },

  render : function() {
    return (
      <div className="container">
        <div className="row">
          <div className="col-md-6">
            <TacoApi url= '/api/v1/tacos'
                     handleChangeTacoIds= {this.handleChangeTacoIds}
            />
          </div>

          <div className="col-md-6">
            <h5>Stores matching your requirements:</h5>
            <table>
              <thead>
                <tr>
                  <th>Store</th>
                  <th>City</th>
                </tr>
              </thead>
              <tbody>
                {Object.keys(this.state.stores).map(this.renderStores)}
              </tbody>
            </table>

          </div>
        </div>
        <div className="row">
          <div className="col-md-4">
            <SalsaApi url= '/api/v1/salsas'
                      handleChangeSalsaIds= {this.handleChangeSalsaIds}
            />
          </div>
        </div>
      </div>
    );
  }
})
