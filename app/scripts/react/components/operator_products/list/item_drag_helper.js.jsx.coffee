###* @jsx React.DOM ###

window.OperatorProducts_ListItem_DragHelper = React.createClass

  propTypes:
    product: React.PropTypes.object.isRequired

  render: ->
   `<span className="adm-categories-goods-draghelper">
      <table>
        <tbody>
          <tr>
            <td className="adm-categories-goods-cover"
                data-title="Товар">
              <ProductThumb product={ this.props.product } />
            </td>
            <td className="adm-categories-goods-content">
              { this.props.product.title }
            </td>
          </tr>
        </tbody>
      </table>
      <hr />
      <i>
        Перетащите товар в категорию
      </i>
    </span>`

  imageUrl: ->
    AppHelpers.productImageUrl @props.product