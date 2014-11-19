BaseStore = require './_base'

_draggedProducts  = []
_selectedProducts = []

window.DragStateStore = _.extend new BaseStore(), {

  isDragged: -> _draggedProducts.length > 0

  isMultipleSelected: -> _selectedProducts.length > 1

  isSelectedProductExists: (product) ->
    for _selectedProduct in _selectedProducts when _selectedProduct.id == product.id
      return true

    false

  isDraggedProductExists: (product) ->
    for _draggedProduct in _draggedProducts when _draggedProduct.id == product.id
      return true

    false

  pushDraggedProduct: (product) ->
    unless @isDraggedProductExists product
      _draggedProducts.push product

  deleteDraggedProduct: (product) ->
    clonedDraggedProducts = _draggedProducts[..]

    for clonedDraggedProduct, i in clonedDraggedProducts when clonedDraggedProduct.id == product.id
      clonedDraggedProducts.splice i, 1
      break

    _draggedProducts = clonedDraggedProducts

  pushSelectedProduct: (product) ->
    unless @isSelectedProductExists product
      _selectedProducts.push product

  deleteSelectedProduct: (product) ->
    clonedSelectedProducts = _selectedProducts[..]

    for clonedSelectedProduct, i in clonedSelectedProducts when clonedSelectedProduct.id == product.id
      clonedSelectedProducts.splice i, 1
      break

    _selectedProducts = clonedSelectedProducts

  resetProducts: ->
    _draggedProducts  = []
    _selectedProducts = []

  getDraggedProducts:  -> _draggedProducts
  getSelectedProducts: -> _selectedProducts

}

DragStateDispatcher.register (payload) ->
  action = payload.action

  switch action.type
    when 'productBecameDraggable'
      DragStateStore.pushDraggedProduct action.product
      DragStateStore.emitChange()
      break
    when 'productBecameStatic'
      DragStateStore.deleteDraggedProduct action.product
      DragStateStore.emitChange()
      break
    when 'productBecameSelected'
      DragStateStore.pushSelectedProduct action.product
      break
    when 'productBecameUnselected'
      DragStateStore.deleteSelectedProduct action.product
      break
    when 'productsMoved'
      DragStateStore.resetProducts()
      break
    when 'currentCategoryChanged'
      #TODO: Need handle this event from other dispatcher
      DragStateStore.resetProducts() unless DragStateStore.isDragged()
      break