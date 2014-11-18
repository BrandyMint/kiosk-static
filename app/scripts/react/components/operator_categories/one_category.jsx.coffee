###* @jsx React.DOM ###

window.OperatorCategories_OneCategory = React.createClass

  propTypes:
    parentCategory:       React.PropTypes.object.isRequired
    currentCategory:      React.PropTypes.object.isRequired
    productQuery:         React.PropTypes.string
    productState:         React.PropTypes.string
    includeSubcategories: React.PropTypes.bool.isRequired
    onCategorySelect:     React.PropTypes.func.isRequired

  render: ->
   `<div className="adm-categories-grid">
      <div className="adm-categories-grid-col">
        <OperatorCategories_List
            parentCategory={ this.props.parentCategory }
            currentCategory={ this.props.currentCategory }
            includeSubcategories={ this.props.includeSubcategories }
            onCategorySelect={ this.props.onCategorySelect } />
      </div>
      <div className="adm-categories-grid-col __wide">
        <OperatorProducts
            categoryId={ this.props.currentCategory.id }
            productState={ this.props.productState }
            productQuery={ this.props.productQuery }
            includeSubcategories={ this.props.includeSubcategories } />
      </div>
    </div>`