window.OperatorProductsServerActions =

  receiveProducts: (categoryId, products) ->
    OperatorProductsDispatcher.handleServerAction
      type: 'productsLoaded'
      categoryId: categoryId
      products: products

  receiveMoreProducts: (categoryId, products) ->
    OperatorProductsDispatcher.handleServerAction
      type: 'moreProductsLoaded'
      categoryId: categoryId
      products: products

  moveProduct: ({productId, categoryId}) ->
    #TODO: increment newCategoryId counter without additional get request
    OperatorProductsDispatcher.handleServerAction
      type: 'productMoved'
      categoryId: categoryId
      productId: productId