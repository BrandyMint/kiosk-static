BaseStore = require './_base'

_categories = []

window.OperatorCategoriesStore = _.extend new BaseStore(), {

  isCategoryExists: (category) ->
    return false unless category

    for _category in _categories when _category.id == category.id
      return true

    false

  pushCategories: (categories) ->
    clonedCategories = _categories[..]

    for category in categories when !@isCategoryExists category
      clonedCategories.push category

    _categories = clonedCategories

  updateCategory: (data) ->
    for _category in _categories when _category.id == data.id
      _.extend _category, data
      break

  deleteCategory: (category) ->
    clonedCategories = _categories[..]

    for clonedCategory, i in clonedCategories when clonedCategory.id == category.id
      clonedCategories.splice i, 1
      break

    _categories = clonedCategories

  getCategories: -> _categories

  getRootCategory: ->
    for _category in _categories when _category.parent_id is null
      return _category

  getCategoryLevel: (category) ->
    if category.parent_id
      1 + @getCategoryLevel( @getCategoryById(category.parent_id) )
    else
      0

  getCategoryPosition: (category) ->
    siblings = _.filter _categories, (i) -> i.parent_id == category.parent_id

    if siblings.length
      lastSibling = _.max siblings, (i) -> i.position
      lastPosition = lastSibling.position
    else
      lastPosition = -1

    lastPosition + 1

  getCategoryById: (categoryId) ->
    for _category in _categories when _category.id == categoryId
      return _category

  getSortedCategoriesByParent: (parentCategory) ->
    parentId = if parentCategory then parentCategory.id else null

    _.filter(_categories, (i) -> i.parent_id == parentId)
      .sort((a, b) -> a.position - b.position)

}

OperatorCategoriesStore.dispatchToken = OperatorCategoriesDispatcher.register (payload) ->
  action = payload.action

  switch action.type
    when 'categoriesLoaded'
      OperatorCategoriesStore.pushCategories action.categories
      OperatorCategoriesStore.emitChange()
      break
    when 'categoryLoaded'
      if OperatorCategoriesStore.isCategoryExists action.category
        OperatorCategoriesStore.updateCategory action.category
      else
        OperatorCategoriesStore.pushCategories [action.category]

      OperatorCategoriesStore.emitChange()
      break
    when 'categoryCreated'
      OperatorCategoriesStore.pushCategories [action.category]
      OperatorCategoriesStore.emitChange()
      break
    when 'categoryUpdated'
      OperatorCategoriesStore.updateCategory action.category
      OperatorCategoriesStore.emitChange()
      break
    when 'categoryDeleted'
      OperatorCategoriesStore.deleteCategory action.category
      OperatorCategoriesStore.emitChange()
      break