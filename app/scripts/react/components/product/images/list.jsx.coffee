###* @jsx React.DOM ###

ProductImages_Image       = require './image'
ProductImageSortableMixin = require './mixins/sortable'

ProductImages_List = React.createClass
  mixins: [ProductImageSortableMixin]

  propTypes:
    images:         React.PropTypes.array.isRequired
    fieldName:      React.PropTypes.string
    onImagePreload: React.PropTypes.func.isRequired
    onImageDelete:  React.PropTypes.func.isRequired

  render: ->
    that = @
    images = @props.images
      .sort (a, b) -> a.position - b.position
      .map (image) ->
        `<ProductImages_Image
             image={ image }
             fieldName={ that.props.fieldName }
             onImagePreload={ that.props.onImagePreload.bind(null, image) }
             onImageDelete={ that.props.onImageDelete.bind(null, image) }
             key={ image.uuid || image.id } />`

    return `<div ref="list"
                 className="products__new-form-images-list-list">
              { images }
            </div>`

module.exports = ProductImages_List