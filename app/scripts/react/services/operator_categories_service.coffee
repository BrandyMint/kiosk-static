###*global Routes, OperatorCategoriesServerActions ###

# На основе http://api.kormilica.info/#!/operator

class window.OperatorCategoriesService
  constructor: ->
    @getCategories (err, data) ->
      if !err
        OperatorCategoriesServerActions.categoriesLoaded data
      else
        console.error 'Не удалось загрузить категории', err

  getCategories: (callback) ->
    if !@mockMode
      $.ajax
        dataType: 'json'
        url:      Routes.operator_categories_url
        method:   'get'
        error: (xhr, status, err) ->
          callback err || status
        success: (data) ->
          callback null, data
    else
      that = @
      setTimeout ->
        callback null, that.mockData
      , @mockLatency

  createCategory: (data, callback) ->
    dataForServer = _.pick data, ['name', 'position', 'parent_id']
    if !@mockMode
      $.ajax
        dataType: 'json'
        url:      Routes.operator_categories_url
        data:     dataForServer
        method:   'post'
        error: (xhr, status, err) ->
          callback err || status
        success: (response) ->
          OperatorCategoriesServerActions.categoryCreated data.id, response
          if callback then callback null, response
    else
      setTimeout ->
        OperatorCategoriesServerActions.categoryCreated data.id, data
        if callback then callback null, data
      , @mockLatency

  # Пока непонятно, зачем этот маршрут в API, так как getCategories даёт
  # полную информацию по всем категориям
  getCategory: (id, callback) ->
    if !@mockMode
      $.ajax
        dataType: 'json'
        url:      Routes.operator_categories_item_url id
        method:   'get'
        error: (xhr, status, err) ->
          callback err || status
        success: (data) ->
          callback null, data
    else
      setTimeout ->
        callback null
      , @mockLatency

  updateCategory: (data, callback) ->
    id = data.id
    data = _.pick data, ['name', 'position', 'parent_id']
    if !@mockMode
      $.ajax
        dataType: 'json'
        url:      Routes.operator_categories_item_url id
        data:     data
        method:   'put'
        error: (xhr, status, err) ->
          callback err || status
        success: (data) ->
          callback null, data
    else
      setTimeout ->
        callback null
      , @mockLatency

  deleteCategory: (id, callback) ->
    if !@mockMode
      $.ajax
        dataType: 'json'
        url:      Routes.operator_categories_item_url id
        method:   'delete'
        error: (xhr, status, err) ->
          callback err || status
        success: (data) ->
          callback null, data
    else
      setTimeout ->
        callback null
      , @mockLatency

  updateCategories: (data, callback) ->
    # todo. Очень грубая замена. Надо бы делать хотя бы async.parallel
    done = _.after data.length, ->
      callback()
    that = @
    _.each data, (i) ->
      that.updateCategory i, done

  mockMode: false
  mockLatency: 500
  mockData: []
