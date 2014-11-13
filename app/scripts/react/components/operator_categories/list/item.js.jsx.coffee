###* @jsx React.DOM ###

window.OperatorCategories_Item = React.createClass
  mixins: [CategoryProductDroptarget]

  propTypes:
    category:         React.PropTypes.object.isRequired
    isActive:         React.PropTypes.bool.isRequired
    onSelectCategory: React.PropTypes.func.isRequired

  getInitialState: ->
    status: 'view'

  render: ->
    classes = React.addons.classSet {
      'adm-categories-item': true
      'selected':            @props.isActive
      '__edit':              @state.status == 'edit'
    }

    return `<div className={ classes }
                 data-objectid={ this.props.category.id }
                 onClick={ this.handleItemClick }>
              { this._getItemNode() }
            </div>`

  _getItemNode: ->
    switch @state.status
      when 'view'
        `<OperatorCategories_ItemView
             category={ this.props.category }
             onDeleteStart={ this.handleDeleteStart }
             onEditStart={ this.handleEditStart } />`
      when 'edit'
        `<OperatorCategories_ItemEdit
             category={ this.props.category }
             onFinish={ this._backToView }
             onDeleteStart={ this.handleDeleteStart } />`
      when 'delete'
        `<OperatorCategories_ItemDelete
             category={ this.props.category }
             onFinish={ this._backToView } />`

  _backToView: ->
    @setState(status: 'view')

  handleEditStart: (e) ->
    e.stopPropagation()
    e.preventDefault()
    @setState(status: 'edit')

  handleDeleteStart: (e) ->
    e.preventDefault()
    @setState(status: 'delete')

  handleItemClick: (e) ->
    e.preventDefault()
    @props.onSelectCategory @props.category